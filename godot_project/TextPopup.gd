extends Position2D

onready var label = get_node("Label")
onready var tween = get_node("Tween")

var text = ""

func _ready():
	label.set_text(text)
