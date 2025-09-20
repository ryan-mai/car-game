extends VehicleBody3D

var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

func _physics_process(delta: float) -> void:
	$CameraArm.position = position
	
	var direction = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steering_direction = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")

	var left_RPM = abs($Wheel_Rear_Left.get_rpm())
	var right_RPM = abs($Wheel_Rear_Right.get_rpm())
	var RPM = (left_RPM - right_RPM) / 2.0
	
	var torque = direction * max_torque * (1.0 - RPM / max_RPM)

	engine_force = torque
	steering = lerp(steering, steering_direction * turn_amount, turn_speed * delta)
	
	if direction == 0:
		brake = 2
