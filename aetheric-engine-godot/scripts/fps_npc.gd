extends Node3D

## In-world NPC: cutout billboard (legacy) OR 3D skeletal mesh (target).
## Presentation selected by data.model / auto path models/<id>/humanoid_stub.glb
## Behavior: patrol circuit, dwell idle, face travel dir (skeletal), look-at player when near.

const SPRITE_DIR := "res://assets/characters/sprites/"
const MODEL_DIR := "res://assets/characters/models/"
const WALK_CYCLE_METRES := 0.55
const WALK_FRAME_COUNT := 4

const ATTEND_RADIUS_M := 3.5
const YAW_SPEED := 6.0
const DWELL_JITTER_FRAC := 0.15
const FIDGET_MIN_SEC := 3.5
const FIDGET_MAX_SEC := 7.5

## Cutout-only micro-motion (legacy; skipped when skeletal)
const BREATH_HZ_IDLE := 0.32
const BREATH_HZ_WALK := 0.85
const BREATH_SCALE_IDLE := 0.004

enum Present { CUTOUT, SKELETAL }
enum State { IDLE, WALK, TALK, SIT }

var npc_data: Dictionary = {}
var _points: Array[Vector3] = []
var _index := 0
var _dwell_left := 0.0
var _speed := 0.9
var _base_dwell := 6.0
var _world_h := 1.7
var _present: Present = Present.CUTOUT
var _state: State = State.IDLE

## Cutout
var _char_mesh: MeshInstance3D = null
var _char_mat: StandardMaterial3D = null
var _idle_tex: Texture2D = null
var _idle_texs: Array = []
var _walk_texs: Array = []
var _walk_dist := 0.0
var _walk_frame := -1
var _idle_frame := 0
var _was_dwelling := true
var _mesh_base_scale := Vector3.ONE
var _life_t := 0.0
var _fidget_left := 0.0

## Skeletal
var _visual: Node3D = null          # yaw pivot (faces travel / player)
var _model_root: Node3D = null
var _anim: AnimationPlayer = null
var _skeleton: Skeleton3D = null
var _anim_walk := ""
var _anim_idle := ""
var _neck_bone := -1
var _face_yaw := 0.0
var _moving := false
var _attending := false
var _talking := false
var _last_move_dir := Vector3(0, 0, 1)
var _has_seat := false
var _seat := Vector3.ZERO
var _sit_sec := 12.0
var _sit_left := 0.0
var _going_to_seat := false
var _feet_planted := false

var _player: Node3D = null
var _player_search_cd := 0.0
var _foot_shadow: MeshInstance3D = null

@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var body: StaticBody3D = $Body
@onready var label: Label3D = $Label3D


func setup(data: Dictionary) -> void:
	## May run before @onready when tests instantiate + setup same frame.
	if body_mesh == null:
		body_mesh = get_node_or_null("BodyMesh") as MeshInstance3D
	if body == null:
		body = get_node_or_null("Body") as StaticBody3D
	if label == null:
		label = get_node_or_null("Label3D") as Label3D

	npc_data = data
	var patrol: Array = data.get("patrol", [])
	_points.clear()
	for p in patrol:
		_points.append(Vector3(float(p[0]), 0.0, float(p[2])))
	if _points.is_empty():
		_points.append(Vector3.ZERO)
	global_position = _points[0]
	_base_dwell = float(data.get("dwell_sec", 6.0))
	_dwell_left = _dwell_with_jitter(_base_dwell)
	_speed = float(data.get("speed", 0.9))
	_life_t = randf() * TAU
	_fidget_left = fidget_interval(FIDGET_MIN_SEC, FIDGET_MAX_SEC, randf())

	_has_seat = false
	_going_to_seat = false
	_sit_left = 0.0
	_sit_sec = float(data.get("sit_sec", 12.0))
	if data.has("seat") and data.get("seat") is Array:
		var s: Array = data.get("seat")
		if s.size() >= 3:
			_seat = Vector3(float(s[0]), 0.0, float(s[2]))
			_has_seat = true

	var h: float = float(data.get("height", 1.7))
	_world_h = h
	var npc_id := str(data.get("id", "")).to_lower()

	if body_mesh:
		body_mesh.visible = false

	var model_path := _resolve_model_path(npc_id, data)
	if model_path != "" and _setup_skeletal(model_path, h, data):
		_present = Present.SKELETAL
	else:
		_present = Present.CUTOUT
		_setup_sprite(npc_id, h, data)

	_setup_foot_shadow()

	if label:
		label.text = str(data.get("name", ""))
		label.font_size = 28
		label.position = Vector3(0, h + 0.22, 0)
		label.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
		label.modulate = Color(0.95, 0.88, 0.68, 1.0)
		label.outline_size = 8

	if body:
		var col := body.get_node_or_null("CollisionShape3D") as CollisionShape3D
		if col:
			var shape := col.shape as CapsuleShape3D
			if shape:
				shape.height = h * 0.85
				shape.radius = 0.28
			body.position = Vector3(0, h * 0.5, 0)

	set_meta("npc", data)
	_set_state_idle()


func set_talking(active: bool) -> void:
	## Called from dialogue / proximity if available.
	_talking = active
	if active and _present == Present.SKELETAL:
		_set_state_talk()
	elif not active and _state == State.TALK:
		_set_state_idle()


# --- Pure helpers (tests) -----------------------------------------------------

static func select_walk_frame(distance_m: float, cycle_m: float, n_frames: int) -> int:
	if n_frames <= 0:
		return 0
	var cm: float = cycle_m if cycle_m > 0.0001 else 1.0
	var t: float = fposmod(distance_m / cm, 1.0)
	return int(t * float(n_frames)) % n_frames


static func should_use_idle(dwelling: bool) -> bool:
	return dwelling


static func should_attend_player(dist_m: float, radius_m: float) -> bool:
	return dist_m <= radius_m


static func breath_offset_y(phase: float, amplitude: float) -> float:
	return sin(phase) * amplitude


static func breath_scale_factor(phase: float, amount: float) -> float:
	return 1.0 + sin(phase) * amount


static func dwell_with_jitter(base_sec: float, jitter_frac: float, rand01: float) -> float:
	var b: float = maxf(base_sec, 0.5)
	var j: float = clampf(jitter_frac, 0.0, 0.9)
	var r: float = clampf(rand01, 0.0, 1.0)
	var mul: float = (1.0 - j) + r * (2.0 * j)
	return maxf(0.5, b * mul)


static func fidget_interval(min_sec: float, max_sec: float, rand01: float) -> float:
	var lo: float = minf(min_sec, max_sec)
	var hi: float = maxf(min_sec, max_sec)
	return lo + clampf(rand01, 0.0, 1.0) * (hi - lo)


static func yaw_from_dir(dir: Vector3) -> float:
	## Godot Y-yaw: 0 faces -Z by default for look_at; use atan2(x,z).
	if dir.length_squared() < 0.000001:
		return 0.0
	return atan2(dir.x, dir.z)


static func sprite_path_for(npc_id: String) -> String:
	var id := npc_id.to_lower().strip_edges()
	if id.is_empty():
		return ""
	return SPRITE_DIR + "sprite_%s.png" % id


static func walk_frame_path(npc_id: String, frame: int) -> String:
	return SPRITE_DIR + "sprite_%s_walk_%d.png" % [npc_id.to_lower().strip_edges(), frame]


static func idle_frame_path(npc_id: String, frame: int) -> String:
	return SPRITE_DIR + "sprite_%s_idle_%d.png" % [npc_id.to_lower().strip_edges(), frame]


static func default_model_path(npc_id: String) -> String:
	var id := npc_id.to_lower().strip_edges()
	# Prefer custom character scene, then humanoid stub GLB.
	var custom := MODEL_DIR + "%s/bell_character.tscn" % id if id == "bell" else ""
	if custom != "":
		return custom
	return MODEL_DIR + "%s/humanoid_stub.glb" % id


func _resolve_model_path(npc_id: String, data: Dictionary) -> String:
	if data.has("model") and str(data.get("model", "")) != "":
		var mp := str(data.get("model"))
		if ResourceLoader.exists(mp) or FileAccess.file_exists(ProjectSettings.globalize_path(mp)):
			return mp
	# Bell: custom mesh scene first
	if npc_id == "bell":
		var bell_p := MODEL_DIR + "bell/bell_character.tscn"
		if ResourceLoader.exists(bell_p) or FileAccess.file_exists(ProjectSettings.globalize_path(bell_p)):
			return bell_p
	var auto_p := MODEL_DIR + "%s/humanoid_stub.glb" % npc_id
	if ResourceLoader.exists(auto_p) or FileAccess.file_exists(ProjectSettings.globalize_path(auto_p)):
		return auto_p
	return ""


# --- Skeletal setup -----------------------------------------------------------

func _setup_skeletal(model_path: String, height: float, data: Dictionary) -> bool:
	if not ResourceLoader.exists(model_path):
		# Trigger import path via FileAccess existence
		if not FileAccess.file_exists(ProjectSettings.globalize_path(model_path)):
			return false
	var packed = load(model_path)
	if packed == null or not (packed is PackedScene):
		push_warning("fps_npc: model not PackedScene: " + model_path)
		return false

	_visual = Node3D.new()
	_visual.name = "Visual"
	add_child(_visual)

	_model_root = (packed as PackedScene).instantiate()
	_model_root.name = "Model"
	_visual.add_child(_model_root)
	if _model_root.has_method("ensure_built"):
		_model_root.ensure_built()

	_anim = _find_animation_player(_model_root)
	_skeleton = _find_skeleton(_model_root)
	if _skeleton:
		# Prefer highest neck joint for look-at (limited yaw only — pitch looked broken).
		for i in range(_skeleton.get_bone_count() - 1, -1, -1):
			var bn2 := _skeleton.get_bone_name(i).to_lower()
			if "neck" in bn2:
				_neck_bone = i
				break

	# Height fit: custom Bell ships native ~1.78 m; only rescale if needed.
	var sc := 1.0
	if _model_root.has_meta("native_height"):
		var nh: float = float(_model_root.get_meta("native_height"))
		if nh > 0.1:
			sc = height / nh
	elif _model_root.has_method("get_mesh_height"):
		var mh: float = float(_model_root.call("get_mesh_height"))
		if mh > 0.1:
			sc = height / mh
	else:
		var aabb := _combined_mesh_aabb(_model_root)
		var model_h: float = maxf(aabb.size.y, 0.5)
		sc = height / model_h
	_model_root.scale = Vector3(sc, sc, sc)
	_model_root.position = Vector3.ZERO
	# Mesh may already plant itself; re-plant in NPC space after scale.
	if _model_root.has_method("ensure_built"):
		# Re-run plant inside mesh after scale applied on Model node
		pass
	_plant_feet_to_ground()
	_feet_planted = false  # force re-plant first physics with globals

	# Only force flat tint on generic stubs — custom Bell mesh keeps its materials.
	if bool(data.get("tint_victorian", false)):
		_apply_victorian_tint(_model_root)

	if _anim:
		var clips := _anim.get_animation_list()
		if clips.size() > 0:
			_anim_walk = clips[0]
			_anim_idle = clips[0]
			for c in clips:
				var cl := String(c).to_lower()
				if cl == "walk" or "walk" in cl or "run" in cl:
					_anim_walk = c
				if cl == "idle" or "idle" in cl or "stand" in cl:
					_anim_idle = c
			# Prefer exact names
			if _anim.has_animation("walk"):
				_anim_walk = "walk"
			if _anim.has_animation("idle"):
				_anim_idle = "idle"
		_play_anim(_anim_idle, 1.0)
	return true


func _plant_feet_to_ground() -> void:
	## Snap lowest mesh geometry to y≈0 in NPC space.
	if _model_root == null or _visual == null:
		return
	var bottom := INF
	# Prefer character-authored measurement (works without globals).
	if _model_root.has_method("get_mesh_bottom_y"):
		bottom = float(_model_root.call("get_mesh_bottom_y"))
	else:
		var found := false
		for mi in _all_mesh_instances(_model_root):
			if mi.mesh == null:
				continue
			var a: AABB = mi.get_aabb()
			for i in 8:
				var corner := a.get_endpoint(i)
				var world: Vector3
				if mi.is_inside_tree():
					world = mi.global_transform * corner
					var local: Vector3 = to_local(world)
					if local.y < bottom:
						bottom = local.y
						found = true
		if not found:
			var aabb := _combined_mesh_aabb(_model_root)
			bottom = _model_root.position.y + aabb.position.y * _model_root.scale.y
	if bottom == INF:
		return
	# Account for current Model scale: get_mesh_bottom_y is in unscaled model space
	# if measured before scale; after scale, bottom scales with Model.scale.y
	var scaled_bottom := bottom * _model_root.scale.y
	# bottom is relative to Model origin in Model local units
	_model_root.position.y = -scaled_bottom + 0.01
	_feet_planted = true


func _all_mesh_instances(n: Node) -> Array[MeshInstance3D]:
	var out: Array[MeshInstance3D] = []
	if n is MeshInstance3D:
		out.append(n as MeshInstance3D)
	for c in n.get_children():
		out.append_array(_all_mesh_instances(c))
	return out


func _apply_victorian_tint(n: Node) -> void:
	## Dark coat-ish material until custom Bell mesh exists.
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		var mat := StandardMaterial3D.new()
		mat.albedo_color = Color(0.22, 0.18, 0.16)
		mat.roughness = 0.88
		mat.metallic = 0.04
		mi.material_override = mat
	for c in n.get_children():
		_apply_victorian_tint(c)



func _find_animation_player(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var f := _find_animation_player(c)
		if f:
			return f
	return null


func _find_skeleton(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var f := _find_skeleton(c)
		if f:
			return f
	return null


func _combined_mesh_aabb(n: Node) -> AABB:
	var out := AABB()
	var first := true
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			var a := mi.get_aabb()
			# Include node local transform roughly
			a.position = mi.position + a.position
			out = a
			first = false
	for c in n.get_children():
		var a2 := _combined_mesh_aabb(c)
		if a2.size.length_squared() < 0.0000001:
			continue
		if first:
			out = a2
			first = false
		else:
			out = out.merge(a2)
	if first:
		out = AABB(Vector3(-0.3, 0, -0.3), Vector3(0.6, 1.7, 0.6))
	return out


func _play_anim(clip: String, speed: float = 1.0) -> void:
	if _anim == null or clip == "":
		return
	if not _anim.has_animation(clip):
		return
	# Always restart so walk→idle reapplies rest-pose keys (no sticky mid-stride).
	if _anim.current_animation != clip or not _anim.is_playing():
		_anim.play(clip)
	else:
		_anim.seek(0.0, true)
	_anim.speed_scale = speed


# --- Cutout setup (legacy) ----------------------------------------------------

static func _load_texture(tex_path: String) -> Texture2D:
	if tex_path == "":
		return null
	var abs_path := ProjectSettings.globalize_path(tex_path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		if img.load(abs_path) == OK:
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
	_mesh_base_scale = mi.scale


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
	mi.material_override = mat
	mi.position = Vector3(0, 0.008, 0)
	add_child(mi)
	_foot_shadow = mi


# --- State / presentation -----------------------------------------------------

func _set_state_idle() -> void:
	_state = State.IDLE
	_walk_dist = 0.0
	_walk_frame = -1
	_was_dwelling = true
	_moving = false
	if _present == Present.SKELETAL:
		_play_anim(_anim_idle, 0.35)
	else:
		if not _idle_texs.is_empty():
			_set_sprite_tex(_idle_texs[_idle_frame])
		elif _idle_tex:
			_set_sprite_tex(_idle_tex)
		elif not _walk_texs.is_empty():
			_set_sprite_tex(_walk_texs[0])


func _set_state_walk() -> void:
	_state = State.WALK
	_was_dwelling = false
	_moving = true
	if _present == Present.SKELETAL:
		_play_anim(_anim_walk, 1.0)


func _set_state_talk() -> void:
	_state = State.TALK
	_moving = false
	_going_to_seat = false
	if _present == Present.SKELETAL:
		_play_anim(_anim_idle, 0.4)


func _set_state_sit() -> void:
	_state = State.SIT
	_moving = false
	_going_to_seat = false
	_sit_left = _sit_sec
	if _present == Present.SKELETAL:
		if _anim and _anim.has_animation("sit"):
			_play_anim("sit", 1.0)
		else:
			_play_anim(_anim_idle, 0.2)


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


func _dwell_with_jitter(base: float) -> float:
	return dwell_with_jitter(base, DWELL_JITTER_FRAC, randf())


# --- Process ------------------------------------------------------------------

func _physics_process(delta: float) -> void:
	_life_t += delta
	_moving = false

	# Re-plant once globals are valid (setup may run before full in-tree transforms).
	if _present == Present.SKELETAL and not _feet_planted:
		_plant_feet_to_ground()

	if _talking and _present == Present.SKELETAL:
		_state = State.TALK
	elif _points.size() >= 2:
		_moving = _process_patrol(delta)
	else:
		if _state != State.TALK:
			_set_state_idle()

	_update_attention(delta)
	_update_facing(delta)
	_update_neck_look()
	if _present == Present.CUTOUT:
		_process_cutout_breath(delta)


func _process_patrol(delta: float) -> bool:
	if _talking:
		return false

	# Sitting at activity marker (Phase 2)
	if _state == State.SIT:
		_sit_left -= delta
		if _sit_left <= 0.0:
			_set_state_idle()
			_dwell_left = _dwell_with_jitter(_base_dwell * 0.5)
		return false

	if _dwell_left > 0.0:
		_dwell_left -= delta
		if _state != State.IDLE:
			_set_state_idle()
		return false

	var target: Vector3
	if _going_to_seat and _has_seat:
		target = _seat
	else:
		target = _points[_index]

	var flat := Vector2(global_position.x - target.x, global_position.z - target.z)
	if flat.length() < 0.2:
		if _going_to_seat and _has_seat:
			_set_state_sit()
			return false
		_index = (_index + 1) % _points.size()
		# After a full circuit, skeletal NPCs with a seat may go sit/work.
		if _index == 0 and _has_seat and _present == Present.SKELETAL and randf() < 0.55:
			_going_to_seat = true
			return false
		_dwell_left = _dwell_with_jitter(_base_dwell)
		_set_state_idle()
		return false

	var dir := Vector3(target.x - global_position.x, 0.0, target.z - global_position.z).normalized()
	_last_move_dir = dir
	var step := _speed * delta
	global_position += dir * step

	if _present == Present.SKELETAL:
		if _state != State.WALK:
			_set_state_walk()
	else:
		if not _walk_texs.is_empty():
			_walk_dist += step
			var frame := select_walk_frame(_walk_dist, WALK_CYCLE_METRES, _walk_texs.size())
			_set_walk_frame(frame)
			_state = State.WALK
		elif _state != State.WALK:
			_state = State.WALK
	return true


func _update_attention(_delta: float) -> void:
	var player := _resolve_player()
	var want := false
	if player:
		want = should_attend_player(distance_to_player(player.global_position), ATTEND_RADIUS_M)
	_attending = want or _talking


func _update_facing(delta: float) -> void:
	if _present != Present.SKELETAL or _visual == null:
		return
	var target_yaw := _face_yaw
	if _moving:
		target_yaw = yaw_from_dir(_last_move_dir)
	elif _attending:
		var player := _resolve_player()
		if player:
			var to_p := player.global_position - global_position
			to_p.y = 0.0
			if to_p.length_squared() > 0.0001:
				target_yaw = yaw_from_dir(to_p.normalized())
	_face_yaw = lerp_angle(_face_yaw, target_yaw, clampf(YAW_SPEED * delta, 0.0, 1.0))
	_visual.rotation.y = _face_yaw


func _update_neck_look() -> void:
	## CesiumMan neck bones + pitch looked like a permanent head-down. For the stub,
	## body yaw toward player is enough; keep neck at rest.
	if _present != Present.SKELETAL or _skeleton == null or _neck_bone < 0:
		return
	_skeleton.set_bone_pose_rotation(_neck_bone, Quaternion.IDENTITY)


func _process_cutout_breath(_delta: float) -> void:
	if _char_mesh == null:
		return
	var hz := BREATH_HZ_WALK if _moving else BREATH_HZ_IDLE
	var scale_amt := BREATH_SCALE_IDLE * (1.2 if _moving else 1.0)
	var phase := _life_t * TAU * hz
	var sc := breath_scale_factor(phase, scale_amt)
	_char_mesh.scale = Vector3(_mesh_base_scale.x * sc, _mesh_base_scale.y * sc, _mesh_base_scale.z)
	var half_h := _world_h * 0.5
	_char_mesh.position.y = half_h * sc + 0.01


func _resolve_player() -> Node3D:
	if _player != null and is_instance_valid(_player):
		return _player
	var tree := get_tree()
	if tree == null:
		return null
	_player_search_cd -= get_physics_process_delta_time()
	if _player_search_cd > 0.0:
		return null
	_player_search_cd = 0.75
	var scene := tree.current_scene
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


func distance_to_player(player_pos: Vector3) -> float:
	return Vector2(global_position.x - player_pos.x, global_position.z - player_pos.z).length()


func is_skeletal() -> bool:
	return _present == Present.SKELETAL
