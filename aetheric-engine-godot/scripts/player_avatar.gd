extends Sprite2D

const WALK_SPEED := 320.0

var bounds := Rect2(120, 180, 1680, 820)
var _facing := 1

func _ready() -> void:
	texture = load("res://assets/player/rowan_ellis.jpg")
	centered = false
	offset = Vector2(-48, -140)
	scale = Vector2(0.55, 0.55)
	z_index = 10

func _process(delta: float) -> void:
	var dir := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	if dir.length_squared() > 0.0:
		dir = dir.normalized()
		position += dir * WALK_SPEED * delta
		if dir.x != 0.0:
			_facing = 1 if dir.x > 0.0 else -1
			scale.x = absf(scale.x) * _facing
	_clamp_to_bounds()

func set_bounds(rect: Rect2) -> void:
	bounds = rect
	_clamp_to_bounds()

func set_spawn(point: Vector2) -> void:
	position = point
	_clamp_to_bounds()

func _clamp_to_bounds() -> void:
	position.x = clampf(position.x, bounds.position.x, bounds.position.x + bounds.size.x)
	position.y = clampf(position.y, bounds.position.y, bounds.position.y + bounds.size.y)