extends Position2D

onready var label = get_node("Label")
onready var tween = get_node("Tween")

var text = ""

func _ready():
	label.set_text(text)
	
	tween.interpolate_property(self, 'scale', scale, Vector2(1, 1), 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(1, 1), Vector2(0.1, 0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1.2)
	tween.start()

func _on_Tween_tween_all_completed():
	self.queue_free()
