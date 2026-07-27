extends Node3D

## In-world NPC: camera-facing full-figure sprite billboard + collision for E-talk.
## Sprites: res://assets/characters/sprites/sprite_<id>.png (hard alpha cutout on black bg)

const SPRITE_DIR := "res://assets/characters/sprites/"

var npc_data: Dictionary = {}
var _points: Array[Vector3] = []
var _index := 0
var _dwell_left := 0.0
var _speed := 0.9
var _sprite: Sprite3D = null

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

	var h: float = data.get("height", 1.7)
	var npc_id := str(data.get("id", "")).to_lower()

	if body_mesh:
		body_mesh.visible = false

	_setup_sprite(npc_id, h, data)

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


static func sprite_path_for(npc_id: String) -> String:
	var id := npc_id.to_lower().strip_edges()
	if id.is_empty():
		return ""
	return SPRITE_DIR + "sprite_%s.png" % id


static func _load_texture(tex_path: String) -> Texture2D:
	if tex_path == "":
		return null
	if ResourceLoader.exists(tex_path):
		var res = load(tex_path)
		if res is Texture2D:
			return res
	var abs_path := ProjectSettings.globalize_path(tex_path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		if img.load(abs_path) == OK:
			return ImageTexture.create_from_image(img)
	return null


func _setup_sprite(npc_id: String, height: float, data: Dictionary) -> void:
	var path := str(data.get("sprite", sprite_path_for(npc_id)))
	var tex: Texture2D = _load_texture(path)

	if tex == null:
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

	# Use a depth-writing quad mesh instead of Sprite3D soft transparency.
	# ALPHA_SCISSOR keeps opaque clothing (black dresses) solid and sorts with furniture.
	var tex_h: float = float(tex.get_height())
	var tex_w: float = float(tex.get_width())
	if tex_h < 1.0:
		tex_h = 1024.0
	if tex_w < 1.0:
		tex_w = 512.0
	var aspect: float = tex_w / tex_h
	var world_h: float = height
	var world_w: float = height * aspect

	var quad := QuadMesh.new()
	quad.size = Vector2(world_w, world_h)
	var mi := MeshInstance3D.new()
	mi.name = "CharacterSprite"
	mi.mesh = quad
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = tex
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	mat.alpha_scissor_threshold = 0.5
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	mat.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y
	mat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_OPAQUE_ONLY
	mi.material_override = mat
	# Feet on floor: quad center at half height
	mi.position = Vector3(0, world_h * 0.5 + 0.01, 0)
	add_child(mi)
	_sprite = null # mesh path; keep var for compatibility


func _physics_process(delta: float) -> void:
	if _points.size() < 2:
		return
	if _dwell_left > 0.0:
		_dwell_left -= delta
		return
	var target := _points[_index]
	var flat := Vector2(global_position.x - target.x, global_position.z - target.z)
	if flat.length() < 0.2:
		_index = (_index + 1) % _points.size()
		_dwell_left = npc_data.get("dwell_sec", 6.0)
		return
	var dir := Vector3(target.x - global_position.x, 0.0, target.z - global_position.z).normalized()
	global_position += dir * _speed * delta


func distance_to_player(player_pos: Vector3) -> float:
	return Vector2(global_position.x - player_pos.x, global_position.z - player_pos.z).length()
