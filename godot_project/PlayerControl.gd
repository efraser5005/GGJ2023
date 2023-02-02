extends RigidBody

var speed = 3.5
var accel = 4
var velocity_margin = 0.1

func _ready():
	linear_damp = 2

func _physics_process(delta):
	var heading = determine_heading()
	
	add_central_force(heading * speed * accel)
	
	if linear_velocity.length_squared() > velocity_margin:
		$MeshAnchor.look_at(
			$MeshAnchor.global_transform.origin + linear_velocity,
			Vector3.UP
		)

func _integrate_forces(state):
	state.linear_velocity = state.linear_velocity.limit_length(speed)

func determine_heading():
	var camera_to_player = global_transform.origin - $CameraAnchor/Camera.global_transform.origin
	camera_to_player.y = 0 # We only care about lateral direction.
	camera_to_player = camera_to_player.normalized()
	var forward = camera_to_player
	var right = camera_to_player.rotated(Vector3.UP, -TAU / 4)
	
	var heading = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		heading += forward
	
	if Input.is_action_pressed("ui_down"):
		heading -= forward
	
	if Input.is_action_pressed("ui_left"):
		heading -= right
	
	if Input.is_action_pressed("ui_right"):
		heading += right
	
	return heading.normalized()

func _input(event):
	if event.is_action_pressed("ui_rotate_left"):
		$CameraAnchor.rotate_camera(-1)
	elif event.is_action_pressed("ui_rotate_right"):
		$CameraAnchor.rotate_camera(1)
