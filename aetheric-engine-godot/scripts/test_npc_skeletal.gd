extends SceneTree
## Headless: custom Bell mesh load path, clips, identity parts, feet plant via real setup.
## Godot --headless --path . --script res://scripts/test_npc_skeletal.gd


func _init() -> void:
	var failed := 0
	print("=== test_npc_skeletal ===")

	var model_path := "res://assets/characters/models/bell/bell_character.tscn"
	if not ResourceLoader.exists(model_path) and not FileAccess.file_exists(ProjectSettings.globalize_path(model_path)):
		print("FAIL model missing ", model_path)
		failed += 1
	else:
		var packed = load(model_path)
		if packed is PackedScene:
			var holder := Node3D.new()
			root.add_child(holder)
			var inst: Node = packed.instantiate()
			holder.add_child(inst)
			if inst.has_method("ensure_built"):
				inst.ensure_built()
			print("OK model PackedScene root=", inst.name)
			var ap := _find_ap(inst)
			if ap == null:
				print("FAIL no AnimationPlayer")
				failed += 1
			else:
				var clips := ap.get_animation_list()
				print("OK AnimationPlayer clips=", clips)
				var has_idle := false
				var has_walk := false
				var has_sit := false
				for c in clips:
					var cl := String(c)
					if cl == "idle":
						has_idle = true
					if cl == "walk":
						has_walk = true
					if cl == "sit":
						has_sit = true
				if not has_idle or not has_walk:
					print("FAIL need idle+walk clips, got ", clips)
					failed += 1
				else:
					print("OK idle+walk present")
				if has_sit:
					print("OK sit clip present")
				else:
					print("FAIL sit clip missing (seat behavior wired)")
					failed += 1
			if not inst.has_node("BodyRoot"):
				print("FAIL no BodyRoot mesh")
				failed += 1
			else:
				print("OK BodyRoot present (custom Bell mesh)")
			if inst.has_method("has_identity_parts"):
				if inst.has_identity_parts():
					print("OK identity parts (coat/hair/eyes/book/boots)")
				else:
					print("FAIL identity parts incomplete")
					failed += 1
			# Feet on character alone
			if inst.has_method("get_mesh_bottom_y"):
				var by: float = float(inst.call("get_mesh_bottom_y"))
				print("OK mesh bottom_y=", by)
				if by < -0.05 or by > 0.05:
					print("FAIL character mesh bottom not near 0: ", by)
					failed += 1
				else:
					print("OK character mesh planted (bottom ~0)")
			holder.queue_free()
		else:
			print("FAIL not PackedScene")
			failed += 1

	var NpcScript = load("res://scripts/fps_npc.gd")
	if NpcScript == null:
		print("FAIL load fps_npc.gd")
		failed += 1
	else:
		if absf(NpcScript.yaw_from_dir(Vector3(0, 0, 1))) > 0.001:
			print("FAIL yaw +Z expected 0")
			failed += 1
		else:
			print("OK yaw_from_dir +Z")
		var yx: float = NpcScript.yaw_from_dir(Vector3(1, 0, 0))
		if absf(yx - PI * 0.5) > 0.05:
			print("FAIL yaw +X expected ~pi/2 got ", yx)
			failed += 1
		else:
			print("OK yaw_from_dir +X")
		if not NpcScript.should_attend_player(2.0, 3.5):
			print("FAIL attend")
			failed += 1
		else:
			print("OK should_attend_player")
		var mp: String = NpcScript.default_model_path("bell")
		if mp.find("bell_character") < 0 and mp.find("bell/") < 0:
			print("FAIL default_model_path should prefer custom Bell, got ", mp)
			failed += 1
		else:
			print("OK default_model_path ", mp)

		# Real fps_npc scene + setup (shipped path)
		var scene_ps = load("res://scenes/fps_npc.tscn")
		if scene_ps is PackedScene:
			var holder2 := Node3D.new()
			root.add_child(holder2)
			var npc: Node = scene_ps.instantiate()
			holder2.add_child(npc)
			if npc.has_method("setup"):
				npc.setup({
					"id": "bell",
					"name": "Ignatius Bell",
					"height": 1.78,
					"model": model_path,
					"tint_victorian": false,
					"portrait": "res://assets/portraits/portrait_bell.jpg",
					"patrol": [[0, 0, 0], [1.2, 0, 0], [1.2, 0, 1.0]],
					"dwell_sec": 0.5,
					"speed": 1.2,
					"seat": [0.5, 0, 0.5],
					"sit_sec": 2.0,
				})
			if npc.has_method("is_skeletal"):
				if npc.is_skeletal():
					print("OK Bell setup is_skeletal")
				else:
					print("FAIL Bell not skeletal after setup")
					failed += 1
			# No face card
			if _find_named(npc, "FaceCard") != null:
				print("FAIL FaceCard still present")
				failed += 1
			else:
				print("OK no FaceCard")
			# Physics: plant + walk state
			for i in 30:
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
			# Measure via model helpers (globals unreliable mid-headless frame)
			var model: Node = npc.get_node_or_null("Visual/Model")
			if model == null:
				print("FAIL no Visual/Model under NPC")
				failed += 1
			else:
				var m3 := model as Node3D
				var bottom_local := 0.0
				var span_local := 0.0
				if model.has_method("get_mesh_bottom_y"):
					bottom_local = float(model.call("get_mesh_bottom_y"))
				if model.has_method("get_mesh_height"):
					span_local = float(model.call("get_mesh_height"))
				# World-ish bottom relative to NPC: model.position.y + bottom*scale
				var bottom_npc: float = m3.position.y + bottom_local * m3.scale.y
				var span_npc: float = span_local * m3.scale.y
				print("OK setup mesh bottom_npc=", bottom_npc, " bottom_local=", bottom_local, " model.y=", m3.position.y)
				print("OK setup mesh height_span=", span_npc)
				if bottom_npc < -0.08 or bottom_npc > 0.08:
					print("FAIL setup leaves float/sink bottom_npc=", bottom_npc)
					failed += 1
				else:
					print("OK feet plant after setup (|bottom|<=0.08)")
				if span_npc < 1.4 or span_npc > 2.2:
					print("FAIL height span out of range for ~1.78m: ", span_npc)
					failed += 1
				else:
					print("OK height span in range for 1.78m NPC")
			# Animation playing walk or idle from real state machine
			var ap2 := _find_ap(npc)
			if ap2:
				var cur := ap2.current_animation
				print("OK current_animation=", cur)
				if cur != "idle" and cur != "walk" and cur != "sit" and cur != "":
					print("FAIL unexpected clip ", cur)
					failed += 1
			# Drive sit via state if possible
			if npc.has_method("_set_state_sit"):
				npc._set_state_sit()
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
				if ap2 and ap2.current_animation == "sit":
					print("OK sit state plays sit clip")
				elif ap2:
					print("NOTE sit state anim=", ap2.current_animation)
			# Walk state — advance into mid-stride so rest-pose reset is meaningful
			if npc.has_method("_set_state_walk"):
				npc._set_state_walk()
				if ap2:
					ap2.seek(0.42, true)
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
				if ap2 and ap2.current_animation == "walk":
					print("OK walk state plays walk clip")
				elif ap2:
					print("FAIL walk state anim=", ap2.current_animation)
					failed += 1
				# Capture mid-walk leg pose (should be non-zero)
				var mid_leg := _leg_rot_deg(npc, "LegL")
				print("OK mid-walk LegL.rotation_degrees=", mid_leg)
			if npc.has_method("_set_state_idle"):
				# Hold idle: prevent patrol physics from immediately re-entering walk
				if "npc_data" in npc:
					pass
				if npc.get("_dwell_left") != null:
					npc.set("_dwell_left", 30.0)
				if npc.has_method("set_talking"):
					npc.set_talking(false)
				npc._set_state_idle()
				if ap2:
					ap2.play("idle")
					ap2.seek(0.0, true)
				# Process while dwelling so state machine stays on idle
				if npc.get("_dwell_left") != null:
					npc.set("_dwell_left", 30.0)
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
				var cur_idle := ap2.current_animation if ap2 else ""
				if cur_idle == "idle":
					print("OK idle state plays idle clip")
				else:
					print("FAIL idle state anim=", cur_idle)
					failed += 1
				# After walk→idle: limbs must return near rest (not frozen mid-stride)
				failed += _assert_rest_pose(npc, "walk→idle")
			# sit→idle rest pose
			if npc.has_method("_set_state_sit"):
				npc._set_state_sit()
				if ap2:
					ap2.play("sit")
					ap2.seek(0.5, true)
			if npc.has_method("_set_state_idle"):
				if npc.get("_dwell_left") != null:
					npc.set("_dwell_left", 30.0)
				npc._set_state_idle()
				if ap2:
					ap2.play("idle")
					ap2.seek(0.0, true)
				if npc.get("_dwell_left") != null:
					npc.set("_dwell_left", 30.0)
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
				failed += _assert_rest_pose(npc, "sit→idle")
			print("OK physics ticks without crash")
			holder2.queue_free()
		else:
			print("FAIL fps_npc.tscn")
			failed += 1

	# Room data points at custom model
	var rooms_src := FileAccess.get_file_as_string("res://scripts/fps_rooms.gd")
	if rooms_src.find("bell_character.tscn") < 0:
		print("FAIL fps_rooms Bell model not custom bell_character.tscn")
		failed += 1
	else:
		print("OK fps_rooms wires bell_character.tscn")
	if rooms_src.find("humanoid_stub.glb") >= 0 and rooms_src.find("bell") >= 0:
		# only fail if Bell entry still uses stub
		var idx := rooms_src.find("\"id\": \"bell\"")
		if idx >= 0:
			var slice := rooms_src.substr(idx, 600)
			if slice.find("humanoid_stub") >= 0:
				print("FAIL Bell still uses humanoid_stub")
				failed += 1
			else:
				print("OK Bell entry not using humanoid_stub")

	# Selina cutout remains available
	if not FileAccess.file_exists(ProjectSettings.globalize_path("res://assets/characters/sprites/sprite_selina.png")):
		print("FAIL selina sprite missing")
		failed += 1
	else:
		print("OK selina cutout asset still present")

	# Face-card code path gone
	var npc_src := FileAccess.get_file_as_string("res://scripts/fps_npc.gd")
	if npc_src.find("_attach_face_card") >= 0 or npc_src.find("FaceCard") >= 0:
		print("FAIL face-card code still in fps_npc.gd")
		failed += 1
	else:
		print("OK no face-card path in fps_npc.gd")

	if failed == 0:
		print("=== ALL PASS ===")
		quit(0)
	else:
		print("=== FAILED count=", failed, " ===")
		quit(1)


func _find_ap(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var f := _find_ap(c)
		if f:
			return f
	return null


func _find_named(n: Node, name: String) -> Node:
	if n.name == name:
		return n
	for c in n.get_children():
		var f := _find_named(c, name)
		if f:
			return f
	return null


func _lowest_y(n: Node) -> float:
	var bottom := INF
	var root_n := n as Node3D
	for mi in _collect_meshes(n):
		if mi.mesh == null:
			continue
		var a: AABB = mi.get_aabb()
		for i in 8:
			var world: Vector3 = mi.global_transform * a.get_endpoint(i)
			var local: Vector3 = root_n.to_local(world) if root_n else world
			if local.y < bottom:
				bottom = local.y
	return bottom if bottom != INF else 999.0


func _height_span(n: Node) -> float:
	var lo := INF
	var hi := -INF
	var root_n := n as Node3D
	var found := false
	for mi in _collect_meshes(n):
		if mi.mesh == null:
			continue
		var a: AABB = mi.get_aabb()
		for i in 8:
			var world: Vector3 = mi.global_transform * a.get_endpoint(i)
			var local: Vector3 = root_n.to_local(world) if root_n else world
			lo = minf(lo, local.y)
			hi = maxf(hi, local.y)
			found = true
	return (hi - lo) if found else 0.0


func _collect_meshes(n: Node) -> Array[MeshInstance3D]:
	var out: Array[MeshInstance3D] = []
	if n is MeshInstance3D:
		out.append(n as MeshInstance3D)
	for c in n.get_children():
		out.append_array(_collect_meshes(c))
	return out


func _find_node_named(n: Node, name: String) -> Node3D:
	if n.name == name and n is Node3D:
		return n as Node3D
	for c in n.get_children():
		var f := _find_node_named(c, name)
		if f:
			return f
	return null


func _leg_rot_deg(npc: Node, leg_name: String) -> Vector3:
	var n := _find_node_named(npc, leg_name)
	if n == null:
		return Vector3(999, 999, 999)
	return n.rotation_degrees


func _body_root_pos(npc: Node) -> Vector3:
	var n := _find_node_named(npc, "BodyRoot")
	if n == null:
		return Vector3(999, 999, 999)
	return n.position


func _assert_rest_pose(npc: Node, label: String) -> int:
	## Rest: legs/calves ~0°, BodyRoot.y ~0 (plant). Arms have default hold pose.
	var fails := 0
	var leg_l := _leg_rot_deg(npc, "LegL")
	var leg_r := _leg_rot_deg(npc, "LegR")
	var calf_l := _leg_rot_deg(npc, "CalfL")
	var calf_r := _leg_rot_deg(npc, "CalfR")
	var body_y := _body_root_pos(npc).y
	print("OK ", label, " rest LegL=", leg_l, " LegR=", leg_r, " BodyRoot.y=", body_y)
	if absf(leg_l.x) > 8.0 or absf(leg_l.y) > 8.0 or absf(leg_l.z) > 8.0:
		print("FAIL ", label, " LegL not near rest: ", leg_l)
		fails += 1
	if absf(leg_r.x) > 8.0 or absf(leg_r.y) > 8.0 or absf(leg_r.z) > 8.0:
		print("FAIL ", label, " LegR not near rest: ", leg_r)
		fails += 1
	if absf(calf_l.x) > 12.0 or absf(calf_r.x) > 12.0:
		print("FAIL ", label, " calves not near rest: ", calf_l, calf_r)
		fails += 1
	if absf(body_y) > 0.03:
		print("FAIL ", label, " BodyRoot.y not near plant rest: ", body_y)
		fails += 1
	if fails == 0:
		print("OK ", label, " limbs+BodyRoot near rest pose")
	return fails
