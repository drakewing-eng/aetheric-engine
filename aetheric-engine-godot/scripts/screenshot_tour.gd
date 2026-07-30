extends SceneTree
## Automated visual QA tour: build every room, place camera, save PNGs.
## Run (needs a real window for Metal framebuffer):
##   Godot --path . -s res://scripts/screenshot_tour.gd --resolution 1280x720
## Output: user://screenshots/ and mirrored to SCRATCH if possible.

const OUT_REL := "user://screenshots"
const RoomBuilderScript := preload("res://scripts/fps_room_builder.gd")
const NpcScene := preload("res://scenes/fps_npc.tscn")

var _root3d: Node3D
var _builder: Node3D
var _npc_root: Node3D
var _camera: Camera3D
var _viewport: Viewport
var _out_abs: String = ""
var _shots: PackedStringArray = []

func _init() -> void:
	print("=== Aetheric screenshot tour starting ===")
	call_deferred("_boot")

func _boot() -> void:
	_setup_world()
	await _run_tour()

func _setup_world() -> void:
	_viewport = root
	# Prefer the main window viewport
	var win := root.get_window()
	if win:
		win.size = Vector2i(1280, 720)
		win.title = "Aetheric Screenshot Tour"
		win.mode = Window.MODE_WINDOWED

	_root3d = Node3D.new()
	_root3d.name = "ShotWorld"
	root.add_child(_root3d)

	var env := WorldEnvironment.new()
	var e := Environment.new()
	e.background_mode = Environment.BG_COLOR
	e.background_color = Color(0.22, 0.16, 0.12)
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	e.ambient_light_color = Color(0.72, 0.65, 0.55)
	e.ambient_light_energy = 0.85
	e.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	e.tonemap_exposure = 1.05
	env.environment = e
	_root3d.add_child(env)

	var sun := DirectionalLight3D.new()
	sun.light_energy = 0.85
	sun.shadow_enabled = true
	sun.rotation_degrees = Vector3(-45, 35, 0)
	_root3d.add_child(sun)

	var fill := OmniLight3D.new()
	fill.light_color = Color(1.0, 0.88, 0.72)
	fill.light_energy = 0.7
	fill.omni_range = 20.0
	fill.position = Vector3(0, 2.8, 0)
	_root3d.add_child(fill)

	_builder = RoomBuilderScript.new()
	_builder.name = "RoomBuilder"
	_root3d.add_child(_builder)

	_npc_root = Node3D.new()
	_npc_root.name = "Npcs"
	_root3d.add_child(_npc_root)

	_camera = Camera3D.new()
	_camera.current = true
	_camera.fov = 58.0
	_camera.near = 0.08
	_camera.far = 80.0
	_root3d.add_child(_camera)

	# Resolve output dir (user:// + absolute SCRATCH mirror)
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUT_REL))
	_out_abs = ProjectSettings.globalize_path(OUT_REL)
	var scratch := "/Users/babble/aetheric-engine/SCRATCH/screenshots"
	DirAccess.make_dir_recursive_absolute(scratch)
	print("Output: ", _out_abs, " + ", scratch)

func _run_tour() -> void:
	# Let window / renderer settle
	for i in 12:
		await process_frame

	var room_ids := [
		"drawing_room",
		"entrance_hall",
		"gallery",
		"kitchen",
		"workshop",
		"conservatory",
		"morning_room",
	]

	for rid in room_ids:
		await _shoot_room(rid)

	# Character close-ups: rooms that host NPCs
	await _shoot_npc_closeups()

	_write_manifest()
	print("=== Screenshot tour complete: %d shots ===" % _shots.size())
	for s in _shots:
		print("SHOT ", s)
	quit(0)

func _shoot_room(room_id: String) -> void:
	var room: Dictionary = FpsRooms.get_room(room_id)
	print("Building room ", room_id, " …")
	_builder.build(room)
	_clear_npcs()
	_spawn_npcs(room.get("npcs", []))
	for i in 6:
		await process_frame

	var size: Array = room.get("size", [8, 8, 3.5])
	var w: float = float(size[0])
	var d: float = float(size[1])
	var spawn: Array = room.get("spawn", [0, 0, 0])
	var spawn_yaw: float = float(room.get("spawn_yaw", 0.0))

	# View 1: spawn eye-level looking spawn_yaw (nudge inward if spawn is near a wall)
	var sx := float(spawn[0])
	var sz := float(spawn[2])
	var half_w := w * 0.5
	var half_d := d * 0.5
	# Keep camera at least ~1.6m inside walls so we never clip into door leaves
	sx = clampf(sx, -half_w + 1.6, half_w - 1.6)
	sz = clampf(sz, -half_d + 1.6, half_d - 1.6)
	await _capture(
		room_id + "_spawn",
		Vector3(sx, 1.65, sz),
		spawn_yaw,
		0.0
	)

	# View 2: from south looking north (Godot yaw 0 = look −Z)
	# Stand well inside the south wall so ajar doors don't fill the frame.
	await _capture(
		room_id + "_from_south",
		Vector3(0.0, 1.7, half_d - 1.85),
		0.0,
		-5.0
	)

	# View 3: from north looking south (yaw 180 = look +Z)
	# Loop 148: gallery engine at z≈-3.2 — stay behind it (z≤-5) or offset so we never sit inside coils
	var north_z := -half_d + 1.85
	var north_y := 1.7
	var north_pitch := -5.0
	var north_x := 0.0
	if room_id == "gallery":
		north_x = 1.8
		north_z = -5.15
		north_y = 1.9
		north_pitch = -6.0
	await _capture(
		room_id + "_from_north",
		Vector3(north_x, north_y, north_z),
		180.0,
		north_pitch
	)

	# View 4: elevated corner overview
	await _capture(
		room_id + "_corner",
		Vector3(-w * 0.28, 2.1, d * 0.28),
		-35.0,
		-12.0
	)

	# View 5: props/furniture focus (center of room, slightly low)
	await _capture(
		room_id + "_center",
		Vector3(0.0, 1.45, 0.0),
		spawn_yaw + 40.0,
		-8.0
	)

func _shoot_npc_closeups() -> void:
	## Visit rooms with NPCs and frame each character.
	var hosts := {
		"drawing_room": ["bell", "selina"],
		"gallery": ["amara"],
		"kitchen": ["clara"],
		"workshop": ["rooke"],
		"morning_room": ["elspeth"],
	}
	for rid in hosts.keys():
		var room: Dictionary = FpsRooms.get_room(rid)
		_builder.build(room)
		_clear_npcs()
		_spawn_npcs(room.get("npcs", []))
		for i in 6:
			await process_frame
		for npc in _npc_root.get_children():
			var id_str := _npc_id_of(npc)
			if id_str == "":
				id_str = str(npc.name).to_lower()
			var pos: Vector3 = npc.global_position
			# Stand ~2m in front of NPC, look at mid torso
			var cam_pos := pos + Vector3(0.0, 1.35, 1.9)
			_camera.global_position = cam_pos
			_camera.look_at(pos + Vector3(0, 1.0, 0), Vector3.UP)
			for i in 5:
				await process_frame
			await RenderingServer.frame_post_draw
			var path: String = await _save_frame("%s_npc_%s" % [rid, id_str])
			print("NPC shot ", path)

func _npc_id_of(npc: Node) -> String:
	if npc.has_meta("npc_id"):
		return str(npc.get_meta("npc_id"))
	if "npc_id" in npc:
		return str(npc.npc_id)
	if "id" in npc:
		return str(npc.id)
	# setup may store on name
	var n := npc.name.to_lower()
	for cand in ["bell", "selina", "amara", "clara", "rooke", "elspeth"]:
		if n.find(cand) >= 0:
			return cand
	return ""

func _clear_npcs() -> void:
	for c in _npc_root.get_children():
		c.queue_free()

func _spawn_npcs(npcs: Array) -> void:
	for data in npcs:
		var npc := NpcScene.instantiate()
		_npc_root.add_child(npc)
		if npc.has_method("setup"):
			npc.setup(data)
		if data.has("id"):
			npc.set_meta("npc_id", data["id"])
		# Place at first patrol point if present
		var patrol: Array = data.get("patrol", [])
		if patrol.size() > 0:
			var p: Array = patrol[0]
			npc.position = Vector3(float(p[0]), float(p[1]), float(p[2]))
		else:
			npc.position = Vector3(0, 0, 0)

func _capture(name: String, pos: Vector3, yaw_deg: float, pitch_deg: float) -> void:
	_camera.global_position = pos
	_camera.rotation_degrees = Vector3(pitch_deg, yaw_deg, 0.0)
	for i in 4:
		await process_frame
	await RenderingServer.frame_post_draw
	await _save_frame(name)

func _save_frame(name: String) -> String:
	var tex: ViewportTexture = root.get_texture()
	if tex == null:
		push_error("No viewport texture for " + name)
		return ""
	var img: Image = tex.get_image()
	if img == null:
		push_error("No image for " + name)
		return ""
	# Flip if needed (Godot viewport images can be inverted on some backends)
	# img.flip_y() — only if upside down; try both later if wrong
	var fname := "%s.png" % name
	var user_path := OUT_REL.path_join(fname)
	var err := img.save_png(user_path)
	if err != OK:
		push_error("save_png failed %s err=%s" % [user_path, err])
	var abs_user := ProjectSettings.globalize_path(user_path)
	var scratch := "/Users/babble/aetheric-engine/SCRATCH/screenshots".path_join(fname)
	# Copy to SCRATCH for easy analysis
	var abs_img := Image.new()
	if abs_img.load(abs_user) == OK:
		abs_img.save_png(scratch)
	else:
		# direct save
		img.save_png(scratch)
	_shots.append(scratch)
	print("Saved ", scratch, " size=", img.get_width(), "x", img.get_height())
	return scratch

func _write_manifest() -> void:
	var lines: PackedStringArray = []
	lines.append("# Screenshot tour manifest")
	lines.append("count: %d" % _shots.size())
	for s in _shots:
		lines.append("- " + s)
	var body := "\n".join(lines) + "\n"
	var f := FileAccess.open("/Users/babble/aetheric-engine/SCRATCH/screenshots/MANIFEST.md", FileAccess.WRITE)
	if f:
		f.store_string(body)
		f.close()
	var f2 := FileAccess.open(OUT_REL.path_join("MANIFEST.md"), FileAccess.WRITE)
	if f2:
		f2.store_string(body)
		f2.close()
