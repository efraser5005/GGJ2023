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
	
func checkDistance(playerLocation):
	var closest
	for point in get_children():
		var translate = point.global_translation
		var translate2d = Vector2(translate.x, translate.z)
		var distance = playerLocation.distance_to(translate2d)
		if closest == null or distance < closest:
			closest = distance
	return closest
	
	
func attemptDig(playerLocation):
	var playerLocation2D = Vector2(playerLocation.x, playerLocation.z)
	var distance = checkDistance(playerLocation2D)
	if distance == null:
		return
	var oink = oink(distance)
	var hitSomething = stepDistance(distance) == DISTANCE.HIT
	SignalBus.emit_signal("dig_return", [hitSomething, oink])
