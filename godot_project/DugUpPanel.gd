extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("show_item_panel", self, "show_item_panel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_KeepDiggingButton_pressed()
	if event.is_action_pressed("ui_page_down"):
		show_item_panel(null, "Lorem ipsum")



func _on_KeepDiggingButton_pressed():
	self.hide()
	get_tree().paused = false


func set_panel_contents(object_texture, object_text):
	$VBoxContainer/HBoxContainer/ItemImage.texture = object_texture
	$VBoxContainer/HBoxContainer/ItemTextLabel.text = object_text
	
	
func show_item_panel(object_texture, object_text):
	set_panel_contents(object_texture, object_text)
	get_tree().paused = true
	self.show()
	
