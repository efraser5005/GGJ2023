extends RigidBody

var speed = 3.5
var accel = 4
var velocity_margin = 0.1
var return_to_spawn_depth = -3

var is_jumping = false

func _ready():
	linear_damp = 2
<<<<<<< HEAD
	var bus = get_node("/root/SignalBus")
	print(bus, SignalBus)
	SignalBus.connect("dig_return", self, "dig")
=======
	return_to_spawn_point()
	
func return_to_spawn_point():
	global_transform = get_node("../SpawnPoint").global_transform
>>>>>>> main

func _physics_process(delta):
	if is_jumping:
		return
	
	if global_translation.y < return_to_spawn_depth:
		return_to_spawn_point()
		return
	
	var heading = determine_heading()
	
	add_central_force(heading * speed * accel)
	
	if linear_velocity.length_squared() > velocity_margin:
		$MeshAnchor.look_at(
			$MeshAnchor.global_transform.origin + linear_velocity,
			Vector3.UP
		)

func _integrate_forces(state):
	if is_jumping:
		state.linear_velocity = Vector3()
		return
	
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
	
func dig(canDig, oinkMsg):
	print(canDig, oinkMsg)
	pass

func _input(event):
	if is_jumping:
		return
		
	if event.is_action_pressed("ui_rotate_left"):
		$CameraAnchor.rotate_camera(-1)
	elif event.is_action_pressed("ui_rotate_right"):
		$CameraAnchor.rotate_camera(1)
	elif event.is_action_pressed("ui_accept"):
		$AnimationPlayer.play("JumpStomp")
		SignalBus.emit_signal("attempt_dig", global_translation)
		


func _on_animation_started(anim_name):
	if anim_name == "JumpStomp":
		is_jumping = true
	else:
		is_jumping = false


func _on_animation_finished(anim_name):
	if anim_name == "JumpStomp":
		is_jumping = false

