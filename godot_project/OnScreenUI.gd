extends Control

var textPopup = preload("res://TextPopup.tscn")

var randRange = 50

var itemCounter = 0
var totalItems = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$TruffleCounter.text = String(itemCounter) + "/" + String(totalItems)
	SignalBus.connect("show_dig_txt", self, "showDigText")


func showDigText(location, text):
	# randomize location slightly
	var modifier = Vector2(rand_range(-randRange, randRange), rand_range(-randRange, randRange))
	location = location + modifier
	var popup = textPopup.instance()
	popup.global_position = location
	popup.text = text
	add_child(popup)


func _on_Dig_Points_update_item_counter():
	itemCounter += 1
	$TruffleCounter.text = String(itemCounter) + "/" + String(totalItems)	
