extends SceneTree
## Probe imported Bell humanoid GLB structure.
## Godot --headless --path . --script res://scripts/probe_bell_model.gd


func _init() -> void:
	var path := "res://assets/characters/models/bell/humanoid_stub.glb"
	if not ResourceLoader.exists(path):
		print("FAIL missing ", path)
		quit(1)
		return
	var packed = load(path)
	print("loaded type=", packed)
	var inst: Node = null
	if packed is PackedScene:
		inst = packed.instantiate()
	else:
		print("FAIL not PackedScene")
		quit(1)
		return
	print("root=", inst.name, " class=", inst.get_class())
	_dump(inst, 0)
	var ap := _find_anim(inst)
	if ap:
		print("AnimationPlayer found path=", inst.get_path_to(ap))
		print("libraries=", ap.get_animation_list())
		for n in ap.get_animation_list():
			var a: Animation = ap.get_animation(n)
			print("  clip=", n, " length=", a.length if a else -1)
	else:
		print("NO AnimationPlayer")
	var sk := _find_skel(inst)
	if sk:
		print("Skeleton3D bones=", sk.get_bone_count())
		for i in mini(sk.get_bone_count(), 25):
			print("  bone", i, sk.get_bone_name(i))
	# AABB of meshes
	var aabb := _mesh_aabb(inst)
	print("combined_aabb size=", aabb.size, " pos=", aabb.position)
	quit(0)


func _dump(n: Node, depth: int) -> void:
	var pad := ""
	for i in depth:
		pad += "  "
	print(pad, n.name, " [", n.get_class(), "]")
	for c in n.get_children():
		_dump(c, depth + 1)


func _find_anim(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var f := _find_anim(c)
		if f:
			return f
	return null


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var f := _find_skel(c)
		if f:
			return f
	return null


func _mesh_aabb(n: Node) -> AABB:
	var out := AABB()
	var first := true
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			var a := mi.get_aabb()
			a = mi.global_transform * a if false else a
			# local aabb is fine for scale estimate
			out = a
			first = false
	for c in n.get_children():
		var a2 := _mesh_aabb(c)
		if a2.size.length() > 0.0001:
			if first:
				out = a2
				first = false
			else:
				out = out.merge(a2)
	return out
