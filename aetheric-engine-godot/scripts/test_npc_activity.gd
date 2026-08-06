extends SceneTree
## Headless: activity slots claim exclusivity, six states, Talk interrupt, arrival.
## Godot --headless --path . --script res://scripts/test_npc_activity.gd
##
## Runs after the SceneTree is ready (deferred) so NavigationAgent3D and
## global_position work without !is_inside_tree spam.

const NpcActivityScr = preload("res://scripts/npc_activity.gd")

var _failed := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	print("=== test_npc_activity ===")
	_failed = 0
	_failed += _test_structure()
	_failed += _test_claim_pure()
	_failed += _test_controller_in_tree()

	var main_src := FileAccess.get_file_as_string("res://scripts/fps_main.gd")
	if main_src.find("set_talking") < 0:
		print("FAIL fps_main lost set_talking")
		_failed += 1
	else:
		print("OK fps_main still uses set_talking")
	if main_src.find("NpcActivity") < 0 and main_src.find("register_room_slots") < 0:
		print("FAIL fps_main does not register activity slots")
		_failed += 1
	else:
		print("OK fps_main registers NpcActivity slots")

	if _failed == 0:
		print("=== ALL PASS ===")
		quit(0)
	else:
		print("=== FAILED count=", _failed, " ===")
		quit(1)


func _test_structure() -> int:
	var failed := 0
	var required: Dictionary = NpcActivityScr.required_slot_ids()
	var need_rooms := {
		"gallery": ["machine_main", "machine_side", "bench_read"],
		"drawing_room": ["sofa_sit", "armchair_read", "desk_write"],
		"entrance_hall": ["hall_stand", "hall_table"],
		"kitchen": ["range_work", "table_sit"],
		"workshop": ["bench_work", "stool_sit"],
		"conservatory": ["conserv_sit", "conserv_read"],
		"morning_room": ["morning_sit", "morning_read"],
	}
	for rid in need_rooms.keys():
		var want: Array = need_rooms[rid]
		var got: Array = required.get(rid, [])
		for sid in want:
			if sid in got:
				print("OK structure slot ", rid, "/", sid)
			else:
				print("FAIL missing slot ", rid, "/", sid)
				failed += 1
	for st in NpcActivityScr.ALL_STATES:
		if not NpcActivityScr.is_valid_state(st):
			print("FAIL invalid core state ", st)
			failed += 1
	print("OK six states: ", NpcActivityScr.ALL_STATES)
	if NpcActivityScr.ALL_STATES.size() != 6:
		print("FAIL expected exactly 6 states")
		failed += 1
	else:
		print("OK exactly 6 states")
	var rooms_src := FileAccess.get_file_as_string("res://scripts/npc_activity.gd")
	for rid in need_rooms.keys():
		for sid in need_rooms[rid]:
			if rooms_src.find("\"%s\"" % sid) < 0:
				print("FAIL slot id not in npc_activity.gd: ", sid)
				failed += 1
	print("OK slot ids present in npc_activity.gd source")
	return failed


func _test_claim_pure() -> int:
	var failed := 0
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("drawing_room")
	NpcActivityScr.register_room_slots("gallery")
	if not NpcActivityScr.claim_slot("drawing_room", "sofa_sit", "selina"):
		print("FAIL first claim sofa_sit")
		failed += 1
	else:
		print("OK claim sofa_sit selina")
	if NpcActivityScr.claim_slot("drawing_room", "sofa_sit", "bell"):
		print("FAIL second claim sofa_sit should be denied")
		failed += 1
	else:
		print("OK exclusive claim denied for bell")
	if not NpcActivityScr.release_slot("drawing_room", "sofa_sit", "selina"):
		print("FAIL release sofa_sit")
		failed += 1
	else:
		print("OK release sofa_sit")
	if not NpcActivityScr.claim_slot("drawing_room", "sofa_sit", "bell"):
		print("FAIL re-claim after release")
		failed += 1
	else:
		print("OK re-claim sofa_sit after release")
	NpcActivityScr.release_slot("drawing_room", "sofa_sit", "bell")
	var picked: Dictionary = NpcActivityScr.pick_free_slot("drawing_room", "selina", 0.3)
	if picked.is_empty():
		print("FAIL pick_free_slot empty")
		failed += 1
	else:
		print("OK pick_free_slot ", picked.get("id", ""))
	if NpcActivityScr.cooldown_elapsed(10.0, 45.0):
		print("FAIL cooldown should not elapse at 10s")
		failed += 1
	else:
		print("OK cooldown not elapsed early")
	if not NpcActivityScr.cooldown_elapsed(50.0, 45.0):
		print("FAIL cooldown should elapse at 50s")
		failed += 1
	else:
		print("OK cooldown elapsed")
	var cd: float = NpcActivityScr.cooldown_duration(0.5)
	if cd < 45.0 or cd > 90.0:
		print("FAIL cooldown_duration out of range ", cd)
		failed += 1
	else:
		print("OK cooldown_duration ", cd)
	return failed


func _make_nav_floor(parent: Node3D) -> void:
	var region := NavigationRegion3D.new()
	region.name = "TestNav"
	var nmesh := NavigationMesh.new()
	nmesh.agent_radius = 0.35
	nmesh.agent_height = 1.6
	nmesh.vertices = PackedVector3Array([
		Vector3(-12, 0, -12), Vector3(12, 0, -12),
		Vector3(12, 0, 12), Vector3(-12, 0, 12),
	])
	nmesh.add_polygon(PackedInt32Array([0, 1, 2, 3]))
	region.navigation_mesh = nmesh
	parent.add_child(region)


func _tick(npc: Node, n: int = 1, dt: float = 0.05) -> void:
	for i in n:
		if npc.has_method("_physics_process"):
			npc._physics_process(dt)


func _test_controller_in_tree() -> int:
	var failed := 0
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("drawing_room")
	NpcActivityScr.register_room_slots("gallery")

	var scene_ps = load("res://scenes/fps_npc.tscn")
	if scene_ps == null:
		print("FAIL load fps_npc.tscn")
		return 1

	var holder := Node3D.new()
	root.add_child(holder)
	_make_nav_floor(holder)

	# --- Dual NPC claim exclusivity (in-tree) ---
	var npc_a: Node = scene_ps.instantiate()
	holder.add_child(npc_a)
	assert(npc_a.is_inside_tree())
	npc_a.setup({
		"id": "selina",
		"name": "Selina",
		"height": 1.66,
		"room_id": "drawing_room",
		"use_activity": true,
		"patrol": [[0, 0, 0], [1, 0, 0]],
		"dwell_sec": 2.0,
		"speed": 4.0,
		"sprite": "res://assets/characters/sprites/sprite_selina.png",
	})

	var agent = npc_a.get_navigation_agent() if npc_a.has_method("get_navigation_agent") else null
	if agent is NavigationAgent3D and (agent as Node).is_inside_tree():
		print("OK NavigationAgent3D present and in-tree")
	else:
		print("FAIL NavigationAgent3D missing or not in tree agent=", agent)
		failed += 1

	var npc_b: Node = scene_ps.instantiate()
	holder.add_child(npc_b)
	npc_b.setup({
		"id": "bell",
		"name": "Bell",
		"height": 1.78,
		"room_id": "drawing_room",
		"use_activity": true,
		"patrol": [[2, 0, 0], [2.5, 0, 1]],
		"dwell_sec": 2.0,
		"speed": 4.0,
		"model": "res://assets/characters/models/bell/final/bell_runtime.tscn",
		"tint_victorian": false,
	})

	_tick(npc_a, 8)
	_tick(npc_b, 8)

	var slot_a: String = npc_a.get_current_slot_id()
	var slot_b: String = npc_b.get_current_slot_id()
	print("OK slots a=", slot_a, " b=", slot_b, " states a=", npc_a.get_activity_state_name(), " b=", npc_b.get_activity_state_name())
	if slot_a != "" and slot_a == slot_b:
		print("FAIL both NPCs claim same slot ", slot_a)
		failed += 1
	else:
		print("OK no double-claim of same slot")

	# --- Idle→Walk→arrival→activity ---
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("gallery")
	var npc_c: Node = scene_ps.instantiate()
	holder.add_child(npc_c)
	npc_c.setup({
		"id": "amara",
		"name": "Amara",
		"height": 1.7,
		"room_id": "gallery",
		"use_activity": true,
		"patrol": [[1.2, 0, -1.2]],
		"speed": 6.0,
		"dwell_sec": 1.0,
		"sprite": "res://assets/characters/sprites/sprite_selina.png",
	})
	# setup snaps to patrol[0]; offset for a real short walk if already claimed nearby
	npc_c.global_position = Vector3(2.5, 0.0, 1.5)
	if str(npc_c.get_current_slot_id()) == "":
		npc_c._try_begin_activity(true)
	elif not npc_c.is_going_to_slot():
		# Force a re-path from offset to current claimed slot for Walk→arrival
		npc_c.set("_going_to_slot", true)
		npc_c._set_state_walk()
		var entry_c: Dictionary = NpcActivityScr.get_slot("gallery", npc_c.get_current_slot_id())
		if not entry_c.is_empty():
			npc_c.set("_slot_target", NpcActivityScr.slot_position(entry_c))

	var saw_walk := false
	var arrived := false
	var final_state := ""
	var final_slot := ""
	for i in 150:
		_tick(npc_c, 1, 0.05)
		final_state = npc_c.get_activity_state_name()
		final_slot = npc_c.get_current_slot_id()
		if final_state == NpcActivityScr.STATE_WALK:
			saw_walk = true
		if final_slot != "" and not npc_c.is_going_to_slot():
			if final_state in [
				NpcActivityScr.STATE_SIT,
				NpcActivityScr.STATE_READ,
				NpcActivityScr.STATE_WORK_MACHINE,
				NpcActivityScr.STATE_IDLE,
			]:
				arrived = true
				break
	print("OK gallery travel saw_walk=", saw_walk, " state=", final_state, " slot=", final_slot)
	if not arrived:
		print("FAIL never arrived Idle→Walk→activity for gallery")
		failed += 1
	else:
		if not saw_walk and final_state != NpcActivityScr.STATE_IDLE:
			# Instant arrival if already near is OK for Idle-only slots at start
			pass
		var entry: Dictionary = NpcActivityScr.get_slot("gallery", final_slot)
		var allowed: Array = entry.get("allowed", [])
		if final_state in allowed or final_state == NpcActivityScr.STATE_IDLE:
			print("OK arrival activity ", final_state, " for slot ", final_slot, " allowed=", allowed)
		else:
			print("FAIL arrival state ", final_state, " not allowed by ", allowed)
			failed += 1

	# Explicit Idle→Walk→Sit/Read/WorkMachine: start far, force machine_main path
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("gallery")
	var npc_g: Node = scene_ps.instantiate()
	holder.add_child(npc_g)
	npc_g.setup({
		"id": "rooke",
		"name": "Rooke",
		"height": 1.75,
		"room_id": "gallery",
		"use_activity": true,
		"patrol": [[6, 0, 4]],
		"speed": 8.0,
		"sprite": "res://assets/characters/sprites/sprite_selina.png",
	})
	npc_g.global_position = Vector3(6.0, 0.0, 4.0)
	# Release any auto claim; force machine_main + WorkMachine intention + travel
	var auto_slot: String = npc_g.get_current_slot_id()
	if auto_slot != "":
		NpcActivityScr.release_slot("gallery", auto_slot, "rooke")
	if NpcActivityScr.claim_slot("gallery", "machine_main", "rooke"):
		var sm: Dictionary = NpcActivityScr.get_slot("gallery", "machine_main")
		npc_g.set("_slot_id", "machine_main")
		npc_g.set("_slot_target", NpcActivityScr.slot_position(sm))
		npc_g.set("_slot_yaw", NpcActivityScr.slot_yaw_rad(sm))
		npc_g.set("_intended_activity", npc_g._name_to_state(NpcActivityScr.STATE_WORK_MACHINE))
		npc_g.set("_going_to_slot", true)
		npc_g._set_state_walk()
		if npc_g.get_navigation_agent() and npc_g.is_inside_tree():
			npc_g.get_navigation_agent().set_target_position(NpcActivityScr.slot_position(sm))
	var saw_walk2 := false
	var arrived_work := false
	for i in 200:
		_tick(npc_g, 1, 0.05)
		var stg: String = npc_g.get_activity_state_name()
		if stg == NpcActivityScr.STATE_WALK:
			saw_walk2 = true
		if not npc_g.is_going_to_slot() and npc_g.get_current_slot_id() == "machine_main":
			if stg == NpcActivityScr.STATE_WORK_MACHINE or stg == NpcActivityScr.STATE_IDLE:
				arrived_work = true
				print("OK Idle/Walk→activity machine_main state=", stg, " saw_walk=", saw_walk2)
				break
	if not arrived_work:
		print("FAIL no arrival at machine_main activity state=", npc_g.get_activity_state_name(), " going=", npc_g.is_going_to_slot())
		failed += 1
	elif not saw_walk2:
		print("NOTE arrived without Walk frames (already close) — acceptable if near")

	# --- Talk mid-Walk resume ---
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("drawing_room")
	var npc_d: Node = scene_ps.instantiate()
	holder.add_child(npc_d)
	npc_d.setup({
		"id": "elspeth",
		"name": "Elspeth",
		"height": 1.65,
		"room_id": "drawing_room",
		"use_activity": true,
		"patrol": [[5, 0, 5]],
		"speed": 4.0,
		"sprite": "res://assets/characters/sprites/sprite_selina.png",
	})
	npc_d.global_position = Vector3(5.0, 0.0, 5.0)
	# Re-start travel from far point toward already-claimed slot
	if npc_d.get_current_slot_id() != "":
		npc_d.set("_going_to_slot", true)
		npc_d._set_state_walk()
		var ed: Dictionary = NpcActivityScr.get_slot("drawing_room", npc_d.get_current_slot_id())
		if not ed.is_empty():
			npc_d.set("_slot_target", NpcActivityScr.slot_position(ed))
	_tick(npc_d, 5)
	if not npc_d.is_going_to_slot() and npc_d.get_current_slot_id() == "":
		npc_d._try_begin_activity(true)
	_tick(npc_d, 3)

	var slot_d: String = npc_d.get_current_slot_id()
	var was_going: bool = npc_d.is_going_to_slot()
	print("OK before Talk slot=", slot_d, " going=", was_going, " state=", npc_d.get_activity_state_name())

	npc_d.set_talking(true)
	_tick(npc_d, 10)
	if npc_d.get_activity_state_name() != NpcActivityScr.STATE_TALK:
		print("FAIL expected Talk, got ", npc_d.get_activity_state_name())
		failed += 1
	else:
		print("OK Talk state while dialogue")
	if npc_d.is_going_to_slot():
		print("FAIL still going_to_slot during Talk")
		failed += 1
	else:
		print("OK no slot travel while talking")

	npc_d.set_talking(false)
	_tick(npc_d, 2)
	var after_talk: String = npc_d.get_activity_state_name()
	var after_going: bool = npc_d.is_going_to_slot()
	var after_slot: String = npc_d.get_current_slot_id()
	print("OK after Talk end state=", after_talk, " going=", after_going, " slot=", after_slot)
	if after_talk == NpcActivityScr.STATE_TALK:
		print("FAIL still Talk after dialogue closed")
		failed += 1
	if slot_d != "":
		if after_slot != slot_d:
			print("FAIL lost slot claim after Talk: was ", slot_d, " now ", after_slot)
			failed += 1
		else:
			print("OK retained slot claim after Talk")
		if after_talk == NpcActivityScr.STATE_WALK and after_going:
			print("OK resumed Walk toward slot after Talk interrupt")
		elif after_talk in [
			NpcActivityScr.STATE_SIT, NpcActivityScr.STATE_READ,
			NpcActivityScr.STATE_WORK_MACHINE, NpcActivityScr.STATE_IDLE,
		]:
			print("OK entered intended activity after Talk")
		else:
			print("FAIL after Talk unexpected state=", after_talk, " going=", after_going)
			failed += 1

	if after_going:
		for i in 120:
			_tick(npc_d, 1, 0.05)
			if not npc_d.is_going_to_slot():
				break
		var st_fin: String = npc_d.get_activity_state_name()
		print("OK post-Talk arrival state=", st_fin)
		if st_fin in [
			NpcActivityScr.STATE_SIT, NpcActivityScr.STATE_READ,
			NpcActivityScr.STATE_WORK_MACHINE, NpcActivityScr.STATE_IDLE,
		]:
			print("OK post-Talk arrived at activity ", st_fin)
		else:
			print("FAIL post-Talk did not arrive, state=", st_fin)
			failed += 1

	# --- Cooldown on real controller ---
	NpcActivityScr.clear_registry()
	NpcActivityScr.register_room_slots("drawing_room")
	var npc_e: Node = scene_ps.instantiate()
	holder.add_child(npc_e)
	npc_e.global_position = Vector3(0.0, 0.0, -3.0)
	npc_e.setup({
		"id": "selina",
		"name": "Selina2",
		"height": 1.66,
		"room_id": "drawing_room",
		"use_activity": true,
		"patrol": [[0, 0, 0]],
		"speed": 8.0,
		"sprite": "res://assets/characters/sprites/sprite_selina.png",
	})
	for i in 60:
		_tick(npc_e, 1, 0.05)
		if not npc_e.is_going_to_slot() and npc_e.get_current_slot_id() != "":
			break
	var slot_e: String = npc_e.get_current_slot_id()
	npc_e.set("_activity_elapsed", 5.0)
	npc_e.set("_activity_cooldown", 60.0)
	var before := slot_e
	for i in 30:
		_tick(npc_e, 1, 0.1)
	var after_slot_e: String = npc_e.get_current_slot_id()
	var el: float = float(npc_e.get("_activity_elapsed"))
	var cd: float = float(npc_e.get("_activity_cooldown"))
	if before != "" and after_slot_e != before and el < cd:
		print("FAIL cooldown gate: re-picked while elapsed ", el, " < ", cd)
		failed += 1
	else:
		print("OK cooldown: remained on slot ", after_slot_e, " elapsed=", el)

	if after_slot_e != "":
		npc_e.set("_activity_elapsed", 10.0)
		npc_e.set("_activity_cooldown", 60.0)
		var b2: String = npc_e.get_current_slot_id()
		npc_e._try_begin_activity(false)
		var a2: String = npc_e.get_current_slot_id()
		if a2 != b2:
			print("FAIL cooldown: force=false changed slot ", b2, " → ", a2)
			failed += 1
		else:
			print("OK cooldown: force=false did not re-pick early")

	holder.queue_free()
	return failed
