extends SceneTree
## Headless: Bell 3D model loads; skeletal NPC setup; pure helpers.
## Godot --headless --path . --script res://scripts/test_npc_skeletal.gd


func _init() -> void:
	var failed := 0
	print("=== test_npc_skeletal ===")

	var model_path := "res://assets/characters/models/bell/humanoid_stub.glb"
	if not ResourceLoader.exists(model_path):
		print("FAIL model missing ", model_path)
		failed += 1
	else:
		var packed = load(model_path)
		if packed is PackedScene:
			var inst: Node = packed.instantiate()
			print("OK model PackedScene root=", inst.name)
			var ap := _find_ap(inst)
			if ap == null:
				print("FAIL no AnimationPlayer")
				failed += 1
			else:
				var clips := ap.get_animation_list()
				print("OK AnimationPlayer clips=", clips)
				if clips.is_empty():
					print("FAIL empty clips")
					failed += 1
			var sk := _find_sk(inst)
			if sk == null:
				print("FAIL no Skeleton3D")
				failed += 1
			else:
				print("OK Skeleton3D bones=", sk.get_bone_count())
			inst.free()
		else:
			print("FAIL not PackedScene")
			failed += 1

	var NpcScript = load("res://scripts/fps_npc.gd")
	if NpcScript == null:
		print("FAIL load fps_npc.gd")
		failed += 1
	else:
		# Pure helpers
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
		if mp.find("bell") < 0:
			print("FAIL default_model_path ", mp)
			failed += 1
		else:
			print("OK default_model_path ", mp)

		# Instantiate scene and setup Bell skeletal
		var scene_ps = load("res://scenes/fps_npc.tscn")
		if scene_ps is PackedScene:
			var npc: Node = scene_ps.instantiate()
			# Need tree for some APIs — add to root
			var holder := Node3D.new()
			root.add_child(holder)
			holder.add_child(npc)
			if npc.has_method("setup"):
				npc.setup({
					"id": "bell",
					"name": "Ignatius Bell",
					"height": 1.78,
					"model": model_path,
					"tint_victorian": true,
					"patrol": [[0, 0, 0], [1, 0, 0], [1, 0, 1]],
					"dwell_sec": 2.0,
					"speed": 0.9,
				})
			if npc.has_method("is_skeletal"):
				if npc.is_skeletal():
					print("OK Bell setup is_skeletal")
				else:
					print("FAIL Bell not skeletal after setup")
					failed += 1
			else:
				print("FAIL no is_skeletal")
				failed += 1
			# Simulate a few physics frames
			for i in 5:
				if npc.has_method("_physics_process"):
					npc._physics_process(0.05)
			print("OK physics ticks without crash")
			holder.queue_free()
		else:
			print("FAIL fps_npc.tscn")
			failed += 1

	# Selina still cutout-capable (no model)
	if not FileAccess.file_exists(ProjectSettings.globalize_path("res://assets/characters/sprites/sprite_selina.png")):
		print("FAIL selina sprite missing")
		failed += 1
	else:
		print("OK selina cutout asset still present")

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


func _find_sk(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var f := _find_sk(c)
		if f:
			return f
	return null
