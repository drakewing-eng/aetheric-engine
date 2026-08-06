extends SceneTree
## Capture Bell walk + sit in Drawing Room for motion QA.
## Godot --path . --resolution 1280x720 -s res://scripts/screenshot_bell_motion.gd

const OUT_USER := "user://screenshots/bell_motion"
const SCRATCH := "/Users/babble/ gemini/antigravity/playground/aetheric-engine/SCRATCH/screenshots/bell_motion"
const NpcScene := preload("res://scenes/fps_npc.tscn")
const Rooms := preload("res://scripts/fps_rooms.gd")
const NpcActivityScr := preload("res://scripts/npc_activity.gd")

var _root3d: Node3D
var _world: Node3D
var _cam: Camera3D
var _npc: Node3D


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	print("=== screenshot_bell_motion ===")
	_setup_scene()
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUT_USER))
	DirAccess.make_dir_recursive_absolute(SCRATCH)

	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("drawing_room")

	var room: Dictionary = Rooms.get_room("drawing_room")
	_build_room_visual(room)

	_npc = NpcScene.instantiate()
	_world.add_child(_npc)
	_npc.setup({
		"id": "bell",
		"name": "Ignatius Bell",
		"height": 1.78,
		"room_id": "drawing_room",
		"use_activity": true,
		"patrol": [[-2.5, 0, 1.0], [2.5, 0, 1.0]],
		"speed": 1.1,
		"dwell_sec": 8.0,
		"model": "res://assets/characters/models/bell/final/bell_runtime.tscn",
		"tint_victorian": false,
	})
	_npc.global_position = Vector3(-2.2, 0.0, 1.0)
	# Force walk along X
	if _npc.has_method("_set_state_walk"):
		_npc._set_state_walk()
	if _npc.has_method("get_navigation_agent") and _npc.get_navigation_agent():
		_npc.get_navigation_agent().set_target_position(Vector3(2.5, 0.0, 1.0))
	_npc.set("_going_to_slot", true)
	_npc.set("_slot_target", Vector3(2.5, 0.0, 1.0))
	_npc.set("_intended_activity", _npc._name_to_state(NpcActivityScr.STATE_SIT) if _npc.has_method("_name_to_state") else 2)

	# Walk frames
	for i in 24:
		if _npc.has_method("_physics_process"):
			_npc._physics_process(0.05)
		await process_frame
		if i in [4, 10, 16, 22]:
			_place_cam_side(_npc.global_position)
			await _shot("walk_side_%02d" % i)
			_place_cam_three_quarter(_npc.global_position)
			await _shot("walk_3q_%02d" % i)

	# Force sit on sofa, then desk chair
	for slot_id in ["sofa_sit", "desk_write"]:
		if not NpcActivityScr.claim_slot("drawing_room", slot_id, "bell"):
			# free prior
			NpcActivityScr.release_slot("drawing_room", "sofa_sit", "bell")
			NpcActivityScr.release_slot("drawing_room", "desk_write", "bell")
			if not NpcActivityScr.claim_slot("drawing_room", slot_id, "bell"):
				continue
		var sm: Dictionary = NpcActivityScr.get_slot("drawing_room", slot_id)
		_npc.set("_slot_id", slot_id)
		_npc.set("_slot_target", NpcActivityScr.slot_position(sm))
		_npc.set("_slot_yaw", NpcActivityScr.slot_yaw_rad(sm))
		_npc.set("_slot_seat_height", NpcActivityScr.slot_seat_height(sm))
		_npc.global_position = Vector3(
			NpcActivityScr.slot_position(sm).x,
			0.0,
			NpcActivityScr.slot_position(sm).z
		)
		var sit_state = _npc._name_to_state(NpcActivityScr.STATE_SIT)
		if slot_id == "desk_write":
			# desk uses Read but we still want seat plant — force Sit for QA photo
			pass
		if _npc.has_method("_enter_activity_state"):
			_npc._enter_activity_state(sit_state)
		elif _npc.has_method("_set_state_sit"):
			_npc._set_state_sit()
		for i in 16:
			if _npc.has_method("_physics_process"):
				_npc._physics_process(0.05)
			await process_frame
		print("OK sit plant slot=", slot_id, " y=", _npc.global_position.y, " seat_h=", NpcActivityScr.slot_seat_height(sm))
		_place_cam_sit(_npc.global_position)
		await _shot("sit_%s_front" % slot_id)
		_place_cam_three_quarter(_npc.global_position + Vector3(0, 0.15, 0))
		await _shot("sit_%s_3q" % slot_id)
		_place_cam_side(_npc.global_position)
		await _shot("sit_%s_side" % slot_id)
		NpcActivityScr.release_slot("drawing_room", slot_id, "bell")

	print("=== screenshot_bell_motion DONE out=", SCRATCH, " ===")
	quit(0)


func _setup_scene() -> void:
	_root3d = Node3D.new()
	root.add_child(_root3d)
	_world = Node3D.new()
	_world.name = "World"
	_root3d.add_child(_world)
	var env := WorldEnvironment.new()
	var e := Environment.new()
	e.background_mode = Environment.BG_COLOR
	e.background_color = Color(0.55, 0.58, 0.62)
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	e.ambient_light_color = Color(0.75, 0.72, 0.68)
	e.ambient_light_energy = 0.85
	env.environment = e
	_root3d.add_child(env)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-45, 35, 0)
	sun.light_energy = 1.1
	_root3d.add_child(sun)
	_cam = Camera3D.new()
	_cam.current = true
	_cam.fov = 50.0
	_root3d.add_child(_cam)
	# Simple floor
	var floor_mi := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(12, 0.05, 12)
	floor_mi.mesh = box
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.35, 0.28, 0.22)
	floor_mi.material_override = mat
	floor_mi.position.y = -0.025
	_world.add_child(floor_mi)
	# Sofa proxy (visual only)
	var sofa := MeshInstance3D.new()
	var sb := BoxMesh.new()
	sb.size = Vector3(2.2, 0.45, 0.85)
	sofa.mesh = sb
	var sm := StandardMaterial3D.new()
	sm.albedo_color = Color(0.25, 0.4, 0.28)
	sofa.material_override = sm
	sofa.position = Vector3(0.0, 0.22, -3.2)
	_world.add_child(sofa)
	var back := MeshInstance3D.new()
	var bb := BoxMesh.new()
	bb.size = Vector3(2.2, 0.7, 0.15)
	back.mesh = bb
	back.material_override = sm
	back.position = Vector3(0.0, 0.55, -3.55)
	_world.add_child(back)


func _build_room_visual(_room: Dictionary) -> void:
	pass


func _place_cam_side(at: Vector3) -> void:
	_cam.global_position = at + Vector3(0.0, 1.35, 2.8)
	_cam.look_at(at + Vector3(0, 0.9, 0), Vector3.UP)


func _place_cam_three_quarter(at: Vector3) -> void:
	_cam.global_position = at + Vector3(2.2, 1.5, 2.2)
	_cam.look_at(at + Vector3(0, 0.95, 0), Vector3.UP)


func _place_cam_sit(at: Vector3) -> void:
	_cam.global_position = at + Vector3(0.3, 1.2, 2.4)
	_cam.look_at(at + Vector3(0, 0.75, 0), Vector3.UP)


func _shot(name: String) -> void:
	await process_frame
	await process_frame
	var img: Image = get_root().get_viewport().get_texture().get_image()
	if img == null:
		print("FAIL capture ", name)
		return
	var path_user := "%s/%s.png" % [OUT_USER, name]
	var err := img.save_png(path_user)
	var abs_user := ProjectSettings.globalize_path(path_user)
	var abs_scratch := "%s/%s.png" % [SCRATCH, name]
	if FileAccess.file_exists(abs_user):
		DirAccess.copy_absolute(abs_user, abs_scratch)
	print("OK shot ", name, " err=", err, " -> ", abs_scratch)
