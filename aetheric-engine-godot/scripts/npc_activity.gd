extends RefCounted
class_name NpcActivity

## Living-house activity system: six states, room slots, claim/release, soft preferences.
## Pure helpers for headless tests; runtime registry is static on this class.

const STATE_IDLE := "Idle"
const STATE_WALK := "Walk"
const STATE_SIT := "Sit"
const STATE_READ := "Read"
const STATE_WORK_MACHINE := "WorkMachine"
const STATE_TALK := "Talk"

const ALL_STATES := [
	STATE_IDLE, STATE_WALK, STATE_SIT, STATE_READ, STATE_WORK_MACHINE, STATE_TALK
]

const COOLDOWN_MIN_SEC := 45.0
const COOLDOWN_MAX_SEC := 90.0

## Soft preferences: preferred activity states per NPC id (lowercase).
const PREFERENCES := {
	"selina": {"states": [STATE_READ, STATE_IDLE, STATE_WORK_MACHINE], "rooms": ["drawing_room", "gallery"]},
	"bell": {"states": [STATE_WORK_MACHINE, STATE_READ], "rooms": ["gallery", "workshop"]},
	"amara": {"states": [STATE_WORK_MACHINE, STATE_READ], "rooms": ["gallery", "conservatory"]},
	"rooke": {"states": [STATE_WORK_MACHINE, STATE_IDLE], "rooms": ["gallery", "workshop"]},
	"clara": {"states": [STATE_IDLE, STATE_SIT], "rooms": ["kitchen", "entrance_hall", "drawing_room"]},
	"elspeth": {"states": [STATE_READ, STATE_SIT, STATE_IDLE], "rooms": ["morning_room", "drawing_room", "entrance_hall"]},
}

## Fixed slot definitions per room (positions near existing furniture — furniture not moved).
## Each: id, pos [x,y,z], yaw_deg (facing), allowed [states], priority (higher = preferred)
const ROOM_SLOTS := {
	"gallery": [
		{"id": "machine_main", "pos": [0.0, 0.0, -2.4], "yaw": 180.0,
			"allowed": [STATE_WORK_MACHINE], "priority": 10},
		{"id": "machine_side", "pos": [4.2, 0.0, -3.5], "yaw": 160.0,
			"allowed": [STATE_WORK_MACHINE, STATE_IDLE], "priority": 6},
		{"id": "bench_read", "pos": [-5.0, 0.0, -0.8], "yaw": 90.0,
			"allowed": [STATE_READ, STATE_SIT], "priority": 7},
	],
	"drawing_room": [
		{"id": "sofa_sit", "pos": [0.0, 0.0, -3.2], "yaw": 0.0,
			"allowed": [STATE_SIT], "priority": 8},
		{"id": "armchair_read", "pos": [-2.7, 0.0, 2.1], "yaw": 40.0,
			"allowed": [STATE_READ], "priority": 7},
		{"id": "desk_write", "pos": [2.5, 0.0, 0.8], "yaw": 90.0,
			"allowed": [STATE_READ], "priority": 9},
	],
	"entrance_hall": [
		{"id": "hall_stand", "pos": [0.0, 0.0, 0.0], "yaw": 0.0,
			"allowed": [STATE_IDLE], "priority": 5},
		{"id": "hall_table", "pos": [2.5, 0.0, -1.5], "yaw": -90.0,
			"allowed": [STATE_IDLE, STATE_READ], "priority": 6},
	],
	"kitchen": [
		{"id": "range_work", "pos": [0.0, 0.0, 2.6], "yaw": 180.0,
			"allowed": [STATE_IDLE], "priority": 7},
		{"id": "table_sit", "pos": [-1.5, 0.0, 0.0], "yaw": 90.0,
			"allowed": [STATE_SIT], "priority": 6},
	],
	"workshop": [
		{"id": "bench_work", "pos": [-2.0, 0.0, -2.0], "yaw": 0.0,
			"allowed": [STATE_IDLE, STATE_WORK_MACHINE], "priority": 8},
		{"id": "stool_sit", "pos": [-1.2, 0.0, -1.4], "yaw": 25.0,
			"allowed": [STATE_SIT], "priority": 5},
	],
	"conservatory": [
		{"id": "conserv_sit", "pos": [1.0, 0.0, -1.0], "yaw": 0.0,
			"allowed": [STATE_SIT, STATE_IDLE], "priority": 5},
		{"id": "conserv_read", "pos": [-1.2, 0.0, 0.5], "yaw": 90.0,
			"allowed": [STATE_READ, STATE_IDLE], "priority": 6},
	],
	"morning_room": [
		{"id": "morning_sit", "pos": [-1.5, 0.0, -0.8], "yaw": 55.0,
			"allowed": [STATE_SIT, STATE_IDLE], "priority": 5},
		{"id": "morning_read", "pos": [1.8, 0.0, -1.6], "yaw": -90.0,
			"allowed": [STATE_READ, STATE_IDLE], "priority": 6},
	],
}

## Runtime registry: room_id -> slot_id -> {def..., claimant: String}
static var _registry: Dictionary = {}


static func is_valid_state(name: String) -> bool:
	return name in ALL_STATES


static func activity_states() -> Array:
	## Non-movement activity states (not Walk/Talk).
	return [STATE_IDLE, STATE_SIT, STATE_READ, STATE_WORK_MACHINE]


static func clear_registry() -> void:
	_registry.clear()


static func register_room_slots(room_id: String, slots: Array = []) -> void:
	## Register fixed slots for a room. If slots empty, use ROOM_SLOTS defaults.
	var rid := room_id
	var defs: Array = slots
	if defs.is_empty():
		defs = ROOM_SLOTS.get(rid, [])
	var room_map: Dictionary = {}
	for d in defs:
		if not (d is Dictionary):
			continue
		var sid := str(d.get("id", ""))
		if sid == "":
			continue
		var entry: Dictionary = d.duplicate(true)
		entry["claimant"] = ""
		entry["room_id"] = rid
		room_map[sid] = entry
	_registry[rid] = room_map


static func slot_ids_for_room(room_id: String) -> Array:
	var room_map: Dictionary = _registry.get(room_id, {})
	return room_map.keys()


static func get_slot(room_id: String, slot_id: String) -> Dictionary:
	var room_map: Dictionary = _registry.get(room_id, {})
	return room_map.get(slot_id, {})


static func claim_slot(room_id: String, slot_id: String, npc_id: String) -> bool:
	## Exclusive claim. Returns false if missing or already claimed by another.
	var room_map: Dictionary = _registry.get(room_id, {})
	if not room_map.has(slot_id):
		return false
	var entry: Dictionary = room_map[slot_id]
	var cur := str(entry.get("claimant", ""))
	if cur != "" and cur != npc_id:
		return false
	entry["claimant"] = npc_id
	room_map[slot_id] = entry
	_registry[room_id] = room_map
	return true


static func release_slot(room_id: String, slot_id: String, npc_id: String = "") -> bool:
	var room_map: Dictionary = _registry.get(room_id, {})
	if not room_map.has(slot_id):
		return false
	var entry: Dictionary = room_map[slot_id]
	var cur := str(entry.get("claimant", ""))
	if npc_id != "" and cur != "" and cur != npc_id:
		return false
	entry["claimant"] = ""
	room_map[slot_id] = entry
	_registry[room_id] = room_map
	return true


static func is_slot_free(room_id: String, slot_id: String) -> bool:
	var entry := get_slot(room_id, slot_id)
	if entry.is_empty():
		return false
	return str(entry.get("claimant", "")) == ""


static func free_slots(room_id: String) -> Array:
	var out: Array = []
	var room_map: Dictionary = _registry.get(room_id, {})
	for sid in room_map.keys():
		var entry: Dictionary = room_map[sid]
		if str(entry.get("claimant", "")) == "":
			out.append(entry)
	return out


static func pick_activity_for_slot(slot: Dictionary, npc_id: String, rand01: float = 0.5) -> String:
	## Choose an allowed activity state for a slot, soft-biased by NPC preferences.
	var allowed: Array = slot.get("allowed", [STATE_IDLE])
	if allowed.is_empty():
		return STATE_IDLE
	var prefs: Array = []
	var p: Dictionary = PREFERENCES.get(npc_id.to_lower(), {})
	if p.has("states"):
		prefs = p["states"]
	var weighted: Array = []
	for a in allowed:
		var st := str(a)
		if not is_valid_state(st) or st == STATE_WALK or st == STATE_TALK:
			continue
		var w := 1.0 + float(slot.get("priority", 1)) * 0.1
		if st in prefs:
			w += 3.0
		weighted.append({"state": st, "w": w})
	if weighted.is_empty():
		return str(allowed[0])
	var total := 0.0
	for e in weighted:
		total += float(e["w"])
	var r := clampf(rand01, 0.0, 0.999999) * total
	var acc := 0.0
	for e in weighted:
		acc += float(e["w"])
		if r <= acc:
			return str(e["state"])
	return str(weighted[weighted.size() - 1]["state"])


static func pick_free_slot(room_id: String, npc_id: String, rand01: float = 0.5) -> Dictionary:
	## Preference-weighted free slot among registered free slots. Empty dict if none.
	var free: Array = free_slots(room_id)
	if free.is_empty():
		return {}
	var prefs: Dictionary = PREFERENCES.get(npc_id.to_lower(), {})
	var pref_states: Array = prefs.get("states", [])
	var pref_rooms: Array = prefs.get("rooms", [])
	var weighted: Array = []
	for s in free:
		var entry: Dictionary = s
		var w := 1.0 + float(entry.get("priority", 1))
		# Room preference soft bias
		if room_id in pref_rooms:
			w += 2.0
		# Slot allows a preferred state
		var allowed: Array = entry.get("allowed", [])
		for st in pref_states:
			if st in allowed:
				w += 2.5
				break
		weighted.append({"slot": entry, "w": w})
	var total := 0.0
	for e in weighted:
		total += float(e["w"])
	var r := clampf(rand01, 0.0, 0.999999) * total
	var acc := 0.0
	for e in weighted:
		acc += float(e["w"])
		if r <= acc:
			return e["slot"]
	return weighted[weighted.size() - 1]["slot"]


static func cooldown_duration(rand01: float) -> float:
	var t := clampf(rand01, 0.0, 1.0)
	return COOLDOWN_MIN_SEC + t * (COOLDOWN_MAX_SEC - COOLDOWN_MIN_SEC)


static func cooldown_elapsed(elapsed_sec: float, required_sec: float) -> bool:
	return elapsed_sec >= required_sec


static func slot_position(slot: Dictionary) -> Vector3:
	var p: Array = slot.get("pos", [0, 0, 0])
	if p.size() < 3:
		return Vector3.ZERO
	return Vector3(float(p[0]), 0.0, float(p[2]))


static func slot_yaw_rad(slot: Dictionary) -> float:
	return deg_to_rad(float(slot.get("yaw", 0.0)))


static func pose_clip_for_state(state_name: String) -> String:
	## Map activity state → preferred AnimationPlayer / billboard pose name.
	match state_name:
		STATE_WALK:
			return "walk"
		STATE_SIT:
			return "sit"
		STATE_READ:
			return "read"
		STATE_WORK_MACHINE:
			return "work"
		STATE_TALK:
			return "talk"
		_:
			return "idle"


static func required_slot_ids() -> Dictionary:
	## Spec ids for structure tests (room_id → Array of slot ids).
	var out := {}
	for rid in ROOM_SLOTS.keys():
		var ids: Array = []
		for s in ROOM_SLOTS[rid]:
			ids.append(str(s["id"]))
		out[rid] = ids
	return out
