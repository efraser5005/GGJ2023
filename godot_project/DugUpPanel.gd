extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_KeepDiggingButton_pressed()
	if event.is_action_pressed("ui_page_down"):
		display_dug_up_panel()



func _on_KeepDiggingButton_pressed():
	self.hide()
	get_tree().paused = false


func set_panel_contents(object_texture, object_text):
	$VBoxContainer/ItemImage.texture = object_texture
	$VBoxContainer/ItemTextLabel.text = object_text
	
	
func display_dug_up_panel():
	get_tree().paused = true
	self.show()
	
