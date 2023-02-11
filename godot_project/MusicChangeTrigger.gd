extends Node


func _ready():
	SignalBus.connect("show_item_panel", self, "_on_show_item_panel")
	

func _on_show_item_panel(texture, text):
	if get_parent().text == text:
		SignalBus.emit_signal("change_music", 3)
