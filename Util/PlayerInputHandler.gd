class_name PlayerInputHandler


static func get_player_input() -> PlayerInput:
	var player_input := PlayerInput.new()
	
	player_input.directional_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player_input.jump_pressed = Input.is_action_just_pressed("move_jump")
	player_input.jump_held = Input.is_action_pressed("move_jump")
	
	return player_input
