extends CharacterBody3D

## Walk (not skate): accelerate/decelerate instead of snapping to full speed.
const WALK_SPEED := 2.55
const ACCEL := 11.0
const FRICTION := 14.0
const MOUSE_SENS := 0.0016

## Diorama mode: turn left/right only — no looking up at the ceiling or down at the floor.
const ALLOW_PITCH := false
const FIXED_PITCH := deg_to_rad(-4.0)
const MIN_PITCH := deg_to_rad(-12.0)
const MAX_PITCH := deg_to_rad(12.0)

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interact_ray: RayCast3D = $Head/Camera3D/InteractRay

var _mouse_captured := false
var _movement_enabled := true

func _ready() -> void:
	interact_ray.target_position = Vector3(0, 0, -3.5)
	if not ALLOW_PITCH:
		camera.rotation.x = FIXED_PITCH
	capture_mouse()

func capture_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_mouse_captured = true

func release_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_mouse_captured = false

func set_movement_enabled(enabled: bool) -> void:
	_movement_enabled = enabled
	if not enabled:
		velocity = Vector3.ZERO

func teleport_to(pos: Vector3, yaw_deg: float) -> void:
	global_position = pos
	head.rotation.y = deg_to_rad(yaw_deg)
	camera.rotation.x = FIXED_PITCH if not ALLOW_PITCH else 0.0
	velocity = Vector3.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and _mouse_captured and _movement_enabled:
		head.rotate_y(-event.relative.x * MOUSE_SENS)
		if ALLOW_PITCH:
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
			camera.rotation.x = clampf(camera.rotation.x, MIN_PITCH, MAX_PITCH)
		else:
			camera.rotation.x = FIXED_PITCH
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not _mouse_captured and _movement_enabled:
			capture_mouse()
	if event.is_action_pressed("ui_cancel"):
		if _mouse_captured:
			release_mouse()
		else:
			capture_mouse()

func _physics_process(delta: float) -> void:
	if not _movement_enabled:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	else:
		velocity.y = 0.0

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	if direction.length_squared() > 0.0:
		# Ramp up to walk speed — avoids ice-skate / instant full velocity
		velocity.x = move_toward(velocity.x, direction.x * WALK_SPEED, ACCEL * delta)
		velocity.z = move_toward(velocity.z, direction.z * WALK_SPEED, ACCEL * delta)
	else:
		# Ground friction when releasing keys
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)
		velocity.z = move_toward(velocity.z, 0.0, FRICTION * delta)

	move_and_slide()

func get_look_target() -> Node3D:
	if interact_ray.is_colliding():
		var collider = interact_ray.get_collider()
		if collider and collider.get_parent() and collider.get_parent().has_meta("npc"):
			return collider.get_parent()
	return null