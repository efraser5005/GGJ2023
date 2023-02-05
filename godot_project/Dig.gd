extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("attempt_dig", self, "attemptDig")

enum DISTANCE {HIT, VERYCLOSE, CLOSE, DISTANT, NOTHING}
	
# Get a stepped discrete value depending on distance
func stepDistance(distance):
	if distance < 5:
		return DISTANCE.HIT
	elif distance < 10:
		return DISTANCE.VERYCLOSE
	elif distance < 20:
		return DISTANCE.CLOSE
	elif distance < 50:
		return DISTANCE.DISTANT
	else:
		return DISTANCE.NOTHING
	

func oink(distance):
	match stepDistance(distance):
		DISTANCE.HIT:
			return "OINK!!!"
		DISTANCE.VERYCLOSE:
			return "OINK!"
		DISTANCE.CLOSE:
			return "Oink!"
		DISTANCE.DISTANT:
			return "Oink"
		DISTANCE.NOTHING:
			return "oink..."

func get_nearest_dig_point(location):
	var closest
	for point in get_children():
		if point.get_class() != "DigPoint":
			continue
		
		var translate = point.global_translation
		var translate2d = project_to_x_z(translate)
		var distance = location.distance_to(translate2d)
		if closest == null or distance < closest:
			closest = point
	return closest
	
func attemptDig(playerLocation):
	var playerLocation2D = project_to_x_z(playerLocation)
	var nearest = get_nearest_dig_point(playerLocation2D)
	if nearest == null:
		return
	
	var distance = playerLocation2D.distance_to(
		project_to_x_z(nearest.global_translation)
	)
	
	var oink = oink(distance)
	var hitSomething = stepDistance(distance) == DISTANCE.HIT
	SignalBus.emit_signal("dig_return", [hitSomething, oink])
	
	if hitSomething:
		SignalBus.emit_signal("show_item_panel", nearest.texture, nearest.text)

func project_to_x_z(vector3):
	return Vector2(vector3.x, vector3.z)
