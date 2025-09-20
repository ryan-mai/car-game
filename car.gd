extends RigidBody3D

@export var acceleration := 40.0
@export var steering := 1.5
@export var effectTurnSpeed := 0.1
@export var effectTurnTilt := 0.5
@onready var car: Node3D = $Car
@onready var carBody: MeshInstance3D = $Car/CarBody
@onready var carTailLight: MeshInstance3D = $Car/TailLight
@onready var carWRL: MeshInstance3D = $Car/WRL
@onready var carWRR: MeshInstance3D = $Car/WRR
@onready var carWFL: MeshInstance3D = $Car/WFL
@onready var carWFR: MeshInstance3D = $Car/WFR

var speedForce: float
var turnDegree: float

func _ready() -> void:
	axis_lock_angular_x = true
	axis_lock_angular_z = true
	add_to_group("player")
	#car.top_level = true
	
func _physics_process(delta: float) -> void:
	#car.global_position = global_position - Vector3(0, 0.1, 0)
	
	speedForce = Input.get_axis("ui_up", "ui_down") * acceleration
	turnDegree = Input.get_axis("ui_right", "ui_left") * deg_to_rad(steering)
	
	_curve_effect(delta)
	
	#car.rotate_y(turnDegree)
	var steerStrength = linear_velocity.length() + 5.0

	apply_force(-global_transform.basis.z * speedForce)
	apply_torque(Vector3.UP * turnDegree * steerStrength)
func _curve_effect(delta) -> void:
	var turnStrengthValue = turnDegree * linear_velocity.length() / effectTurnSpeed
	var turnTiltValue = -turnDegree * linear_velocity.length() / effectTurnTilt
	var changeSpeed = 1
	
	if turnDegree == 0:
		changeSpeed = 3
	
	carWFR.rotation.y = lerp(carWFR.rotation.y, turnStrengthValue, changeSpeed * delta)
	carWFL.rotation.y = lerp(carWFL.rotation.y, turnStrengthValue, changeSpeed * delta)
	#carBody.rotation.y = lerp(carBody.rotation.y, turnStrengthValue, changeSpeed * delta)	
	#carBody.rotation.z = lerp(carBody.rotation.z, turnTiltValue, changeSpeed * delta)
