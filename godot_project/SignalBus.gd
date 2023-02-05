extends Node

signal attempt_dig

signal dig_return

signal show_dig_txt

signal show_item_panel

signal change_music

func attempt_to_dig(global_translation):
	print("attempting to dig")
	emit_signal("attempt_dig", global_translation)
