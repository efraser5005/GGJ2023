extends Control

var textPopup = preload("res://TextPopup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("show_dig_txt", self, "showDigText")


func showDigText(location, text):
	var popup = textPopup.instance()
	popup.global_position = location
	popup.text = text
	add_child(popup)
