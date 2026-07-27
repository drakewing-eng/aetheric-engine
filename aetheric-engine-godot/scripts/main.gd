extends Control

@onready var room_bg: TextureRect = %RoomBackground
@onready var hud: Label = %HudLabel
@onready var bridge_status: Label = %BridgeStatus
@onready var interact_prompt: Label = %InteractPrompt
@onready var dialogue: Control = %DialoguePanel
@onready var bridge: BridgeClient = %BridgeClient
@onready var player: Sprite2D = %Player

var _current_room_id := "entrance_hall"
var _near_npc: Dictionary = {}
var _near_door: Dictionary = {}

func _ready() -> void:
	dialogue.closed.connect(_on_dialogue_closed)
	bridge.health_checked.connect(_on_health)
	bridge.check_health()
	_load_room("entrance_hall")

func _on_health(ok: bool, _detail: String) -> void:
	if ok:
		bridge_status.text = "Bridge: online (Engram + Ollama)"
		bridge_status.modulate = Color("#8cd8a4")
	else:
		bridge_status.text = "Bridge: offline — run ./run-game.sh first"
		bridge_status.modulate = Color("#ff8888")

func _load_room(room_id: String, spawn_override: Variant = null) -> void:
	_current_room_id = room_id
	var room := Rooms.get_room(room_id)
	var tex: Texture2D = load(room["texture"])
	if tex == null:
		push_warning("Missing room art: %s" % room["texture"])
	room_bg.texture = tex
	hud.text = "Richmond House — %s · Summer 1856\n%s" % [room["title"], room["subtitle"]]

	var wb: Array = room.get("walk_bounds", [120, 400, 1680, 900])
	player.set_bounds(Rect2(wb[0], wb[1], wb[2], wb[3]))

	var spawn: Array = spawn_override if spawn_override != null else room.get("spawn", [960, 700])
	player.set_spawn(Vector2(spawn[0], spawn[1]))

	_near_npc = {}
	_near_door = {}
	_update_prompt()

func _process(_delta: float) -> void:
	if dialogue.visible:
		interact_prompt.visible = false
		return
	_scan_proximity()
	_update_prompt()
	_apply_parallax()

func _scan_proximity() -> void:
	var room := Rooms.get_room(_current_room_id)
	var pos := player.position
	_near_npc = {}
	_near_door = {}

	var best_npc_dist := INF
	for npc in room.get("npcs", []):
		var dist := Rooms.distance_to_rect(pos, npc["rect"])
		var limit: float = npc.get("proximity", 140)
		if dist <= limit and dist < best_npc_dist:
			best_npc_dist = dist
			_near_npc = npc

	for door in room.get("doors", []):
		if Rooms.point_in_rect(pos, door["rect"]):
			_near_door = door
			break

func _apply_parallax() -> void:
	var center := Vector2(960, 540)
	var offset := (player.position - center) * 0.03
	room_bg.position = -offset

func _update_prompt() -> void:
	if dialogue.visible:
		interact_prompt.visible = false
		return
	if not _near_npc.is_empty():
		interact_prompt.visible = true
		interact_prompt.text = "[E] Talk to %s" % _near_npc["name"]
	elif not _near_door.is_empty():
		interact_prompt.visible = true
		interact_prompt.text = "[E] Enter %s" % _near_door["label"]
	else:
		interact_prompt.visible = false

func _talk_to_npc(npc: Dictionary) -> void:
	interact_prompt.visible = false
	player.set_process(false)
	var tex: Texture2D = load(npc["portrait"])
	dialogue.open(str(npc["id"]), str(npc["name"]), tex, str(npc.get("intro", "")))

func _go_to_room(door: Dictionary) -> void:
	if dialogue.visible:
		return
	var target := str(door["target"])
	var spawn = door.get("spawn", null)
	_load_room(target, spawn)

func _on_dialogue_closed() -> void:
	player.set_process(true)
	_update_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if dialogue.visible:
		return
	if not event.is_action_pressed("interact"):
		return
	if not _near_npc.is_empty():
		_talk_to_npc(_near_npc)
	elif not _near_door.is_empty():
		_go_to_room(_near_door)