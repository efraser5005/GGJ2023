extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


signal new_game
signal resume_game

func show_resume_game_button():
	$VBoxContainer/ResumeGameButton.show()


func _on_NewGameButton_pressed():
	emit_signal("new_game")
	
func _on_ResumeGameButton_pressed():
	emit_signal("resume_game")
	
func _on_QuitButton_pressed():
	get_tree().quit()
