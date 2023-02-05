extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("change_music", self, "_change_music")
	
	
func _change_music():
	if $Track1.volume_db == 0:
		$AnimationPlayer.play("FadeToTrack2")
