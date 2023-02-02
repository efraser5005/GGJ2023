extends Spatial

var camera_rotate_interval = TAU / 8
var camera_rotate_time = 0.2

var last_stable = Transform()
var target = transform

func _process(delta):
	var rotate_progress = $CameraRotateTimer.time_left / camera_rotate_time
	if rotate_progress > 0:
		transform = last_stable.interpolate_with(target, 1 - rotate_progress)
	else:
		transform = target
		last_stable = target

func rotate_camera(steps=1):
	if $CameraRotateTimer.time_left > 0:
		return
	
	target = transform.rotated(Vector3.UP, camera_rotate_interval * steps)
	$CameraRotateTimer.start(camera_rotate_time)
