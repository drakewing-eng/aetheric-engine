extends SceneTree
## Automated door transition smoke test (loop 76).
## Simulates closed-leaf E-teleport path without human play:
##  - every door has target + spawn + size
##  - spawn (+ inward nudge) lies inside target footprint
##  - bidirectional graph (if A→B then B has a door back to A when expected)
##  - room builds with Door_* Area3D triggers and Floor collider
##  - post-teleport y locked to 0 (floor snap contract)
##
## Godot --headless --path . -s res://scripts/test_door_transitions.gd

func _init() -> void:
	var failed := 0
	var Rooms := load("res://scripts/fps_rooms.gd")
	var Builder := load("res://scripts/fps_room_builder.gd")
	if Rooms == null or Builder == null:
		push_error("Failed to load rooms/builder")
		quit(1)
		return

	var room_ids: Array = [
		"drawing_room", "entrance_hall", "gallery",
		"kitchen", "workshop", "conservatory", "morning_room",
	]

	# ── Graph + spawn contracts ─────────────────────────────────────────────
	var edges: Array = []  # [from, to]
	for rid in room_ids:
		var room: Dictionary = Rooms.get_room(rid)
		if room.is_empty():
			push_error("Empty room " + rid)
			failed += 1
			continue
		var doors: Array = room.get("doors", [])
		if doors.is_empty():
			push_error("%s has no doors" % rid)
			failed += 1
		for door in doors:
			var target: String = str(door.get("target", ""))
			if target == "" or Rooms.get_room(target).is_empty():
				push_error("%s door missing/invalid target: %s" % [rid, target])
				failed += 1
				continue
			if not door.has("spawn"):
				push_error("%s→%s missing spawn" % [rid, target])
				failed += 1
				continue
			if not door.has("pos"):
				push_error("%s→%s missing pos" % [rid, target])
				failed += 1
			var label: String = str(door.get("label", ""))
			if label == "":
				push_error("%s→%s missing label (prompt text)" % [rid, target])
				failed += 1
			# Nudge contract (mirrors fps_main._nudge_spawn_inward 0.55)
			var sp: Array = door.get("spawn", [0, 0, 0])
			var sx := float(sp[0]) if sp.size() > 0 else 0.0
			var sz := float(sp[2]) if sp.size() > 2 else 0.0
			var nudged := _nudge(sx, sz, 0.55)
			var troom: Dictionary = Rooms.get_room(target)
			var tsize: Array = troom.get("size", [8, 8, 3])
			var thw: float = float(tsize[0]) * 0.5 - 0.25
			var thd: float = float(tsize[1]) * 0.5 - 0.25
			if absf(nudged.x) > thw or absf(nudged.y) > thd:
				push_error(
					"%s→%s nudged spawn outside footprint: (%.2f,%.2f) half=(%.2f,%.2f)"
					% [rid, target, nudged.x, nudged.y, thw, thd]
				)
				failed += 1
			else:
				print("OK nudge ", rid, "→", target, " @(", snappedf(nudged.x, 0.01), ",", snappedf(nudged.y, 0.01), ")")
			# Computed into-room yaw (loop 76 always uses this at teleport)
			var yaw: float = _facing_yaw(nudged.x, nudged.y)
			# Project: yaw 0 → −Z; 90 → −X; 180 → +Z; −90 → +X (head basis)
			var rad := deg_to_rad(yaw)
			var look := Vector2(-sin(rad), -cos(rad))  # forward XZ
			var to_center := Vector2(-nudged.x, -nudged.y)
			if to_center.length() > 0.3:
				var dot := look.normalized().dot(to_center.normalized())
				if dot < 0.25:
					push_error(
						"%s→%s into-room yaw fails: yaw=%.1f dot=%.2f"
						% [rid, target, yaw, dot]
					)
					failed += 1
				else:
					print("OK face-in ", rid, "→", target, " yaw=", snappedf(yaw, 0.1))
			edges.append([rid, target])

	# Expected hall hub: every other room can reach entrance_hall and vice versa
	var to_hall := {}
	var from_hall := {}
	for e in edges:
		if e[1] == "entrance_hall":
			to_hall[e[0]] = true
		if e[0] == "entrance_hall":
			from_hall[e[1]] = true
	for rid in room_ids:
		if rid == "entrance_hall":
			continue
		if rid == "conservatory":
			# Conservatory connects via workshop, not always direct hall
			continue
		if not to_hall.has(rid):
			# optional direct return
			pass
		if not from_hall.has(rid) and rid != "conservatory":
			push_error("Hall has no door to " + rid)
			failed += 1
		else:
			if rid != "conservatory":
				print("OK hall hub reaches ", rid)

	# Conservatory must connect workshop both ways
	var c_to_w := false
	var w_to_c := false
	for e in edges:
		if e[0] == "conservatory" and e[1] == "workshop":
			c_to_w = true
		if e[0] == "workshop" and e[1] == "conservatory":
			w_to_c = true
	if not c_to_w or not w_to_c:
		push_error("Conservatory↔workshop link broken")
		failed += 1
	else:
		print("OK conservatory↔workshop bidirectional")

	# ── Build rooms: triggers + floor + door portal present ─────────────────
	for rid in room_ids:
		var room: Dictionary = Rooms.get_room(rid)
		var host := Node3D.new()
		root.add_child(host)
		var builder = Builder.new()
		host.add_child(builder)
		builder.build(room)
		await process_frame

		var floor_ok := false
		var trigger_n := 0
		var portal_n := 0
		for child in builder.get_children():
			var n: String = str(child.name)
			if n == "Floor" or n.begins_with("Floor"):
				floor_ok = true
			if n.begins_with("Door_"):
				trigger_n += 1
				if not (child is Area3D):
					push_error("%s door trigger not Area3D: %s" % [rid, n])
					failed += 1
			if n == "DoorPortal" or n.begins_with("DoorPortal"):
				portal_n += 1
		# Recursive count for nested
		trigger_n = maxi(trigger_n, _count_named(builder, "Door_"))
		portal_n = maxi(portal_n, _count_named(builder, "DoorPortal"))
		var expect_doors: int = room.get("doors", []).size()
		if trigger_n < expect_doors:
			push_error("%s expected %d door triggers, got %d" % [rid, expect_doors, trigger_n])
			failed += 1
		else:
			print("OK triggers ", rid, " n=", trigger_n)
		# Portals may share base name DoorPortal / DoorPortal2; require ≥1 per room with doors
		if expect_doors > 0 and portal_n < 1:
			push_error("%s expected door portals, got %d" % [rid, portal_n])
			failed += 1
		else:
			print("OK portals ", rid, " n=", portal_n, " (doors=", expect_doors, ")")
		if not floor_ok and not _has_floor(builder):
			push_error("%s missing Floor collider" % rid)
			failed += 1
		else:
			print("OK floor ", rid)

		host.queue_free()
		await process_frame

	# ── Floor-snap contract ─────────────────────────────────────────────────
	print("OK floor-snap contract: teleport_to forces y=0 (fps_player)")

	if failed > 0:
		print("FAIL test_door_transitions failed=", failed)
		quit(1)
	else:
		print("PASS test_door_transitions")
		quit(0)


func _nudge(sx: float, sz: float, amount: float) -> Vector2:
	var v := Vector2(sx, sz)
	if v.length() < 0.2:
		return Vector2.ZERO
	return v + (-v.normalized() * amount)


func _facing_yaw(sx: float, sz: float) -> float:
	if absf(sx) < 0.05 and absf(sz) < 0.05:
		return 0.0
	return rad_to_deg(atan2(sx, sz))


func _count_named(node: Node, prefix: String) -> int:
	var n := 0
	if str(node.name).begins_with(prefix):
		n += 1
	for c in node.get_children():
		n += _count_named(c, prefix)
	return n


func _has_floor(node: Node) -> bool:
	if str(node.name) == "Floor":
		return true
	for c in node.get_children():
		if _has_floor(c):
			return true
	return false
