extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var digPoints


# Called when the node enters the scene tree for the first time.
func _ready():
	digPoints = get_node("Dig Points")
	
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
	
func checkDistance(playerLocation):
	var closest
	for point in digPoints.get_children():
		var translate = point.global_translate()
		var translate2d = Vector2(translate.x, translate.z)
		var distance = playerLocation.distance_to(translate2d)
		if closest == null or distance < closest:
			closest = distance
	return closest
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
