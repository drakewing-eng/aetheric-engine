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
const DOOR_PROXIMITY := 2.6  # slightly larger so E works with closed leaf + narrow gaps

var _current_room_id := "drawing_room"
var _current_doors: Array = []
var _near_npc: Node3D = null
var _near_door: Dictionary = {}
var _door_areas: Array[Area3D] = []

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

	_clear_npcs()
	_spawn_npcs(room.get("npcs", []))
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

func _spawn_npcs(npcs: Array) -> void:
	for data in npcs:
		var npc := NPC_SCENE.instantiate()
		npc_root.add_child(npc)
		npc.setup(data)

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
		interact_prompt.text = "[E] Open door to %s" % _near_door.get("label", "next room")
	else:
		interact_prompt.visible = false

func _talk_to_npc(npc: Node3D) -> void:
	var data: Dictionary = npc.get_meta("npc")
	player.set_movement_enabled(false)
	player.release_mouse()
	var tex: Texture2D = load(data.get("portrait", ""))
	dialogue.open(str(data.get("id", "")), str(data.get("name", "")), tex, str(data.get("intro", "")))

func _go_through_door(door: Dictionary) -> void:
	var spawn = door.get("spawn", [0, 0, 0])
	# Always face *into* the room (toward origin from spawn), not back at the doorway.
	# Godot yaw: 0 = look -Z, 90 = look -X, 180 = look +Z, -90 = look +X.
	var yaw := _facing_into_room_yaw(spawn)
	await _load_room(str(door["target"]), spawn, yaw)


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
	player.set_movement_enabled(true)
	player.capture_mouse()
	_update_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if dialogue.visible:
		return
	if not event.is_action_pressed("interact"):
		return
	if _near_npc:
		_talk_to_npc(_near_npc)
	elif not _near_door.is_empty():
		_go_through_door(_near_door)