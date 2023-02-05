extends Node
const PlayScene = preload("res://PlayScene.tscn")


func _on_MainMenu_new_game():
	var existing_scene = get_node("PlayScene")
	if existing_scene:
		existing_scene.queue_free()
		$BackgroundMusic.reset_music()
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	add_child(PlayScene.instance())
	$MainMenu.hide()
	get_tree().paused = false
	

func _on_MainMenu_resume_game():
	$MainMenu.hide()
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		var existing_scene = get_node("PlayScene")
		if existing_scene:
			$MainMenu.show_resume_game_button()
		$MainMenu.show()

