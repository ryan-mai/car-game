extends VehicleBody3D

signal emit_speed(speed)
@onready var camera: Camera3D = $Camera3D
var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3
var _want_reset: bool = false

func _ready() -> void:
	add_to_group("player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") and event.pressed and not event.echo:
		print("Reset input received")
		_want_reset = true


func _reset() -> void:
	var t = Transform3D(Basis(Vector3.UP, deg_to_rad(-90.0)), Vector3(1.5, 1.5, 2.0))
	global_transform = t
	engine_force = 0
	brake = 2
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	sleeping = true

func _physics_process(delta: float) -> void:
	if _want_reset:
		var t = Transform3D(Basis(Vector3.UP, deg_to_rad(-90.0)), Vector3(1.5, 1.5, 2.0))
		global_transform = t
		engine_force = 0
		brake = 2
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		sleeping = true
		_want_reset = false

	var direction = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steering_direction = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")

	var left_RPM = abs($wheel_back_left.get_rpm())
	var right_RPM = abs($wheel_back_right.get_rpm())
	var RPM = (left_RPM + right_RPM) / 2.0
	
	var torque = direction * max_torque * (3.0 - RPM / max_RPM)
	emit_signal("emit_speed", (torque))
	steering = lerp(steering, steering_direction * turn_amount, turn_speed * delta)
	if direction != 0:
		if direction < 0:
			camera.position.y = 2.5
			camera.position.z = 5.0
			camera.rotation.y = 0
		else:
			camera.position.y = 3.0
			camera.position.z = -5.0
			camera.rotation.y = deg_to_rad(180.0)
		engine_force = torque
		brake = 0
	else:
		engine_force = 0
		brake = 2
