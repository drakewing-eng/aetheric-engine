extends Node3D
## Improved stylized-realist *placeholder* for Ignatius Bell.
## Goal: Oblivion-readable silhouette at game distance (hair mass, long coat,
## stern face, book) — still procedural until final/GLB ships.
## ~1.78 m, feet at y=0 after ensure_built(); faces +Z.

const NATIVE_HEIGHT := 1.78

func _enter_tree() -> void:
	ensure_built()


func ensure_built() -> void:
	if has_node("BodyRoot"):
		return
	_build()
	_plant_mesh_to_ground()
	set_meta("native_height", NATIVE_HEIGHT)
	set_meta("bell_custom_mesh", true)


func get_mesh_bottom_y() -> float:
	return _scan_bottom_local()


func get_mesh_height() -> float:
	var lo := INF
	var hi := -INF
	var found := false
	var root := get_node_or_null("BodyRoot") as Node3D
	if root == null:
		return NATIVE_HEIGHT
	for mi in _all_meshes(root):
		if mi.mesh == null:
			continue
		var xf := _accum_transform(mi, root)
		var a: AABB = mi.get_aabb()
		for i in 8:
			var p: Vector3 = root.transform * (xf * a.get_endpoint(i))
			lo = minf(lo, p.y)
			hi = maxf(hi, p.y)
			found = true
	return (hi - lo) if found else NATIVE_HEIGHT


func has_identity_parts() -> bool:
	var need := ["Coat", "Vest", "Hair", "EyeL", "EyeR", "Book", "BootL", "BootR", "Skull"]
	for n in need:
		if _find_named(self, n) == null:
			return false
	return true


func _build() -> void:
	var root := Node3D.new()
	root.name = "BodyRoot"
	add_child(root)

	# Palette from sprite_bell / ART_DIRECTION
	var mat_coat := _mat(Color(0.09, 0.085, 0.09), 0.90)
	var mat_vest := _mat(Color(0.32, 0.28, 0.25), 0.82)
	var mat_shirt := _mat(Color(0.90, 0.88, 0.84), 0.78)
	var mat_trousers := _mat(Color(0.18, 0.16, 0.17), 0.88)
	var mat_skin := _mat(Color(0.74, 0.58, 0.48), 0.68)
	var mat_hair := _mat(Color(0.48, 0.45, 0.47), 0.72)
	var mat_hair_dark := _mat(Color(0.28, 0.26, 0.28), 0.75)
	var mat_boot := _mat(Color(0.05, 0.04, 0.04), 0.42)
	var mat_book := _mat(Color(0.42, 0.27, 0.15), 0.78)
	var mat_page := _mat(Color(0.86, 0.82, 0.72), 0.85)
	var mat_eye := _mat(Color(0.08, 0.07, 0.07), 0.4)
	var mat_brow := _mat(Color(0.22, 0.18, 0.17), 0.85)
	var mat_chain := _mat(Color(0.78, 0.65, 0.35), 0.35, 0.65)
	var mat_lip := _mat(Color(0.52, 0.36, 0.32), 0.7)

	# --- Legs (slim; hip so boots at y≈0) ---
	var hip_y := 0.94
	var leg_l := _pivot(root, "LegL", Vector3(-0.11, hip_y, 0.02))
	var leg_r := _pivot(root, "LegR", Vector3(0.11, hip_y, 0.02))
	_cyl(leg_l, "ThighL", Vector3(0, -0.24, 0), 0.055, 0.48, mat_trousers)
	_cyl(leg_r, "ThighR", Vector3(0, -0.24, 0), 0.055, 0.48, mat_trousers)
	var calf_l := _pivot(leg_l, "CalfL", Vector3(0, -0.48, 0))
	var calf_r := _pivot(leg_r, "CalfR", Vector3(0, -0.48, 0))
	_cyl(calf_l, "ShinL", Vector3(0, -0.22, 0), 0.048, 0.44, mat_trousers)
	_cyl(calf_r, "ShinR", Vector3(0, -0.22, 0), 0.048, 0.44, mat_trousers)
	_box(calf_l, "BootL", Vector3(0, -0.48, 0.06), Vector3(0.12, 0.09, 0.26), mat_boot)
	_box(calf_r, "BootR", Vector3(0, -0.48, 0.06), Vector3(0.12, 0.09, 0.26), mat_boot)

	# --- Torso: broader shoulders, long coat with hem weight ---
	_capsule(root, "TorsoCore", Vector3(0, 1.28, 0.0), 0.16, 0.42, mat_vest)
	_capsule(root, "Coat", Vector3(0, 1.26, 0.0), 0.22, 0.62, mat_coat)
	# Long coat body (mid-thigh to near knee)
	_box(root, "CoatSkirt", Vector3(0, 0.88, 0.04), Vector3(0.56, 0.55, 0.34), mat_coat)
	_box(root, "CoatHem", Vector3(0, 0.58, 0.02), Vector3(0.58, 0.10, 0.36), mat_coat)
	# Rear tails (split frock coat)
	_box(root, "TailL", Vector3(-0.14, 0.62, -0.12), Vector3(0.20, 0.58, 0.14), mat_coat)
	_box(root, "TailR", Vector3(0.14, 0.62, -0.12), Vector3(0.20, 0.58, 0.14), mat_coat)
	# Open front: vest + shirt + cravat
	_box(root, "Vest", Vector3(0, 1.30, 0.12), Vector3(0.30, 0.44, 0.14), mat_vest)
	_box(root, "ShirtFront", Vector3(0, 1.36, 0.18), Vector3(0.11, 0.28, 0.05), mat_shirt)
	_box(root, "Cravat", Vector3(0, 1.48, 0.20), Vector3(0.07, 0.12, 0.06), mat_coat)
	_box(root, "Collar", Vector3(0, 1.54, 0.14), Vector3(0.18, 0.06, 0.14), mat_shirt)
	# Lapels (angular)
	_box(root, "CoatLapelL", Vector3(-0.12, 1.40, 0.20), Vector3(0.12, 0.32, 0.05), mat_coat)
	_box(root, "CoatLapelR", Vector3(0.12, 1.40, 0.20), Vector3(0.12, 0.32, 0.05), mat_coat)
	# Shoulder bulk
	_sphere(root, "ShoulderL", Vector3(-0.30, 1.50, 0.0), 0.10, mat_coat)
	_sphere(root, "ShoulderR", Vector3(0.30, 1.50, 0.0), 0.10, mat_coat)
	_sphere(root, "Chain", Vector3(0.10, 1.22, 0.22), 0.02, mat_chain)

	# --- Arms ---
	var arm_l := _pivot(root, "ArmL", Vector3(-0.34, 1.48, 0.0))
	var arm_r := _pivot(root, "ArmR", Vector3(0.34, 1.48, 0.0))
	_cyl(arm_l, "UpperL", Vector3(-0.02, -0.18, 0), 0.048, 0.36, mat_coat)
	_cyl(arm_r, "UpperR", Vector3(0.02, -0.18, 0), 0.048, 0.36, mat_coat)
	var forearm_l := _pivot(arm_l, "ForeL", Vector3(0, -0.36, 0))
	var forearm_r := _pivot(arm_r, "ForeR", Vector3(0, -0.36, 0))
	_cyl(forearm_l, "LowerL", Vector3(0, -0.16, 0), 0.042, 0.32, mat_coat)
	_cyl(forearm_r, "LowerR", Vector3(0, -0.16, 0), 0.042, 0.32, mat_coat)
	_sphere(forearm_l, "HandL", Vector3(0, -0.34, 0.02), 0.052, mat_skin)
	_sphere(forearm_r, "HandR", Vector3(0, -0.34, 0.02), 0.052, mat_skin)
	# Book held at chest (scholar pose)
	_box(forearm_l, "Book", Vector3(0.02, -0.22, 0.14), Vector3(0.055, 0.22, 0.16), mat_book)
	_box(forearm_l, "BookPages", Vector3(0.04, -0.22, 0.14), Vector3(0.03, 0.20, 0.14), mat_page)

	arm_l.rotation_degrees = Vector3(18, 15, 28)
	forearm_l.rotation_degrees = Vector3(-55, 35, 10)
	arm_r.rotation_degrees = Vector3(8, -5, -12)

	# --- Head: gaunt + intense brow + wild hair mass ---
	var head := _pivot(root, "Head", Vector3(0, 1.62, 0.02))
	_sphere(head, "Skull", Vector3(0, 0.10, 0.02), 0.12, mat_skin)
	# Cheek hollows (slightly inset dark skin)
	_sphere(head, "CheekL", Vector3(-0.07, 0.06, 0.06), 0.05, mat_skin)
	_sphere(head, "CheekR", Vector3(0.07, 0.06, 0.06), 0.05, mat_skin)
	_box(head, "Jaw", Vector3(0, 0.02, 0.04), Vector3(0.14, 0.06, 0.12), mat_skin)
	# Deep sockets + stern brows
	_box(head, "BrowRidge", Vector3(0, 0.15, 0.10), Vector3(0.16, 0.04, 0.06), mat_skin)
	_box(head, "BrowL", Vector3(-0.05, 0.16, 0.13), Vector3(0.06, 0.02, 0.03), mat_brow)
	_box(head, "BrowR", Vector3(0.05, 0.16, 0.13), Vector3(0.06, 0.02, 0.03), mat_brow)
	_sphere(head, "EyeL", Vector3(-0.04, 0.12, 0.13), 0.018, mat_eye)
	_sphere(head, "EyeR", Vector3(0.04, 0.12, 0.13), 0.018, mat_eye)
	_box(head, "Nose", Vector3(0, 0.09, 0.145), Vector3(0.03, 0.05, 0.05), mat_skin)
	_box(head, "Mouth", Vector3(0, 0.04, 0.13), Vector3(0.055, 0.014, 0.025), mat_lip)
	_sphere(head, "EarL", Vector3(-0.12, 0.10, 0.0), 0.028, mat_skin)
	_sphere(head, "EarR", Vector3(0.12, 0.10, 0.0), 0.028, mat_skin)

	# Hair: multi-sphere wild volume (not a single helmet)
	_sphere(head, "Hair", Vector3(0, 0.20, -0.02), 0.155, mat_hair)  # required name
	_sphere(head, "HairCrown", Vector3(0, 0.28, -0.02), 0.12, mat_hair)
	_sphere(head, "HairFront", Vector3(0, 0.18, 0.10), 0.10, mat_hair_dark)
	_sphere(head, "HairL", Vector3(-0.12, 0.18, 0.0), 0.11, mat_hair)
	_sphere(head, "HairR", Vector3(0.12, 0.18, 0.0), 0.11, mat_hair)
	_sphere(head, "HairBack", Vector3(0, 0.14, -0.12), 0.12, mat_hair_dark)
	_sphere(head, "HairTuftL", Vector3(-0.08, 0.30, 0.04), 0.07, mat_hair)
	_sphere(head, "HairTuftR", Vector3(0.08, 0.30, 0.04), 0.07, mat_hair)
	_box(head, "HairSideL", Vector3(-0.13, 0.12, 0.02), Vector3(0.07, 0.18, 0.14), mat_hair)
	_box(head, "HairSideR", Vector3(0.13, 0.12, 0.02), Vector3(0.07, 0.18, 0.14), mat_hair)

	_build_animations(leg_l, leg_r, arm_l, arm_r, calf_l, calf_r, head)


func _plant_mesh_to_ground() -> void:
	var root := get_node_or_null("BodyRoot") as Node3D
	if root == null:
		return
	var bottom := _scan_bottom_local()
	root.position.y -= bottom
	root.position.y += 0.005


func _scan_bottom_local() -> float:
	var bottom := INF
	var found := false
	var root := get_node_or_null("BodyRoot") as Node3D
	if root == null:
		return 0.0
	for mi in _all_meshes(root):
		if mi.mesh == null:
			continue
		var xf := _accum_transform(mi, root)
		var a: AABB = mi.get_aabb()
		for i in 8:
			var p: Vector3 = root.transform * (xf * a.get_endpoint(i))
			if p.y < bottom:
				bottom = p.y
				found = true
	return bottom if found else 0.0


func _accum_transform(node: Node3D, stop_at: Node3D) -> Transform3D:
	var t := Transform3D.IDENTITY
	var n: Node = node
	var stack: Array[Node3D] = []
	while n is Node3D and n != stop_at:
		stack.push_front(n as Node3D)
		n = n.get_parent()
		if n == null:
			break
	for sn in stack:
		t = t * sn.transform
	return t


func _build_animations(
	leg_l: Node3D, leg_r: Node3D,
	arm_l: Node3D, arm_r: Node3D,
	calf_l: Node3D, calf_r: Node3D,
	head: Node3D
) -> void:
	var ap := get_node_or_null("AnimationPlayer") as AnimationPlayer
	if ap == null:
		ap = AnimationPlayer.new()
		ap.name = "AnimationPlayer"
		add_child(ap)

	var lib := AnimationLibrary.new()
	var rest_leg := Vector3.ZERO
	var rest_calf := Vector3.ZERO
	var rest_arm_l := Vector3(18, 15, 28)
	var rest_arm_r := Vector3(8, -5, -12)

	# idle: rest all walk/sit tracks + subtle head
	var idle := Animation.new()
	idle.length = 2.4
	idle.loop_mode = Animation.LOOP_LINEAR
	_rot_track(idle, leg_l, 0.0, rest_leg, 1.2, rest_leg, 2.4, rest_leg)
	_rot_track(idle, leg_r, 0.0, rest_leg, 1.2, rest_leg, 2.4, rest_leg)
	_rot_track(idle, calf_l, 0.0, rest_calf, 1.2, rest_calf, 2.4, rest_calf)
	_rot_track(idle, calf_r, 0.0, rest_calf, 1.2, rest_calf, 2.4, rest_calf)
	_rot_track(idle, arm_l, 0.0, rest_arm_l, 1.2, rest_arm_l, 2.4, rest_arm_l)
	_rot_track(idle, arm_r, 0.0, rest_arm_r, 1.2, Vector3(10, -5, -14), 2.4, rest_arm_r)
	_rot_track(idle, head, 0.0, Vector3(0, 0, 0), 1.2, Vector3(2, 4, 0), 2.4, Vector3(0, 0, 0))
	var it := idle.add_track(Animation.TYPE_VALUE)
	idle.track_set_path(it, NodePath("BodyRoot:position"))
	idle.value_track_set_update_mode(it, Animation.UPDATE_CONTINUOUS)
	idle.track_insert_key(it, 0.0, Vector3.ZERO)
	idle.track_insert_key(it, 1.2, Vector3.ZERO)
	idle.track_insert_key(it, 2.4, Vector3.ZERO)
	lib.add_animation("idle", idle)

	var walk := Animation.new()
	walk.length = 0.85
	walk.loop_mode = Animation.LOOP_LINEAR
	_rot_track(walk, leg_l, 0.0, Vector3(30, 0, 0), 0.425, Vector3(-34, 0, 0), 0.85, Vector3(30, 0, 0))
	_rot_track(walk, leg_r, 0.0, Vector3(-34, 0, 0), 0.425, Vector3(30, 0, 0), 0.85, Vector3(-34, 0, 0))
	_rot_track(walk, calf_l, 0.0, Vector3(8, 0, 0), 0.425, Vector3(28, 0, 0), 0.85, Vector3(8, 0, 0))
	_rot_track(walk, calf_r, 0.0, Vector3(28, 0, 0), 0.425, Vector3(8, 0, 0), 0.85, Vector3(28, 0, 0))
	_rot_track(walk, arm_r, 0.0, Vector3(22, -5, -12), 0.425, Vector3(-12, -5, -12), 0.85, Vector3(22, -5, -12))
	_rot_track(walk, arm_l, 0.0, Vector3(16, 15, 26), 0.425, Vector3(22, 15, 28), 0.85, Vector3(16, 15, 26))
	var wt := walk.add_track(Animation.TYPE_VALUE)
	walk.track_set_path(wt, NodePath("BodyRoot:position"))
	walk.value_track_set_update_mode(wt, Animation.UPDATE_CONTINUOUS)
	walk.track_insert_key(wt, 0.0, Vector3(0, 0, 0))
	walk.track_insert_key(wt, 0.21, Vector3(0, 0.016, 0))
	walk.track_insert_key(wt, 0.425, Vector3(0, 0, 0))
	walk.track_insert_key(wt, 0.64, Vector3(0, 0.016, 0))
	walk.track_insert_key(wt, 0.85, Vector3(0, 0, 0))
	lib.add_animation("walk", walk)

	var sit := Animation.new()
	sit.length = 0.55
	sit.loop_mode = Animation.LOOP_NONE
	_rot_track(sit, leg_l, 0.0, rest_leg, 0.55, Vector3(-72, 12, 0), 0.55, Vector3(-72, 12, 0))
	_rot_track(sit, leg_r, 0.0, rest_leg, 0.55, Vector3(-72, -12, 0), 0.55, Vector3(-72, -12, 0))
	_rot_track(sit, calf_l, 0.0, rest_calf, 0.55, Vector3(70, 0, 0), 0.55, Vector3(70, 0, 0))
	_rot_track(sit, calf_r, 0.0, rest_calf, 0.55, Vector3(70, 0, 0), 0.55, Vector3(70, 0, 0))
	_rot_track(sit, arm_l, 0.0, rest_arm_l, 0.55, rest_arm_l, 0.55, rest_arm_l)
	_rot_track(sit, arm_r, 0.0, rest_arm_r, 0.55, rest_arm_r, 0.55, rest_arm_r)
	var st := sit.add_track(Animation.TYPE_VALUE)
	sit.track_set_path(st, NodePath("BodyRoot:position"))
	sit.track_insert_key(st, 0.0, Vector3.ZERO)
	sit.track_insert_key(st, 0.55, Vector3.ZERO)
	lib.add_animation("sit", sit)

	if ap.has_animation_library(""):
		ap.remove_animation_library("")
	ap.add_animation_library("", lib)
	ap.play("idle")


func _rot_track(
	anim: Animation, node: Node3D,
	t0: float, e0: Vector3, t1: float, e1: Vector3, t2: float, e2: Vector3
) -> void:
	var path := NodePath(_rel_path(node) + ":rotation_degrees")
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


func _all_meshes(n: Node) -> Array[MeshInstance3D]:
	var out: Array[MeshInstance3D] = []
	if n is MeshInstance3D:
		out.append(n as MeshInstance3D)
	for c in n.get_children():
		out.append_array(_all_meshes(c))
	return out


func _find_named(n: Node, name: String) -> Node:
	if n.name == name:
		return n
	for c in n.get_children():
		var f := _find_named(c, name)
		if f:
			return f
	return null


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
	mesh.radial_segments = 16
	mesh.rings = 12
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
	mesh.radial_segments = 16
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi


func _cyl(parent: Node3D, n: String, pos: Vector3, r: float, h: float, mat: Material) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.name = n
	var mesh := CylinderMesh.new()
	mesh.top_radius = r
	mesh.bottom_radius = r * 1.05
	mesh.height = h
	mesh.radial_segments = 14
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi
