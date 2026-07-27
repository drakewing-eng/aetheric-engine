extends SceneTree
## Headless structural checks for graphics goal.
## Godot --headless --path . -s res://scripts/test_graphics_assets.gd

func _init() -> void:
	var failed := 0
	var ids := ["selina", "bell", "amara", "rooke", "clara", "elspeth"]
	for id in ids:
		var path := "res://assets/characters/sprites/sprite_%s.png" % id
		if not ResourceLoader.exists(path):
			push_error("MISSING sprite: " + path)
			failed += 1
		else:
			var tex: Texture2D = load(path)
			if tex == null:
				push_error("LOAD FAIL: " + path)
				failed += 1
			elif tex.get_height() < 200:
				push_error("SPRITE TOO SMALL: " + path)
				failed += 1
			else:
				print("OK sprite ", id, " ", tex.get_width(), "x", tex.get_height())

	var rooms_src := FileAccess.get_file_as_string("res://scripts/fps_rooms.gd")
	for needle in [
		"wallpaper_drawing.jpg",
		"wallpaper_hall.jpg",
		"wallpaper_gallery.jpg",
		"wallpaper_kitchen.jpg",
		"wallpaper_workshop.jpg",
		"wallpaper_conservatory.jpg",
		"wallpaper_morning.jpg",
		"kitchen_range",
		"aetheric_machine",
		"sprite_bell.png",
		"sprite_selina.png",
		"sprite_amara.png",
		"sprite_rooke.png",
		"sprite_clara.png",
		"sprite_elspeth.png",
	]:
		if rooms_src.find(needle) < 0:
			push_error("fps_rooms.gd missing: " + needle)
			failed += 1
		else:
			print("OK rooms ref ", needle)

	var npc_src := FileAccess.get_file_as_string("res://scripts/fps_npc.gd")
	if npc_src.find("CharacterSprite") < 0 or npc_src.find("ALPHA_SCISSOR") < 0:
		push_error("fps_npc.gd not using opaque alpha-scissor character mesh")
		failed += 1
	else:
		print("OK fps_npc opaque character billboard")
	if npc_src.find("body_mesh.visible = false") < 0:
		push_error("capsule not hidden when sprite present")
		failed += 1
	else:
		print("OK capsule hidden for sprite path")
	if npc_src.find("sprite_path_for") < 0:
		push_error("missing sprite_path_for helper")
		failed += 1
	else:
		print("OK sprite_path_for helper")

	for tex in [
		"res://assets/rooms/textures/victorian/wallpaper_drawing.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_hall.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_gallery.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_kitchen.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_workshop.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_conservatory.jpg",
		"res://assets/rooms/textures/victorian/wallpaper_morning.jpg",
		"res://assets/rooms/textures/victorian/floor_drawing.jpg",
		"res://assets/rooms/textures/victorian/floor_kitchen.jpg",
		"res://assets/rooms/textures/victorian/floor_workshop.jpg",
		"res://assets/rooms/textures/victorian/floor_conservatory.jpg",
		"res://assets/rooms/textures/victorian/floor_morning.jpg",
		"res://assets/rooms/textures/victorian/wainscot_drawing.jpg",
		"res://assets/rooms/textures/victorian/metal_copper.jpg",
		"res://assets/props/drawing_room/sofa.png",
		"res://assets/props/drawing_room/desk.png",
		"res://assets/props/drawing_room/armchair.png",
	]:
		if not ResourceLoader.exists(tex):
			push_error("MISSING victorian tex: " + tex)
			failed += 1
		else:
			print("OK tex ", tex)

	if failed > 0:
		print("FAIL test_graphics_assets failed=", failed)
		quit(1)
	else:
		print("PASS test_graphics_assets")
		quit(0)
