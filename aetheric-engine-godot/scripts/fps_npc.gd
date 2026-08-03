extends Node3D

## In-world NPC: camera-facing full-figure sprite billboard + collision for E-talk.
## Sprites: res://assets/characters/sprites/sprite_<id>.png (hard alpha cutout)
## Optional walk cycle: sprite_<id>_walk_0.png … walk_3.png (distance-driven while patrolling)
## Phase 1 life (all NPCs): breath/sway, idle fidget timer, attend-player when near.
## All NPCs will walk eventually; Bell is the walk-art test case.

const SPRITE_DIR := "res://assets/characters/sprites/"
## Metres of travel per full walk cycle (tuned for clear step cadence, less glide)
const WALK_CYCLE_METRES := 0.55
const WALK_FRAME_COUNT := 4

## --- Life / attention (Oblivion-style presentation layer on billboards) ---
const BREATH_AMPLITUDE_IDLE := 0.012   # metres of Y bob at rest
const BREATH_AMPLITUDE_WALK := 0.018
const BREATH_HZ_IDLE := 0.35
const BREATH_HZ_WALK := 0.9
const BREATH_SCALE_IDLE := 0.008       # fractional scale pulse
const ATTEND_RADIUS_M := 3.5
const ATTEND_YAW_SPEED := 3.2          # rad/s when facing player (billboard off)
const FIDGET_MIN_SEC := 2.8
const FIDGET_MAX_SEC := 6.5
const DWELL_JITTER_FRAC := 0.22        # ± fraction of dwell_sec
const GLANCE_YAW_DEG := 18.0           # small free-look yaw while dwelling (billboard off briefly)

var npc_data: Dictionary = {}
var _points: Array[Vector3] = []
var _index := 0
var _dwell_left := 0.0
var _speed := 0.9
var _sprite: Sprite3D = null

## Walk cycle state
var _char_mesh: MeshInstance3D = null
var _char_mat: StandardMaterial3D = null
var _idle_tex: Texture2D = null
var _idle_texs: Array = []  # optional multi-frame idle (Phase 2)
var _walk_texs: Array = []  # Texture2D, empty if no cycle
var _walk_dist := 0.0
var _walk_frame := -1
var _idle_frame := 0
var _world_h := 1.7
var _foot_shadow: MeshInstance3D = null
var _was_dwelling := true
var _mesh_base_y := 0.0
var _mesh_base_scale := Vector3.ONE

## Life state
var _life_t := 0.0
var _fidget_left := 0.0
var _glance_yaw := 0.0          # radians target offset when not attending
var _attending := false
var _base_dwell := 6.0
var _player: Node3D = null
var _player_search_cd := 0.0

@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var body: StaticBody3D = $Body
@onready var label: Label3D = $Label3D

func setup(data: Dictionary) -> void:
	npc_data = data
	var patrol: Array = data.get("patrol", [])
	_points.clear()
	for p in patrol:
		_points.append(Vector3(p[0], 0.0, p[2]))
	if _points.is_empty():
		_points.append(Vector3.ZERO)
	global_position = _points[0]
	_base_dwell = float(data.get("dwell_sec", 6.0))
	_dwell_left = _dwell_with_jitter(_base_dwell)
	_speed = float(data.get("speed", 0.9))
	_life_t = randf() * TAU
	_fidget_left = _next_fidget_interval()

	var h: float = data.get("height", 1.7)
	_world_h = h
	var npc_id := str(data.get("id", "")).to_lower()

	if body_mesh:
		body_mesh.visible = false

	_setup_sprite(npc_id, h, data)
	_setup_foot_shadow()

	label.text = data.get("name", "")
	label.font_size = 28
	label.position = Vector3(0, h + 0.22, 0)
	label.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	label.modulate = Color(0.95, 0.88, 0.68, 1.0)
	label.outline_size = 8

	var col := body.get_node("CollisionShape3D") as CollisionShape3D
	if col:
		var shape := col.shape as CapsuleShape3D
		if shape:
			shape.height = h * 0.85
			shape.radius = 0.28
		body.position = Vector3(0, h * 0.5, 0)

	set_meta("npc", data)
	_set_idle()


## Pure: which walk frame for distance traveled (0 .. n_frames-1).
static func select_walk_frame(distance_m: float, cycle_m: float, n_frames: int) -> int:
	if n_frames <= 0:
		return 0
	var cm: float = cycle_m if cycle_m > 0.0001 else 1.0
	var t: float = fposmod(distance_m / cm, 1.0)
	return int(t * float(n_frames)) % n_frames


## Pure: while dwelling at a waypoint, show idle (not a walk frame).
static func should_use_idle(dwelling: bool) -> bool:
	return dwelling


## Pure: player within attend radius?
static func should_attend_player(dist_m: float, radius_m: float) -> bool:
	return dist_m <= radius_m


## Pure: breath vertical offset (metres). phase in radians.
static func breath_offset_y(phase: float, amplitude: float) -> float:
	return sin(phase) * amplitude


## Pure: breath scale factor (1 + small pulse).
static func breath_scale_factor(phase: float, amount: float) -> float:
	return 1.0 + sin(phase) * amount


## Pure: dwell with symmetric jitter in [base*(1-j), base*(1+j)], min 0.5s.
static func dwell_with_jitter(base_sec: float, jitter_frac: float, rand01: float) -> float:
	var b: float = maxf(base_sec, 0.5)
	var j: float = clampf(jitter_frac, 0.0, 0.9)
	var r: float = clampf(rand01, 0.0, 1.0)
	var mul: float = (1.0 - j) + r * (2.0 * j)
	return maxf(0.5, b * mul)


## Pure: next fidget interval from u01 in [min,max].
static func fidget_interval(min_sec: float, max_sec: float, rand01: float) -> float:
	var lo: float = minf(min_sec, max_sec)
	var hi: float = maxf(min_sec, max_sec)
	return lo + clampf(rand01, 0.0, 1.0) * (hi - lo)


static func sprite_path_for(npc_id: String) -> String:
	var id := npc_id.to_lower().strip_edges()
	if id.is_empty():
		return ""
	return SPRITE_DIR + "sprite_%s.png" % id


static func walk_frame_path(npc_id: String, frame: int) -> String:
	var id := npc_id.to_lower().strip_edges()
	return SPRITE_DIR + "sprite_%s_walk_%d.png" % [id, frame]


static func idle_frame_path(npc_id: String, frame: int) -> String:
	var id := npc_id.to_lower().strip_edges()
	return SPRITE_DIR + "sprite_%s_idle_%d.png" % [id, frame]


## Load texture without mipmaps (avoids alpha-scissor holes in dark cloth).
static func _load_texture(tex_path: String) -> Texture2D:
	if tex_path == "":
		return null
	var abs_path := ProjectSettings.globalize_path(tex_path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		if img.load(abs_path) == OK:
			# Do not generate mipmaps — dark coat/trousers + scissor + mips = fuzzy holes.
			return ImageTexture.create_from_image(img)
	if ResourceLoader.exists(tex_path):
		var res = load(tex_path)
		if res is Texture2D:
			return res
	return null


func _make_char_material(tex: Texture2D) -> StandardMaterial3D:
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = tex
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	mat.alpha_scissor_threshold = 0.5
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	# No mipmaps: LINEAR only (not LINEAR_WITH_MIPMAPS)
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR
	mat.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y
	mat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_OPAQUE_ONLY
	return mat


func _setup_sprite(npc_id: String, height: float, data: Dictionary) -> void:
	var path := str(data.get("sprite", sprite_path_for(npc_id)))
	var tex: Texture2D = _load_texture(path)
	_idle_tex = tex
	_idle_texs.clear()
	_walk_texs.clear()

	# Optional multi-frame idle (Phase 2): sprite_<id>_idle_0..n
	var idle_loaded: Array = []
	for fi in 4:
		var it := _load_texture(idle_frame_path(npc_id, fi))
		if it == null:
			break
		idle_loaded.append(it)
	if idle_loaded.size() >= 2:
		_idle_texs = idle_loaded
		if _idle_tex == null:
			_idle_tex = _idle_texs[0]

	var walk_ok := true
	var loaded_walk: Array = []
	for fi in WALK_FRAME_COUNT:
		var wt := _load_texture(walk_frame_path(npc_id, fi))
		if wt == null:
			walk_ok = false
			break
		loaded_walk.append(wt)
	if walk_ok:
		_walk_texs = loaded_walk

	if tex == null and _walk_texs.is_empty() and _idle_texs.is_empty():
		if body_mesh:
			body_mesh.visible = true
			var capsule := CapsuleMesh.new()
			capsule.height = height * 0.85
			capsule.radius = 0.28
			body_mesh.mesh = capsule
			var mat := StandardMaterial3D.new()
			mat.albedo_color = Color(0.35, 0.28, 0.22)
			mat.roughness = 0.9
			body_mesh.material_override = mat
			body_mesh.position = Vector3(0, height * 0.5, 0)
		return

	if tex == null:
		if not _idle_texs.is_empty():
			tex = _idle_texs[0]
		elif not _walk_texs.is_empty():
			tex = _walk_texs[0]
		_idle_tex = tex

	var tex_h: float = float(tex.get_height())
	var tex_w: float = float(tex.get_width())
	if tex_h < 1.0:
		tex_h = 1024.0
	if tex_w < 1.0:
		tex_w = 512.0
	# Prefer walk-frame pixel size when present so all frames share one quad aspect
	if not _walk_texs.is_empty():
		tex_w = float(_walk_texs[0].get_width())
		tex_h = float(_walk_texs[0].get_height())
	var aspect: float = tex_w / tex_h
	var world_h: float = height
	var world_w: float = height * aspect

	var quad := QuadMesh.new()
	quad.size = Vector2(world_w, world_h)
	var mi := MeshInstance3D.new()
	mi.name = "CharacterSprite"
	mi.mesh = quad
	var mat2 := _make_char_material(tex)
	mi.material_override = mat2
	mi.position = Vector3(0, world_h * 0.5 + 0.01, 0)
	add_child(mi)
	_char_mesh = mi
	_char_mat = mat2
	_mesh_base_y = mi.position.y
	_mesh_base_scale = mi.scale
	_sprite = null


func _setup_foot_shadow() -> void:
	var mi := MeshInstance3D.new()
	mi.name = "FootShadow"
	var disc := CylinderMesh.new()
	disc.top_radius = 0.22
	disc.bottom_radius = 0.22
	disc.height = 0.012
	disc.radial_segments = 16
	mi.mesh = disc
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.05, 0.04, 0.03, 0.45)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.no_depth_test = false
	mi.material_override = mat
	mi.position = Vector3(0, 0.008, 0)
	add_child(mi)
	_foot_shadow = mi


func _set_sprite_tex(tex: Texture2D) -> void:
	if _char_mat == null or tex == null:
		return
	_char_mat.albedo_texture = tex


func _set_walk_frame(frame: int) -> void:
	if _walk_texs.is_empty():
		return
	var f: int = posmod(frame, _walk_texs.size())
	if f == _walk_frame and not _was_dwelling:
		return
	_walk_frame = f
	_set_sprite_tex(_walk_texs[_walk_frame])
	_was_dwelling = false


func _set_idle() -> void:
	_walk_dist = 0.0
	_walk_frame = -1
	_was_dwelling = true
	if not _idle_texs.is_empty():
		_idle_frame = posmod(_idle_frame, _idle_texs.size())
		_set_sprite_tex(_idle_texs[_idle_frame])
	elif _idle_tex:
		_set_sprite_tex(_idle_tex)
	elif not _walk_texs.is_empty():
		_set_sprite_tex(_walk_texs[0])


func _dwell_with_jitter(base: float) -> float:
	return dwell_with_jitter(base, DWELL_JITTER_FRAC, randf())


func _next_fidget_interval() -> float:
	return fidget_interval(FIDGET_MIN_SEC, FIDGET_MAX_SEC, randf())


func _resolve_player() -> Node3D:
	if _player != null and is_instance_valid(_player):
		return _player
	_player_search_cd -= get_physics_process_delta_time()
	if _player_search_cd > 0.0:
		return null
	_player_search_cd = 0.75
	var scene := get_tree().current_scene if get_tree() else null
	if scene:
		var p = scene.get_node_or_null("Player")
		if p is Node3D:
			_player = p
			return _player
	var n: Node = get_parent()
	while n:
		var cand = n.get_node_or_null("Player")
		if cand is Node3D:
			_player = cand
			return _player
		n = n.get_parent()
	return null


func _physics_process(delta: float) -> void:
	_life_t += delta

	# Always run presentation life (even single-point / no patrol).
	var moving := false
	if _points.size() >= 2:
		moving = _process_patrol(delta)

	_process_attention(delta, moving)
	_process_fidget(delta, moving)
	_process_breath(delta, moving)


func _process_patrol(delta: float) -> bool:
	## Returns true while translating between waypoints.
	if _dwell_left > 0.0:
		_dwell_left -= delta
		if not _was_dwelling or _walk_frame != -1:
			_set_idle()
		return false
	var target := _points[_index]
	var flat := Vector2(global_position.x - target.x, global_position.z - target.z)
	if flat.length() < 0.2:
		_index = (_index + 1) % _points.size()
		_dwell_left = _dwell_with_jitter(_base_dwell)
		_set_idle()
		return false
	var dir := Vector3(target.x - global_position.x, 0.0, target.z - global_position.z).normalized()
	var step := _speed * delta
	global_position += dir * step

	if not _walk_texs.is_empty():
		_walk_dist += step
		var frame := select_walk_frame(_walk_dist, WALK_CYCLE_METRES, _walk_texs.size())
		_set_walk_frame(frame)
	return true


func _process_attention(delta: float, moving: bool) -> void:
	var player := _resolve_player()
	var want_attend := false
	var to_player := Vector3.ZERO
	if player:
		var dist := distance_to_player(player.global_position)
		want_attend = should_attend_player(dist, ATTEND_RADIUS_M)
		to_player = player.global_position - global_position
		to_player.y = 0.0
	_attending = want_attend and to_player.length_squared() > 0.0001

	if _char_mat == null or _char_mesh == null:
		return

	# FIXED_Y always faces camera — true face-player needs billboard off while attending.
	# Plan default: disable billboard when attending (or free-glancing); restore FIXED_Y otherwise.
	if _attending and not moving:
		_char_mat.billboard_mode = BaseMaterial3D.BILLBOARD_DISABLED
		var target_yaw := atan2(to_player.x, to_player.z)
		var cur := _char_mesh.rotation.y
		_char_mesh.rotation.y = lerp_angle(cur, target_yaw, clampf(ATTEND_YAW_SPEED * delta, 0.0, 1.0))
	elif not moving and absf(_glance_yaw) > 0.001:
		_char_mat.billboard_mode = BaseMaterial3D.BILLBOARD_DISABLED
		var cur2 := _char_mesh.rotation.y
		_char_mesh.rotation.y = lerp_angle(cur2, _glance_yaw, clampf(2.0 * delta, 0.0, 1.0))
	else:
		_char_mat.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y
		_char_mesh.rotation.y = 0.0


func _process_fidget(delta: float, moving: bool) -> void:
	if moving:
		return
	_fidget_left -= delta
	if _fidget_left > 0.0:
		return
	_fidget_left = _next_fidget_interval()

	# Cycle multi-frame idle if present
	if _idle_texs.size() >= 2:
		_idle_frame = (_idle_frame + 1) % _idle_texs.size()
		if _was_dwelling:
			_set_sprite_tex(_idle_texs[_idle_frame])

	# Random glance (small yaw) when not locked on player
	if not _attending:
		var deg := (randf() * 2.0 - 1.0) * GLANCE_YAW_DEG
		_glance_yaw = deg_to_rad(deg)
	else:
		_glance_yaw = 0.0


func _process_breath(_delta: float, moving: bool) -> void:
	if _char_mesh == null:
		return
	var amp := BREATH_AMPLITUDE_WALK if moving else BREATH_AMPLITUDE_IDLE
	var hz := BREATH_HZ_WALK if moving else BREATH_HZ_IDLE
	var scale_amt := BREATH_SCALE_IDLE * (1.35 if moving else 1.0)
	if _attending:
		amp *= 1.15
		hz *= 1.05
	var phase := _life_t * TAU * hz
	var dy := breath_offset_y(phase, amp)
	var sc := breath_scale_factor(phase, scale_amt)
	_char_mesh.position.y = _mesh_base_y + dy
	_char_mesh.scale = _mesh_base_scale * sc
	if _foot_shadow:
		var shadow_a := 0.40 + 0.08 * sin(phase)
		var sm := _foot_shadow.material_override as StandardMaterial3D
		if sm:
			var c := sm.albedo_color
			c.a = shadow_a
			sm.albedo_color = c


func distance_to_player(player_pos: Vector3) -> float:
	return Vector2(global_position.x - player_pos.x, global_position.z - player_pos.z).length()
