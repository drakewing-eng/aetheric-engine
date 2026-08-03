extends Node3D
## Custom stylized Ignatius Bell — Victorian gentleman mesh + idle/walk/sit.
## Palette matches sprite_bell: charcoal coat, grey hair, book, stern face.
## Built ~1.78 m tall with feet at y=0 after ensure_built(); faces +Z.

const NATIVE_HEIGHT := 1.78

func _enter_tree() -> void:
	ensure_built()


func ensure_built() -> void:
	## Idempotent — fps_npc calls this right after instantiate.
	if has_node("BodyRoot"):
		return
	_build()
	_plant_mesh_to_ground()
	set_meta("native_height", NATIVE_HEIGHT)
	set_meta("bell_custom_mesh", true)


func get_mesh_bottom_y() -> float:
	## Lowest mesh point in this node's local space (0 = on floor after plant).
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
			var p: Vector3 = xf * a.get_endpoint(i)
			# Include BodyRoot offset
			p = root.transform * p
			lo = minf(lo, p.y)
			hi = maxf(hi, p.y)
			found = true
	if not found:
		return NATIVE_HEIGHT
	return hi - lo


func has_identity_parts() -> bool:
	## Structural identity checklist for tests.
	var need := ["Coat", "Vest", "Hair", "EyeL", "EyeR", "Book", "BootL", "BootR", "Skull"]
	for n in need:
		if _find_named(self, n) == null:
			return false
	return true


func _build() -> void:
	var root := Node3D.new()
	root.name = "BodyRoot"
	add_child(root)

	# --- Materials (sprite_bell palette) ---
	var mat_coat := _mat(Color(0.09, 0.085, 0.09))
	var mat_vest := _mat(Color(0.30, 0.27, 0.24))
	var mat_shirt := _mat(Color(0.90, 0.88, 0.84))
	var mat_trousers := _mat(Color(0.20, 0.18, 0.19))
	var mat_skin := _mat(Color(0.74, 0.60, 0.50))
	var mat_hair := _mat(Color(0.42, 0.40, 0.42))
	var mat_boot := _mat(Color(0.05, 0.04, 0.04))
	var mat_book := _mat(Color(0.45, 0.30, 0.16))
	var mat_book_page := _mat(Color(0.85, 0.80, 0.70))
	var mat_eye := _mat(Color(0.10, 0.09, 0.09))
	var mat_brow := _mat(Color(0.28, 0.25, 0.25))
	var mat_chain := _mat(Color(0.75, 0.64, 0.36), 0.45, 0.55)
	var mat_lip := _mat(Color(0.55, 0.38, 0.35))

	# Hip height: legs hang so boots rest at y=0
	# thigh 0.46 + shin 0.42 + boot half 0.05 ≈ 0.93 from hip → hip_y = 0.93
	var hip_y := 0.93
	var leg_l := _pivot(root, "LegL", Vector3(-0.12, hip_y, 0.0))
	var leg_r := _pivot(root, "LegR", Vector3(0.12, hip_y, 0.0))
	_limb(leg_l, "ThighL", Vector3(0, -0.23, 0), Vector3(0.12, 0.46, 0.13), mat_trousers)
	_limb(leg_r, "ThighR", Vector3(0, -0.23, 0), Vector3(0.12, 0.46, 0.13), mat_trousers)
	var calf_l := _pivot(leg_l, "CalfL", Vector3(0, -0.46, 0))
	var calf_r := _pivot(leg_r, "CalfR", Vector3(0, -0.46, 0))
	_limb(calf_l, "ShinL", Vector3(0, -0.21, 0), Vector3(0.105, 0.42, 0.12), mat_trousers)
	_limb(calf_r, "ShinR", Vector3(0, -0.21, 0), Vector3(0.105, 0.42, 0.12), mat_trousers)
	# Boots: bottom of box at local y = -0.47 - 0.05 = -0.52 from calf; calf at 0.93-0.46=0.47
	# 0.47 - 0.47 = 0.0 ✓
	_box(calf_l, "BootL", Vector3(0, -0.47, 0.05), Vector3(0.13, 0.10, 0.24), mat_boot)
	_box(calf_r, "BootR", Vector3(0, -0.47, 0.05), Vector3(0.13, 0.10, 0.24), mat_boot)

	# --- Torso / coat silhouette ---
	_capsule(root, "Coat", Vector3(0, 1.24, 0), 0.20, 0.56, mat_coat)
	_box(root, "CoatSkirt", Vector3(0, 0.96, 0.03), Vector3(0.50, 0.42, 0.30), mat_coat)
	_box(root, "CoatLapelL", Vector3(-0.10, 1.36, 0.14), Vector3(0.10, 0.28, 0.06), mat_coat)
	_box(root, "CoatLapelR", Vector3(0.10, 1.36, 0.14), Vector3(0.10, 0.28, 0.06), mat_coat)
	_box(root, "Vest", Vector3(0, 1.28, 0.08), Vector3(0.28, 0.40, 0.16), mat_vest)
	_box(root, "ShirtFront", Vector3(0, 1.34, 0.14), Vector3(0.10, 0.24, 0.05), mat_shirt)
	_box(root, "TailL", Vector3(-0.14, 0.76, -0.08), Vector3(0.18, 0.48, 0.12), mat_coat)
	_box(root, "TailR", Vector3(0.14, 0.76, -0.08), Vector3(0.18, 0.48, 0.12), mat_coat)
	# Shoulder pads for coat bulk
	_sphere(root, "ShoulderL", Vector3(-0.26, 1.46, 0.0), 0.08, mat_coat)
	_sphere(root, "ShoulderR", Vector3(0.26, 1.46, 0.0), 0.08, mat_coat)

	# --- Arms ---
	var arm_l := _pivot(root, "ArmL", Vector3(-0.30, 1.44, 0.0))
	var arm_r := _pivot(root, "ArmR", Vector3(0.30, 1.44, 0.0))
	_limb(arm_l, "UpperL", Vector3(-0.02, -0.17, 0), Vector3(0.09, 0.34, 0.09), mat_coat)
	_limb(arm_r, "UpperR", Vector3(0.02, -0.17, 0), Vector3(0.09, 0.34, 0.09), mat_coat)
	var forearm_l := _pivot(arm_l, "ForeL", Vector3(0, -0.34, 0))
	var forearm_r := _pivot(arm_r, "ForeR", Vector3(0, -0.34, 0))
	_limb(forearm_l, "LowerL", Vector3(0, -0.15, 0), Vector3(0.08, 0.30, 0.08), mat_coat)
	_limb(forearm_r, "LowerR", Vector3(0, -0.15, 0), Vector3(0.08, 0.30, 0.08), mat_coat)
	_sphere(forearm_l, "HandL", Vector3(0, -0.32, 0.02), 0.055, mat_skin)
	_sphere(forearm_r, "HandR", Vector3(0, -0.32, 0.02), 0.055, mat_skin)
	# Book (left hand) + page edge
	_box(forearm_l, "Book", Vector3(-0.02, -0.30, 0.11), Vector3(0.05, 0.20, 0.15), mat_book)
	_box(forearm_l, "BookPages", Vector3(0.0, -0.30, 0.11), Vector3(0.03, 0.18, 0.13), mat_book_page)
	_sphere(root, "Chain", Vector3(0.09, 1.20, 0.17), 0.022, mat_chain)

	arm_l.rotation_degrees = Vector3(14, 8, 20)
	forearm_l.rotation_degrees = Vector3(-40, 30, 5)
	arm_r.rotation_degrees = Vector3(6, 0, -10)

	# --- Head / face ---
	var head := _pivot(root, "Head", Vector3(0, 1.60, 0))
	_sphere(head, "Skull", Vector3(0, 0.11, 0.02), 0.125, mat_skin)
	# Wild grey hair mass
	_sphere(head, "Hair", Vector3(0, 0.18, -0.02), 0.15, mat_hair)
	_box(head, "HairSideL", Vector3(-0.12, 0.12, 0.0), Vector3(0.07, 0.16, 0.14), mat_hair)
	_box(head, "HairSideR", Vector3(0.12, 0.12, 0.0), Vector3(0.07, 0.16, 0.14), mat_hair)
	_box(head, "HairTop", Vector3(0, 0.24, 0.0), Vector3(0.20, 0.08, 0.18), mat_hair)
	_box(head, "HairFront", Vector3(0, 0.18, 0.10), Vector3(0.16, 0.06, 0.06), mat_hair)
	# Stern brows / deep eyes
	_box(head, "BrowL", Vector3(-0.045, 0.145, 0.115), Vector3(0.055, 0.018, 0.025), mat_brow)
	_box(head, "BrowR", Vector3(0.045, 0.145, 0.115), Vector3(0.055, 0.018, 0.025), mat_brow)
	_sphere(head, "EyeL", Vector3(-0.04, 0.115, 0.125), 0.02, mat_eye)
	_sphere(head, "EyeR", Vector3(0.04, 0.115, 0.125), 0.02, mat_eye)
	_box(head, "Nose", Vector3(0, 0.09, 0.135), Vector3(0.028, 0.045, 0.045), mat_skin)
	_box(head, "Mouth", Vector3(0, 0.045, 0.125), Vector3(0.055, 0.014, 0.022), mat_lip)
	# Ears
	_sphere(head, "EarL", Vector3(-0.12, 0.10, 0.0), 0.03, mat_skin)
	_sphere(head, "EarR", Vector3(0.12, 0.10, 0.0), 0.03, mat_skin)
	# Collar / cravat
	_box(root, "Collar", Vector3(0, 1.52, 0.09), Vector3(0.18, 0.07, 0.14), mat_shirt)
	_box(root, "Cravat", Vector3(0, 1.46, 0.14), Vector3(0.07, 0.12, 0.06), mat_coat)

	_build_animations(leg_l, leg_r, arm_l, arm_r, calf_l, calf_r, head)


func _plant_mesh_to_ground() -> void:
	## Shift BodyRoot so lowest geometry is at y=0 in character space.
	var root := get_node_or_null("BodyRoot") as Node3D
	if root == null:
		return
	# Approximate without globals: measure boot bottoms from known layout
	# Prefer live mesh scan when possible
	var bottom := _scan_bottom_local()
	root.position.y -= bottom
	# Micro lift to avoid z-fight with floor shadow
	root.position.y += 0.005


func _scan_bottom_local() -> float:
	## Bottom Y in character (self) local space, including BodyRoot.position.
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
	t = stop_at.transform if false else Transform3D.IDENTITY
	# From stop_at down to node: start identity in stop_at space
	t = Transform3D.IDENTITY
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

	# idle: head/chest only — do NOT lift BodyRoot (that reads as floating)
	var idle := Animation.new()
	idle.length = 2.4
	idle.loop_mode = Animation.LOOP_LINEAR
	_rot_track(idle, head, 0.0, Vector3(0, 0, 0), 1.2, Vector3(2, 3, 0), 2.4, Vector3(0, 0, 0))
	# slight arm settle
	_rot_track(idle, arm_r, 0.0, Vector3(6, 0, -10), 1.2, Vector3(8, 0, -12), 2.4, Vector3(6, 0, -10))
	lib.add_animation("idle", idle)

	# walk: alternating legs, small bounce on BodyRoot (≤2 cm)
	var walk := Animation.new()
	walk.length = 0.85
	walk.loop_mode = Animation.LOOP_LINEAR
	_rot_track(walk, leg_l, 0.0, Vector3(30, 0, 0), 0.425, Vector3(-34, 0, 0), 0.85, Vector3(30, 0, 0))
	_rot_track(walk, leg_r, 0.0, Vector3(-34, 0, 0), 0.425, Vector3(30, 0, 0), 0.85, Vector3(-34, 0, 0))
	_rot_track(walk, calf_l, 0.0, Vector3(8, 0, 0), 0.425, Vector3(28, 0, 0), 0.85, Vector3(8, 0, 0))
	_rot_track(walk, calf_r, 0.0, Vector3(28, 0, 0), 0.425, Vector3(8, 0, 0), 0.85, Vector3(28, 0, 0))
	_rot_track(walk, arm_r, 0.0, Vector3(22, 0, -10), 0.425, Vector3(-14, 0, -10), 0.85, Vector3(22, 0, -10))
	_rot_track(walk, arm_l, 0.0, Vector3(12, 8, 18), 0.425, Vector3(18, 8, 20), 0.85, Vector3(12, 8, 18))
	var wt := walk.add_track(Animation.TYPE_VALUE)
	walk.track_set_path(wt, NodePath("BodyRoot:position"))
	walk.value_track_set_update_mode(wt, Animation.UPDATE_CONTINUOUS)
	walk.track_insert_key(wt, 0.0, Vector3(0, 0.0, 0))
	walk.track_insert_key(wt, 0.21, Vector3(0, 0.018, 0))
	walk.track_insert_key(wt, 0.425, Vector3(0, 0.0, 0))
	walk.track_insert_key(wt, 0.64, Vector3(0, 0.018, 0))
	walk.track_insert_key(wt, 0.85, Vector3(0, 0.0, 0))
	lib.add_animation("walk", walk)

	var sit := Animation.new()
	sit.length = 0.55
	sit.loop_mode = Animation.LOOP_NONE
	_rot_track(sit, leg_l, 0.0, Vector3(0, 0, 0), 0.55, Vector3(-72, 12, 0), 0.55, Vector3(-72, 12, 0))
	_rot_track(sit, leg_r, 0.0, Vector3(0, 0, 0), 0.55, Vector3(-72, -12, 0), 0.55, Vector3(-72, -12, 0))
	_rot_track(sit, calf_l, 0.0, Vector3(0, 0, 0), 0.55, Vector3(70, 0, 0), 0.55, Vector3(70, 0, 0))
	_rot_track(sit, calf_r, 0.0, Vector3(0, 0, 0), 0.55, Vector3(70, 0, 0), 0.55, Vector3(70, 0, 0))
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


func _local_to_self(mi: Node3D, corner: Vector3) -> Vector3:
	return _accum_transform(mi, self) * corner


func _approx_local(mi: Node3D, corner: Vector3) -> Vector3:
	return _accum_transform(mi, self) * corner


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
	mesh.radial_segments = 14
	mesh.rings = 10
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
	mesh.radial_segments = 14
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	parent.add_child(mi)
	return mi


func _limb(parent: Node3D, n: String, pos: Vector3, size: Vector3, mat: Material) -> MeshInstance3D:
	return _box(parent, n, pos, size, mat)
