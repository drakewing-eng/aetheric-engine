extends SceneTree
## Headless checks for Bell walk textures + shipped frame-selection logic.
## Run: Godot --headless --path . --script res://scripts/test_bell_walk.gd

const SPRITE_DIR := "res://assets/characters/sprites/"


func _init() -> void:
	var failed := 0
	print("=== test_bell_walk ===")

	# --- Texture loads (same paths as fps_npc) ---
	var idle_path := SPRITE_DIR + "sprite_bell.png"
	var idle := _load_tex_no_mip(idle_path)
	if idle == null:
		print("FAIL: idle texture null: ", idle_path)
		failed += 1
	else:
		print("OK idle load size=", idle.get_width(), "x", idle.get_height())

	var walk: Array = []
	var sizes_ok := true
	var first_w := -1
	var first_h := -1
	for i in 4:
		var p := SPRITE_DIR + "sprite_bell_walk_%d.png" % i
		var t := _load_tex_no_mip(p)
		if t == null:
			print("FAIL: walk frame null: ", p)
			failed += 1
			sizes_ok = false
			continue
		walk.append(t)
		if first_w < 0:
			first_w = t.get_width()
			first_h = t.get_height()
		elif t.get_width() != first_w or t.get_height() != first_h:
			print("FAIL: walk size mismatch frame ", i, " got ", t.get_width(), "x", t.get_height(),
				" want ", first_w, "x", first_h)
			failed += 1
			sizes_ok = false
		else:
			print("OK walk_", i, " size=", t.get_width(), "x", t.get_height())

	if sizes_ok and walk.size() == 4 and idle != null:
		if idle.get_width() != first_w or idle.get_height() != first_h:
			# Soft warning — plan wants walk frames same as each other; idle match is preferred
			print("NOTE: idle size ", idle.get_width(), "x", idle.get_height(),
				" vs walk ", first_w, "x", first_h)

	# Hard-alpha sample via re-load as Image (shipped PNG on disk)
	for i in 4:
		var abs_p := ProjectSettings.globalize_path(SPRITE_DIR + "sprite_bell_walk_%d.png" % i)
		var img := Image.new()
		if img.load(abs_p) != OK:
			print("FAIL: cannot Image.load ", abs_p)
			failed += 1
			continue
		var semi := 0
		var opaque := 0
		var dark_solid := 0
		var dark_transp := 0
		for y in range(img.get_height()):
			for x in range(img.get_width()):
				var c := img.get_pixel(x, y)
				var a := c.a
				if a > 0.02 and a < 0.98:
					semi += 1
				if a >= 0.98:
					opaque += 1
					# dark clothing sample (luma low)
					var luma := 0.299 * c.r + 0.587 * c.g + 0.114 * c.b
					if luma < 0.25:
						dark_solid += 1
				elif a < 0.02:
					# transparent pixel — fine for background
					pass
		print("OK walk_", i, " hard-alpha semi=", semi, " opaque=", opaque, " dark_solid=", dark_solid)
		if semi > 50:
			print("FAIL: walk_", i, " has too many semi-transparent pixels: ", semi)
			failed += 1
		if dark_solid < 500:
			print("FAIL: walk_", i, " dark clothing region too small / transparent: ", dark_solid)
			failed += 1

	# --- Shipped frame logic (fps_npc static) ---
	# Preload script class
	var NpcScript = load("res://scripts/fps_npc.gd")
	if NpcScript == null:
		print("FAIL: cannot load fps_npc.gd")
		failed += 1
	else:
		# Call static methods via script
		var seen := {}
		var dist := 0.0
		var step := 0.08
		var cycle := 0.55
		for k in 40:
			dist += step
			var fi: int = NpcScript.select_walk_frame(dist, cycle, 4)
			seen[fi] = true
			if fi < 0 or fi > 3:
				print("FAIL: frame out of range ", fi, " at dist ", dist)
				failed += 1
		for need in [0, 1, 2, 3]:
			if not seen.has(need):
				print("FAIL: never reached walk frame ", need, " keys=", seen.keys())
				failed += 1
		if seen.size() == 4:
			print("OK frame sequence visits all indices: ", seen.keys())

		if NpcScript.should_use_idle(true) != true:
			print("FAIL: should_use_idle(true) expected true")
			failed += 1
		else:
			print("OK should_use_idle(true)")
		if NpcScript.should_use_idle(false) != false:
			print("FAIL: should_use_idle(false) expected false")
			failed += 1
		else:
			print("OK should_use_idle(false)")

		# Other NPC path: selina has no walk sheets → load idle only
		var selina := _load_tex_no_mip(SPRITE_DIR + "sprite_selina.png")
		if selina == null:
			print("FAIL: selina static sprite missing")
			failed += 1
		else:
			print("OK other NPC idle loads (selina)")
		var selina_w0 := _load_tex_no_mip(SPRITE_DIR + "sprite_selina_walk_0.png")
		if selina_w0 != null:
			print("NOTE: selina unexpectedly has walk_0")
		else:
			print("OK selina has no walk cycle (static path)")

	if failed == 0:
		print("=== ALL PASS ===")
		quit(0)
	else:
		print("=== FAILED count=", failed, " ===")
		quit(1)


func _load_tex_no_mip(tex_path: String) -> Texture2D:
	var abs_path := ProjectSettings.globalize_path(tex_path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		if img.load(abs_path) == OK:
			return ImageTexture.create_from_image(img)
	return null
