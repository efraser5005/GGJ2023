extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("change_music", self, "_change_music")
	
	
func _change_music(track):
	match track:
		1:
			reset_music()
		2:
			if $Track1.volume_db == 0:
				$AnimationPlayer.play("FadeToTrack2")
		3:
			if $Track2.volume_db == 0:
				$AnimationPlayer.play("FadeToTrack3")

func reset_music():
	$Track1.play(0)
	$Track1.volume_db = 0
	
	$Track2.volume_db = -80
	$Track2.play(0)
	
	$Track3.volume_db = -80
	$Track3.play(0)
