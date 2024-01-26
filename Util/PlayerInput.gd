class_name PlayerInput

var directional_input := Vector2()
var jump_pressed := false
var jump_held := false

func _to_string():
	return "dir: " + str(directional_input) + "; jump: " + str(jump_pressed) + "; held: " + str(jump_held)
