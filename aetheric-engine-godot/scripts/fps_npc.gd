extends Node3D

## In-world NPC: camera-facing full-figure sprite billboard + collision for E-talk.
## Sprites: res://assets/characters/sprites/sprite_<id>.png (hard alpha cutout)
## Optional walk cycle: sprite_<id>_walk_0.png … walk_3.png (distance-driven while patrolling)

const SPRITE_DIR := "res://assets/characters/sprites/"
## Metres of travel per full walk cycle (tuned for clear step cadence, less glide)
const WALK_CYCLE_METRES := 0.55
const WALK_FRAME_COUNT := 4

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
var _walk_texs: Array = []  # Texture2D, empty if no cycle
var _walk_dist := 0.0
var _walk_frame := -1
var _world_h := 1.7
var _foot_shadow: MeshInstance3D = null
var _was_dwelling := true

@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var body: StaticBody3D = $Body
@onready var label: Label3D = $Label3D

func setup(data: Dictionary) -> void:
	npc_data = data
	var patrol: Array = data.get("patrol", [])
	for p in patrol:
		_points.append(Vector3(p[0], 0.0, p[2]))
	if _points.is_empty():
		_points.append(Vector3.ZERO)
	global_position = _points[0]
	_dwell_left = data.get("dwell_sec", 6.0)
	_speed = float(data.get("speed", 0.9))

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


static func sprite_path_for(npc_id: String) -> String:
	var id := npc_id.to_lower().strip_edges()
	if id.is_empty():
		return ""
	return SPRITE_DIR + "sprite_%s.png" % id


static func walk_frame_path(npc_id: String, frame: int) -> String:
	var id := npc_id.to_lower().strip_edges()
	return SPRITE_DIR + "sprite_%s_walk_%d.png" % [id, frame]


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
	_walk_texs.clear()

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

	if tex == null and _walk_texs.is_empty():
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
	var mat := _make_char_material(tex)
	mi.material_override = mat
	mi.position = Vector3(0, world_h * 0.5 + 0.01, 0)
	add_child(mi)
	_char_mesh = mi
	_char_mat = mat
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
	if _idle_tex:
		_set_sprite_tex(_idle_tex)
	elif not _walk_texs.is_empty():
		_set_sprite_tex(_walk_texs[0])


func _physics_process(delta: float) -> void:
	if _points.size() < 2:
		return
	if _dwell_left > 0.0:
		_dwell_left -= delta
		if not _was_dwelling or _walk_frame != -1:
			_set_idle()
		return
	var target := _points[_index]
	var flat := Vector2(global_position.x - target.x, global_position.z - target.z)
	if flat.length() < 0.2:
		_index = (_index + 1) % _points.size()
		_dwell_left = npc_data.get("dwell_sec", 6.0)
		_set_idle()
		return
	var dir := Vector3(target.x - global_position.x, 0.0, target.z - global_position.z).normalized()
	var step := _speed * delta
	global_position += dir * step

	if not _walk_texs.is_empty():
		_walk_dist += step
		var frame := select_walk_frame(_walk_dist, WALK_CYCLE_METRES, _walk_texs.size())
		_set_walk_frame(frame)


func distance_to_player(player_pos: Vector3) -> float:
	return Vector2(global_position.x - player_pos.x, global_position.z - player_pos.z).length()
