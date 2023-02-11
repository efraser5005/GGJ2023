extends Area


func _on_body_entered(body):
	if body.name == "Player":
		SignalBus.emit_signal("change_music", 2)
