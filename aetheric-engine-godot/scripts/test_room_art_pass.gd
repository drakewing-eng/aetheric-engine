extends SceneTree
## Near-final art pass: build every room, assert distinct materials + kitchen identity.
## Godot --headless --path . -s res://scripts/test_room_art_pass.gd

func _init() -> void:
	var failed := 0
	var Rooms := load("res://scripts/fps_rooms.gd")
	var Builder := load("res://scripts/fps_room_builder.gd")
	if Rooms == null or Builder == null:
		push_error("Failed to load rooms/builder scripts")
		quit(1)
		return

	var room_ids := [
		"drawing_room", "entrance_hall", "gallery",
		"kitchen", "workshop", "conservatory", "morning_room",
	]
	var wallpapers: Dictionary = {}
	var prop_kinds_by_room: Dictionary = {}

	for rid in room_ids:
		var room: Dictionary = Rooms.get_room(rid)
		if room.is_empty():
			push_error("Empty room: " + rid)
			failed += 1
			continue
		var paper: String = str(room.get("wallpaper", ""))
		var floor: String = str(room.get("floor_texture", ""))
		var wainscot: String = str(room.get("wainscot", ""))
		if paper == "" or floor == "" or wainscot == "":
			push_error("%s missing wall/floor/wainscot" % rid)
			failed += 1
		else:
			wallpapers[rid] = paper
			print("OK materials ", rid, " paper=", paper.get_file())

		# Texture must load
		for path in [paper, floor, wainscot]:
			if path == "":
				continue
			if not ResourceLoader.exists(path):
				# Runtime load path may still work
				var abs_path := ProjectSettings.globalize_path(path)
				if not FileAccess.file_exists(abs_path):
					push_error("Missing texture file: " + path)
					failed += 1
				else:
					print("OK file ", path.get_file())
			else:
				print("OK resource ", path.get_file())

		var kinds: Array = []
		for p in room.get("props", []):
			kinds.append(str(p.get("kind", "")))
		prop_kinds_by_room[rid] = kinds

		# Actually build the room under a temporary node
		var host := Node3D.new()
		root.add_child(host)
		var builder = Builder.new()
		host.add_child(builder)
		builder.build(room)
		var child_count: int = int(builder.get_child_count())
		if child_count < 5:
			push_error("%s built too few nodes: %d" % [rid, child_count])
			failed += 1
		else:
			print("OK build ", rid, " nodes=", child_count)
		host.queue_free()

	# Kitchen identity: must have range/dresser/sink, not only workbench
	var kprops: Array = prop_kinds_by_room.get("kitchen", [])
	for need in ["kitchen_range", "dresser", "sink", "prep_table"]:
		if need not in kprops:
			push_error("Kitchen missing signature prop: " + need)
			failed += 1
		else:
			print("OK kitchen has ", need)
	if "workbench" in kprops:
		push_error("Kitchen still uses workbench as furniture — identity fail")
		failed += 1
	else:
		print("OK kitchen has no workbench")

	# Gallery hero machine
	var gprops: Array = prop_kinds_by_room.get("gallery", [])
	if "aetheric_machine" not in gprops:
		push_error("Gallery missing aetheric_machine")
		failed += 1
	else:
		print("OK gallery aetheric_machine")

	# Conservatory plants + glass + garden furniture (loop 77)
	var cprops: Array = prop_kinds_by_room.get("conservatory", [])
	if "plant" not in cprops:
		push_error("Conservatory missing plants")
		failed += 1
	else:
		print("OK conservatory plants")
	if "garden_bench" not in cprops:
		push_error("Conservatory missing garden_bench (empty glass room)")
		failed += 1
	else:
		print("OK conservatory garden_bench")
	var crooms: Dictionary = Rooms.get_room("conservatory")
	var has_glass := false
	for f in crooms.get("features", []):
		if str(f.get("kind", "")) == "glass_wall":
			has_glass = true
	if not has_glass:
		push_error("Conservatory missing glass_wall features")
		failed += 1
	else:
		print("OK conservatory glass_wall")


	# Loop 161: drawing room seating is solid mesh (sofa + armchair), not paper cutouts
	var dprops: Array = prop_kinds_by_room.get("drawing_room", [])
	if "sofa" not in dprops:
		push_error("Drawing room missing mesh sofa hero")
		failed += 1
	else:
		print("OK drawing_room mesh sofa present")
	if "armchair" not in dprops:
		push_error("Drawing room missing mesh armchair")
		failed += 1
	else:
		print("OK drawing_room mesh armchair present")
	if "ottoman" not in dprops:
		push_error("Drawing room missing ottoman")
		failed += 1
	else:
		print("OK drawing_room ottoman present")

	# Alpha integrity on hero PNGs (must not be studio-opaque)
	for hero in ["sofa", "armchair", "chair", "desk", "side_table"]:
		var hpath := "res://assets/props/drawing_room/%s.png" % hero
		var abs_h := ProjectSettings.globalize_path(hpath)
		if not FileAccess.file_exists(abs_h):
			push_error("Missing hero PNG: " + hpath)
			failed += 1
			continue
		var img := Image.new()
		if img.load(abs_h) != OK:
			push_error("Failed load hero PNG: " + hpath)
			failed += 1
			continue
		if img.get_format() != Image.FORMAT_RGBA8:
			img.convert(Image.FORMAT_RGBA8)
		var w: int = img.get_width()
		var h: int = img.get_height()
		var transparent := 0
		var samples := 0
		# Sample corners + grid for alpha
		for pt in [
			Vector2i(0, 0), Vector2i(w - 1, 0), Vector2i(0, h - 1), Vector2i(w - 1, h - 1),
			Vector2i(2, 2), Vector2i(w - 3, 2), Vector2i(2, h - 3), Vector2i(w - 3, h - 3),
		]:
			var c: Color = img.get_pixelv(pt)
			samples += 1
			if c.a < 0.15:
				transparent += 1
		if transparent < 4:
			push_error("Hero PNG still has opaque corners (square bg): " + hero)
			failed += 1
		else:
			print("OK alpha corners ", hero, " transparent=", transparent, "/", samples)

	# Distinct wallpapers across secondary rooms
	var secondary := ["kitchen", "workshop", "conservatory", "morning_room"]
	var papers: Array = []
	for rid in secondary:
		var p: String = wallpapers.get(rid, "")
		if p in papers:
			push_error("Duplicate wallpaper between secondary rooms: " + p)
			failed += 1
		papers.append(p)
	print("OK secondary wallpapers distinct count=", papers.size())

	# Hall coat identity
	var hprops: Array = prop_kinds_by_room.get("entrance_hall", [])
	if "coat_stand" not in hprops:
		push_error("Hall missing coat_stand")
		failed += 1
	else:
		print("OK hall coat_stand")
	# Hall should have at least one hall_table (loop 73: two consoles)
	var hall_tables := 0
	for p in Rooms.get_room("entrance_hall").get("props", []):
		if str(p.get("kind", "")) == "hall_table":
			hall_tables += 1
	if hall_tables < 1:
		push_error("Hall missing hall_table")
		failed += 1
	else:
		print("OK hall_table count=", hall_tables)

	# Door spawn safety: every door spawn must land inside target room footprint
	for rid in room_ids:
		var room: Dictionary = Rooms.get_room(rid)
		var size: Array = room.get("size", [8, 8, 3])
		var half_w: float = float(size[0]) * 0.5 - 0.4
		var half_d: float = float(size[1]) * 0.5 - 0.4
		for door in room.get("doors", []):
			var target: String = str(door.get("target", ""))
			var troom: Dictionary = Rooms.get_room(target)
			if troom.is_empty():
				push_error("%s door target missing: %s" % [rid, target])
				failed += 1
				continue
			var tsize: Array = troom.get("size", [8, 8, 3])
			var thw: float = float(tsize[0]) * 0.5 - 0.35
			var thd: float = float(tsize[1]) * 0.5 - 0.35
			var sp: Array = door.get("spawn", [0, 0, 0])
			var sx := float(sp[0]) if sp.size() > 0 else 0.0
			var sz := float(sp[2]) if sp.size() > 2 else 0.0
			# After inward nudge of 0.55, still must be on floor plane inside room
			if absf(sx) > thw + 0.6 or absf(sz) > thd + 0.6:
				push_error("%s→%s spawn far outside room: (%.2f, %.2f)" % [rid, target, sx, sz])
				failed += 1
			else:
				print("OK door spawn ", rid, "→", target, " @(", sx, ",", sz, ")")
			if not door.has("spawn_yaw") and not door.has("spawn"):
				push_error("%s door missing spawn" % rid)
				failed += 1

	if failed > 0:
		print("FAIL test_room_art_pass failed=", failed)
		quit(1)
	else:
		print("PASS test_room_art_pass")
		quit(0)
