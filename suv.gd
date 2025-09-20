extends VehicleBody3D

var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steering_direction = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")

	var left_RPM = abs($wheel_back_left.get_rpm())
	var right_RPM = abs($wheel_back_right.get_rpm())
	var RPM = (left_RPM + right_RPM) / 2.0
	
	var torque = direction * max_torque * (1.0 - RPM / max_RPM)

	steering = lerp(steering, steering_direction * turn_amount, turn_speed * delta)
	print(engine_force)
	if direction != 0:
		engine_force = torque
		brake = 0
	else:
		engine_force = 0
		brake = 2
