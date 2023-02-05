extends Node

signal update_item_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("attempt_dig", self, "attemptDig")

enum DISTANCE {HIT, VERYCLOSE, CLOSE, DISTANT, NOTHING}
	
# Get a stepped discrete value depending on distance
func stepDistance(distance):
	if distance < 2:
		return DISTANCE.HIT
	elif distance < 4:
		return DISTANCE.VERYCLOSE
	elif distance < 12:
		return DISTANCE.CLOSE
	elif distance < 20:
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

func get_nearest_dig_point(playerLocation):
	var closest
	for point in get_children():
		if point.get_class() != "DigPoint":
			continue
		
		var itemLocation = point.global_translation
		var distance = get_x_z_distance(playerLocation, itemLocation)
		if closest == null or distance < closest:
			closest = point
	return closest
	
func attemptDig(playerLocation):
	var nearestItem = get_nearest_dig_point(playerLocation)
	if nearestItem == null:
		return
	
	var distance = get_x_z_distance(playerLocation, nearestItem.global_translation)
	
	var oink = oink(distance)
	var hitSomething = stepDistance(distance) == DISTANCE.HIT
	SignalBus.emit_signal("dig_return", [hitSomething, oink])
	
	if hitSomething:
		show_item_panel(nearestItem.texture, nearestItem.text)
		nearestItem.queue_free()
		

		
func show_item_panel(texture, text):
	yield(get_tree().create_timer(1.625), "timeout")
	SignalBus.emit_signal("show_item_panel", texture, text)
	emit_signal("update_item_counter")
	
func get_x_z_distance(firstLocation, secondLocation):
	var first2D = Vector2(firstLocation.x, firstLocation.z)
	var second2D = Vector2(secondLocation.x, secondLocation.z)
	return first2D.distance_to(second2D)
