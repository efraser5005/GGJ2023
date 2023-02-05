tool
extends Spatial


var texture: Texture
var text: String

var has_been_found:bool = false


func _get_property_list():
	return [
		{
			name = "texture",
			type = TYPE_OBJECT,
			hint = PROPERTY_HINT_RESOURCE_TYPE,
			hint_string = "Texture"
		},
		{
			name = "text",
			type = TYPE_STRING
		}
	]

func get_class():
	return "DigPoint"

func on_player_dig_this_point_up():
	$FireFound.show()
	$FireHint.hide()

	has_been_found = true


