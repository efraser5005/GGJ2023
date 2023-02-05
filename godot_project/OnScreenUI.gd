extends Control

var textPopup = preload("res://TextPopup.tscn")

var randRange = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("show_dig_txt", self, "showDigText")


func showDigText(location, text):
	# randomize location slightly
	var modifier = Vector2(rand_range(-randRange, randRange), rand_range(-randRange, randRange))
	location = location + modifier
	var popup = textPopup.instance()
	popup.global_position = location
	popup.text = text
	add_child(popup)
