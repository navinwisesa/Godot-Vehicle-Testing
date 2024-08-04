extends VehicleBody3D

const MAX_STEER = 0.8
const engine_power = 300
@onready var nissan_gtr = $"."

@onready var camera_pivot = $CameraPivot
@onready var camera_3d = $CameraPivot/Camera3D

var look_at


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	look_at = global_position



func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 2.5)
	engine_force = Input.get_axis("down", "fwd") * engine_power
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta *20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta *4)
	look_at = look_at.lerp(global_position + linear_velocity, delta  )
	camera_3d.look_at(look_at)
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()
