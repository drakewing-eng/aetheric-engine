extends Node3D

@onready var room_builder: FpsRoomBuilder = $RoomBuilder
@onready var player: CharacterBody3D = $Player
@onready var npc_root: Node3D = $Npcs
@onready var hud: CanvasLayer = $HUD
@onready var hud_label: Label = %HudLabel
@onready var bridge_status: Label = %BridgeStatus
@onready var interact_prompt: Label = %InteractPrompt
@onready var dialogue: Control = %DialoguePanel
@onready var bridge: BridgeClient = %BridgeClient

const NPC_SCENE := preload("res://scenes/fps_npc.tscn")
const NpcActivity = preload("res://scripts/npc_activity.gd")
const DOOR_PROXIMITY := 2.85  # closed leaf + narrow bound gap — needs reach from approach

var _current_room_id := "drawing_room"
var _current_doors: Array = []
var _near_npc: Node3D = null
var _near_door: Dictionary = {}
var _door_areas: Array[Area3D] = []
var _door_busy := false  # loop 76: block double-E while room rebuilds

func _ready() -> void:
	dialogue.closed.connect(_on_dialogue_closed)
	bridge.health_checked.connect(_on_health)
	bridge.check_health()
	await _load_room("drawing_room")

func _on_health(ok: bool, _detail: String) -> void:
	if ok:
		bridge_status.text = "Bridge: online (Engram + Ollama)"
		bridge_status.modulate = Color("#8cd8a4")
	else:
		bridge_status.text = "Bridge: offline — run ./run-game.sh"
		bridge_status.modulate = Color("#ff8888")

func _load_room(room_id: String, spawn_override: Variant = null, yaw_override: Variant = null) -> void:
	_current_room_id = room_id
	var room := FpsRooms.get_room(room_id)
	_current_doors = room.get("doors", [])
	hud_label.text = "Richmond House — %s · Summer 1856\n%s" % [room["title"], room["subtitle"]]

	room_builder.build(room)
	await get_tree().process_frame

	# Activity slots: register ALL slot-bearing rooms so the registry is complete;
	# NPCs still use only the current room_id. Furniture not moved.
	NpcActivity.clear_registry()
	NpcActivity.register_all_defined_rooms()
	_ensure_room_navigation(room)

	_clear_npcs()
	_spawn_npcs(room.get("npcs", []), room_id)
	_bind_doors()

	var spawn: Array = spawn_override if spawn_override != null else room.get("spawn", [0, 0, 0])
	var yaw: float = yaw_override if yaw_override != null else room.get("spawn_yaw", 180.0)
	player.teleport_to(Vector3(spawn[0], spawn[1], spawn[2]), yaw)
	player.capture_mouse()

	_near_npc = null
	_near_door = {}
	_update_prompt()

func _clear_npcs() -> void:
	for child in npc_root.get_children():
		child.queue_free()

func _spawn_npcs(npcs: Array, room_id: String = "") -> void:
	for data in npcs:
		var d: Dictionary = data.duplicate(true)
		if room_id != "":
			d["room_id"] = room_id
		var npc := NPC_SCENE.instantiate()
		npc_root.add_child(npc)
		npc.setup(d)


func _ensure_room_navigation(room: Dictionary) -> void:
	## NavigationRegion3D over walkable floor + door threshold stubs so agents can
	## reach activity slots near walls/doors. Does not move furniture.
	var existing := get_node_or_null("RoomNav") as NavigationRegion3D
	if existing:
		existing.queue_free()
	var size: Array = room.get("size", [10.0, 10.0, 3.5])
	# Near full floor (small inset) so slots at edges remain reachable
	var half_w := maxf(float(size[0]) * 0.5 - 0.12, 1.5)
	var half_d := maxf(float(size[1]) * 0.5 - 0.12, 1.5)
	var region := NavigationRegion3D.new()
	region.name = "RoomNav"
	var nmesh := NavigationMesh.new()
	nmesh.agent_radius = 0.28
	nmesh.agent_height = 1.6
	nmesh.agent_max_climb = 0.25
	var verts := PackedVector3Array([
		Vector3(-half_w, 0.0, -half_d),
		Vector3(half_w, 0.0, -half_d),
		Vector3(half_w, 0.0, half_d),
		Vector3(-half_w, 0.0, half_d),
	])
	nmesh.vertices = verts
	nmesh.add_polygon(PackedInt32Array([0, 1, 2, 3]))
	# Doorway approach pads: small rectangles from door pos toward room centre
	var doors: Array = room.get("doors", [])
	var base := 4
	for door in doors:
		if not (door is Dictionary):
			continue
		var dp: Array = door.get("pos", [0, 0, 0])
		if dp.size() < 3:
			continue
		var dx := float(dp[0])
		var dz := float(dp[2])
		# Pad 0.9m toward centre, 1.2m wide
		var to_c := Vector2(-dx, -dz)
		if to_c.length() < 0.1:
			to_c = Vector2(0, 1)
		to_c = to_c.normalized()
		var perp := Vector2(-to_c.y, to_c.x)
		var c0 := Vector3(dx, 0, dz) + Vector3(perp.x, 0, perp.y) * 0.6
		var c1 := Vector3(dx, 0, dz) - Vector3(perp.x, 0, perp.y) * 0.6
		var c2 := c1 + Vector3(to_c.x, 0, to_c.y) * 1.1
		var c3 := c0 + Vector3(to_c.x, 0, to_c.y) * 1.1
		var i0 := verts.size()
		verts.append(c0)
		verts.append(c1)
		verts.append(c2)
		verts.append(c3)
		nmesh.vertices = verts
		nmesh.add_polygon(PackedInt32Array([i0, i0 + 1, i0 + 2, i0 + 3]))
		base += 4
	region.navigation_mesh = nmesh
	add_child(region)

func _bind_doors() -> void:
	_door_areas.clear()
	for child in room_builder.get_children():
		if child is Area3D and child.name.begins_with("Door_"):
			_door_areas.append(child)
			# Fresh areas each room load — always connect.
			child.body_entered.connect(_on_door_entered.bind(child))
			child.body_exited.connect(_on_door_exited.bind(child))

func _on_door_entered(body: Node3D, area: Area3D) -> void:
	if body == player:
		_near_door = area.get_meta("door")
		_update_prompt()

func _on_door_exited(body: Node3D, area: Area3D) -> void:
	if body == player and _near_door == area.get_meta("door"):
		_near_door = {}
		_update_prompt()

func _process(_delta: float) -> void:
	if dialogue.visible:
		return
	_scan_npc_proximity()
	_scan_door_proximity()
	_update_prompt()

func _scan_npc_proximity() -> void:
	_near_npc = null
	var best := INF
	for npc in npc_root.get_children():
		if not npc.has_method("distance_to_player"):
			continue
		var dist: float = npc.distance_to_player(player.global_position)
		if dist < 2.2 and dist < best:
			best = dist
			_near_npc = npc

func _scan_door_proximity() -> void:
	## Distance fallback: works even if Area3D is slightly misaligned with collision.
	## Prefer nearest doorway whose horizontal distance is under DOOR_PROXIMITY.
	var best := INF
	var found: Dictionary = {}
	var ppos := player.global_position
	for door in _current_doors:
		var dp: Array = door.get("pos", [0, 0, 0])
		var dpos := Vector3(float(dp[0]), ppos.y, float(dp[2]))
		var dist := Vector2(ppos.x - dpos.x, ppos.z - dpos.z).length()
		if dist < DOOR_PROXIMITY and dist < best:
			best = dist
			found = door
	if not found.is_empty():
		_near_door = found
	elif not _near_door.is_empty():
		# Clear only if we also left any Area3D (area path may still hold it)
		var still_in_area := false
		for area in _door_areas:
			if area.get_overlapping_bodies().has(player):
				still_in_area = true
				_near_door = area.get_meta("door")
				break
		if not still_in_area:
			_near_door = {}

func _update_prompt() -> void:
	if dialogue.visible:
		interact_prompt.visible = false
		return
	if _near_npc:
		interact_prompt.visible = true
		var data: Dictionary = _near_npc.get_meta("npc")
		interact_prompt.text = "[E] Talk to %s" % data.get("name", "someone")
	elif not _near_door.is_empty():
		interact_prompt.visible = true
		# Loop 153/167: closed leaf teleports — clear destination (not "Open" closet)
		var dest := str(_near_door.get("label", "next room"))
		interact_prompt.text = "[E] Enter · %s" % dest
	else:
		interact_prompt.visible = false

func _talk_to_npc(npc: Node3D) -> void:
	var data: Dictionary = npc.get_meta("npc")
	player.set_movement_enabled(false)
	player.release_mouse()
	if npc.has_method("set_talking"):
		npc.set_talking(true)
	var tex: Texture2D = load(data.get("portrait", ""))
	dialogue.open(str(data.get("id", "")), str(data.get("name", "")), tex, str(data.get("intro", "")))

func _go_through_door(door: Dictionary) -> void:
	## Closed leaf + E → direct room load + teleport. Never walk into portal void.
	if _door_busy:
		return
	_door_busy = true
	player.set_movement_enabled(false)
	var spawn: Array = door.get("spawn", [0, 0, 0])
	var sx := float(spawn[0]) if spawn.size() > 0 else 0.0
	var sz := float(spawn[2]) if spawn.size() > 2 else 0.0
	# Nudge spawn toward room centre so feet never land on threshold/void.
	var nudged := _nudge_spawn_inward(sx, sz, 0.65)
	# Vector2 stores XZ as (x, y) — use nudged.y for world Z (loop 125 parse fix)
	# Always face *into* the room from the landed spawn (loop 76).
	# Door dict spawn_yaw was often facing the leaf (looked like closet re-entry).
	var yaw: float = _facing_into_room_yaw([nudged.x, 0.0, nudged.y])
	var target_id := str(door["target"])
	await _load_room(target_id, [nudged.x, 0.0, nudged.y], yaw)
	# Hard floor re-snap after rebuild (CharacterBody can settle mid-frame)
	if player:
		player.teleport_to(Vector3(nudged.x, 0.0, nudged.y), yaw)
		player.set_movement_enabled(true)
	_door_busy = false
	_near_door = {}
	_update_prompt()


func _nudge_spawn_inward(sx: float, sz: float, amount: float) -> Vector2:
	## Pull spawn slightly toward origin on XZ (room centre).
	var v := Vector2(sx, sz)
	if v.length() < 0.2:
		return Vector2(0.0, 0.0)
	var inward := -v.normalized() * amount
	return v + inward


func _facing_into_room_yaw(spawn: Array) -> float:
	## Yaw that looks from the spawn point toward the room centre (0,0).
	var sx := float(spawn[0]) if spawn.size() > 0 else 0.0
	var sz := float(spawn[2]) if spawn.size() > 2 else 0.0
	# Direction into room = -spawn on XZ. Map to head yaw (see fps_player teleport_to).
	if absf(sx) < 0.05 and absf(sz) < 0.05:
		return 0.0
	# θ = atan2(sx, sz): spawn south → 0° (look north); spawn west → -90° (look east).
	return rad_to_deg(atan2(sx, sz))

func _on_dialogue_closed() -> void:
	if _near_npc and _near_npc.has_method("set_talking"):
		_near_npc.set_talking(false)
	# Also clear talking on any NPC that might still be flagged
	for npc in npc_root.get_children():
		if npc.has_method("set_talking"):
			npc.set_talking(false)
	player.set_movement_enabled(true)
	player.capture_mouse()
	_update_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if dialogue.visible or _door_busy:
		return
	if not event.is_action_pressed("interact"):
		return
	if _near_npc:
		_talk_to_npc(_near_npc)
	elif not _near_door.is_empty():
		_go_through_door(_near_door)