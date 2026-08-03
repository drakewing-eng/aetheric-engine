extends Node3D
## Custom stylized Ignatius Bell — Victorian gentleman low-poly mesh + idle/walk.
## Built to match sprite_bell palette: charcoal coat, grey hair, book, stern face.
## Units: ~1.78 m tall, feet at y=0, faces +Z (Godot forward for our yaw).

const HEIGHT := 1.78

func _enter_tree() -> void:
	ensure_built()


func ensure_built() -> void:
	## Idempotent build — callable right after instantiate from fps_npc.
	if has_node("BodyRoot"):
		return
	_build()


func _build() -> void:
	var root := Node3D.new()
	root.name = "BodyRoot"
	add_child(root)

	# --- Materials (reference sprite palette) ---
	var mat_coat := _mat(Color(0.10, 0.09, 0.10))
	var mat_vest := _mat(Color(0.28, 0.26, 0.24))
	var mat_shirt := _mat(Color(0.88, 0.86, 0.82))
	var mat_trousers := _mat(Color(0.22, 0.20, 0.20))
	var mat_skin := _mat(Color(0.72, 0.58, 0.48))
	var mat_hair := _mat(Color(0.35, 0.33, 0.34))
	var mat_boot := _mat(Color(0.06, 0.05, 0.05))
	var mat_book := _mat(Color(0.42, 0.28, 0.16))
	var mat_eye := _mat(Color(0.12, 0.10, 0.10))
	var mat_brow := _mat(Color(0.25, 0.22, 0.22))
	var mat_chain := _mat(Color(0.72, 0.62, 0.35), 0.55, 0.4)

	# --- Legs (pivots at hips for walk) ---
	var hip_y := 0.92
	var leg_l := _pivot(root, "LegL", Vector3(-0.11, hip_y, 0.0))
	var leg_r := _pivot(root, "LegR", Vector3(0.11, hip_y, 0.0))
	_limb(leg_l, "Thigh", Vector3(0, -0.22, 0), Vector3(0.11, 0.44, 0.12), mat_trousers)
	_limb(leg_r, "Thigh", Vector3(0, -0.22, 0), Vector3(0.11, 0.44, 0.12), mat_trousers)
	var calf_l := _pivot(leg_l, "Calf", Vector3(0, -0.44, 0))
	var calf_r := _pivot(leg_r, "Calf", Vector3(0, -0.44, 0))
	_limb(calf_l, "Shin", Vector3(0, -0.20, 0), Vector3(0.10, 0.40, 0.11), mat_trousers)
	_limb(calf_r, "Shin", Vector3(0, -0.20, 0), Vector3(0.10, 0.40, 0.11), mat_trousers)
	_box(calf_l, "Boot", Vector3(0, -0.42, 0.04), Vector3(0.12, 0.10, 0.22), mat_boot)
	_box(calf_r, "Boot", Vector3(0, -0.42, 0.04), Vector3(0.12, 0.10, 0.22), mat_boot)

	# --- Torso / coat ---
	_capsule(root, "Coat", Vector3(0, 1.22, 0), 0.22, 0.58, mat_coat)
	_box(root, "CoatSkirt", Vector3(0, 0.95, 0.02), Vector3(0.48, 0.38, 0.28), mat_coat)
	_box(root, "Vest", Vector3(0, 1.28, 0.06), Vector3(0.30, 0.38, 0.18), mat_vest)
	_box(root, "ShirtFront", Vector3(0, 1.32, 0.12), Vector3(0.12, 0.22, 0.06), mat_shirt)
	# Coat tails
	_box(root, "TailL", Vector3(-0.12, 0.78, -0.06), Vector3(0.16, 0.42, 0.10), mat_coat)
	_box(root, "TailR", Vector3(0.12, 0.78, -0.06), Vector3(0.16, 0.42, 0.10), mat_coat)

	# --- Arms ---
	var arm_l := _pivot(root, "ArmL", Vector3(-0.28, 1.42, 0.0))
	var arm_r := _pivot(root, "ArmR", Vector3(0.28, 1.42, 0.0))
	_limb(arm_l, "Upper", Vector3(-0.02, -0.16, 0), Vector3(0.09, 0.32, 0.09), mat_coat)
	_limb(arm_r, "Upper", Vector3(0.02, -0.16, 0), Vector3(0.09, 0.32, 0.09), mat_coat)
	var forearm_l := _pivot(arm_l, "Fore", Vector3(0, -0.32, 0))
	var forearm_r := _pivot(arm_r, "Fore", Vector3(0, -0.32, 0))
	_limb(forearm_l, "Lower", Vector3(0, -0.14, 0), Vector3(0.08, 0.28, 0.08), mat_coat)
	_limb(forearm_r, "Lower", Vector3(0, -0.14, 0), Vector3(0.08, 0.28, 0.08), mat_coat)
	_sphere(forearm_l, "Hand", Vector3(0, -0.30, 0.02), 0.055, mat_skin)
	_sphere(forearm_r, "Hand", Vector3(0, -0.30, 0.02), 0.055, mat_skin)
	# Book in left hand (character's left = -X)
	_box(forearm_l, "Book", Vector3(-0.02, -0.28, 0.10), Vector3(0.04, 0.18, 0.14), mat_book)
	# Watch chain hint on vest
	_sphere(root, "Chain", Vector3(0.08, 1.18, 0.16), 0.025, mat_chain)

	# Default arm pose: left holds book across body, right hangs
	arm_l.rotation_degrees = Vector3(12, 0, 18)
	forearm_l.rotation_degrees = Vector3(-35, 25, 0)
	arm_r.rotation_degrees = Vector3(8, 0, -8)

	# --- Head / face (readable features, not a floating photo) ---
	var head := _pivot(root, "Head", Vector3(0, 1.58, 0))
	_sphere(head, "Skull", Vector3(0, 0.10, 0.02), 0.13, mat_skin)
	_sphere(head, "Hair", Vector3(0, 0.16, -0.02), 0.145, mat_hair)
	_box(head, "HairSideL", Vector3(-0.11, 0.10, 0.0), Vector3(0.06, 0.14, 0.12), mat_hair)
	_box(head, "HairSideR", Vector3(0.11, 0.10, 0.0), Vector3(0.06, 0.14, 0.12), mat_hair)
	_box(head, "HairTop", Vector3(0, 0.22, 0.0), Vector3(0.18, 0.06, 0.16), mat_hair)
	# Brows (stern)
	_box(head, "BrowL", Vector3(-0.045, 0.14, 0.11), Vector3(0.05, 0.015, 0.02), mat_brow)
	_box(head, "BrowR", Vector3(0.045, 0.14, 0.11), Vector3(0.05, 0.015, 0.02), mat_brow)
	# Eyes
	_sphere(head, "EyeL", Vector3(-0.04, 0.11, 0.12), 0.022, mat_eye)
	_sphere(head, "EyeR", Vector3(0.04, 0.11, 0.12), 0.022, mat_eye)
	# Nose / mouth
	_box(head, "Nose", Vector3(0, 0.08, 0.13), Vector3(0.025, 0.04, 0.04), mat_skin)
	_box(head, "Mouth", Vector3(0, 0.04, 0.12), Vector3(0.05, 0.012, 0.02), mat_brow)
	# Collar / cravat
	_box(root, "Collar", Vector3(0, 1.50, 0.08), Vector3(0.16, 0.06, 0.12), mat_shirt)
	_box(root, "Cravat", Vector3(0, 1.44, 0.12), Vector3(0.06, 0.10, 0.05), mat_coat)

	_build_animations(root, leg_l, leg_r, arm_l, arm_r, calf_l, calf_r)


func _build_animations(
	root: Node3D,
	leg_l: Node3D, leg_r: Node3D,
	arm_l: Node3D, arm_r: Node3D,
	calf_l: Node3D, calf_r: Node3D
) -> void:
	var ap := get_node_or_null("AnimationPlayer") as AnimationPlayer
	if ap == null:
		ap = AnimationPlayer.new()
		ap.name = "AnimationPlayer"
		add_child(ap)

	var lib := AnimationLibrary.new()

	# --- idle: subtle breath + weight ---
	var idle := Animation.new()
	idle.length = 2.0
	idle.loop_mode = Animation.LOOP_LINEAR
	var i_path := NodePath("BodyRoot:position")
	var it := idle.add_track(Animation.TYPE_VALUE)
	idle.track_set_path(it, i_path)
	idle.track_insert_key(it, 0.0, Vector3(0, 0, 0))
	idle.track_insert_key(it, 1.0, Vector3(0, 0.012, 0))
	idle.track_insert_key(it, 2.0, Vector3(0, 0, 0))
	lib.add_animation("idle", idle)

	# --- walk: alternating legs (in-place; root motion from fps_npc) ---
	var walk := Animation.new()
	walk.length = 0.9
	walk.loop_mode = Animation.LOOP_LINEAR

	_rot_track(walk, leg_l, 0.0, Vector3(28, 0, 0), 0.45, Vector3(-32, 0, 0), 0.9, Vector3(28, 0, 0))
	_rot_track(walk, leg_r, 0.0, Vector3(-32, 0, 0), 0.45, Vector3(28, 0, 0), 0.9, Vector3(-32, 0, 0))
	_rot_track(walk, calf_l, 0.0, Vector3(10, 0, 0), 0.45, Vector3(25, 0, 0), 0.9, Vector3(10, 0, 0))
	_rot_track(walk, calf_r, 0.0, Vector3(25, 0, 0), 0.45, Vector3(10, 0, 0), 0.9, Vector3(25, 0, 0))
	# Arms counter-swing lightly
	_rot_track(walk, arm_r, 0.0, Vector3(20, 0, -8), 0.45, Vector3(-12, 0, -8), 0.9, Vector3(20, 0, -8))
	# Keep book arm more stable
	_rot_track(walk, arm_l, 0.0, Vector3(10, 0, 16), 0.45, Vector3(16, 0, 18), 0.9, Vector3(10, 0, 16))

	var wt := walk.add_track(Animation.TYPE_VALUE)
	walk.track_set_path(wt, NodePath("BodyRoot:position"))
	walk.track_insert_key(wt, 0.0, Vector3(0, 0.0, 0))
	walk.track_insert_key(wt, 0.22, Vector3(0, 0.03, 0))
	walk.track_insert_key(wt, 0.45, Vector3(0, 0.0, 0))
	walk.track_insert_key(wt, 0.67, Vector3(0, 0.03, 0))
	walk.track_insert_key(wt, 0.9, Vector3(0, 0.0, 0))

	lib.add_animation("walk", walk)

	# sit: crouch legs (simple)
	var sit := Animation.new()
	sit.length = 0.5
	sit.loop_mode = Animation.LOOP_NONE
	_rot_track(sit, leg_l, 0.0, Vector3(0, 0, 0), 0.5, Vector3(-70, 15, 0), 0.5, Vector3(-70, 15, 0))
	_rot_track(sit, leg_r, 0.0, Vector3(0, 0, 0), 0.5, Vector3(-70, -15, 0), 0.5, Vector3(-70, -15, 0))
	lib.add_animation("sit", sit)

	if ap.has_animation_library(""):
		ap.remove_animation_library("")
	ap.add_animation_library("", lib)
	ap.play("idle")


func _rot_track(
	anim: Animation, node: Node3D,
	t0: float, e0: Vector3, t1: float, e1: Vector3, t2: float, e2: Vector3
) -> void:
	var path := NodePath("BodyRoot/" + str(node.name) + ":rotation_degrees")
	# Build full path from BodyRoot
	var rel := _rel_path(node)
	path = NodePath(rel + ":rotation_degrees")
	var ti := anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(ti, path)
	anim.value_track_set_update_mode(ti, Animation.UPDATE_CONTINUOUS)
	anim.track_insert_key(ti, t0, e0)
	anim.track_insert_key(ti, t1, e1)
	if absf(t2 - t1) > 0.001:
		anim.track_insert_key(ti, t2, e2)


func _rel_path(node: Node) -> String:
	var parts: PackedStringArray = []
	var n: Node = node
	while n and n.name != "BodyRoot" and n != self:
		parts.insert(0, n.name)
		n = n.get_parent()
	return "BodyRoot/" + "/".join(parts)


func _mat(color: Color, rough: float = 0.9, metal: float = 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.roughness = rough
	m.metallic = metal
	m.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	return m


func _pivot(parent: Node3D, n: String, pos: Vector3) -> Node3D:
	var p := Node3D.new()
	p.name = n
	p.position = pos
	parent.add_child(p)
	return p


func _box(parent: Node3D, n: String, pos: Vector3, size: Vector3, mat: Material) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.name = n
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi


func _sphere(parent: Node3D, n: String, pos: Vector3, r: float, mat: Material) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.name = n
	var mesh := SphereMesh.new()
	mesh.radius = r
	mesh.height = r * 2.0
	mesh.radial_segments = 12
	mesh.rings = 8
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi


func _capsule(parent: Node3D, n: String, pos: Vector3, r: float, h: float, mat: Material) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.name = n
	var mesh := CapsuleMesh.new()
	mesh.radius = r
	mesh.height = h
	mesh.radial_segments = 12
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi


func _limb(parent: Node3D, n: String, pos: Vector3, size: Vector3, mat: Material) -> MeshInstance3D:
	return _box(parent, n, pos, size, mat)
