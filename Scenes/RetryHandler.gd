extends Node2D

func _ready():
	if !RetrySettings.valid:
		return
	
	var core = get_tree().get_first_node_in_group("core")
	var player = get_tree().get_first_node_in_group("player")
	var player_camera = get_tree().get_first_node_in_group("player camera")
	
	
	player.global_position = RetrySettings.checkpoint
	core.global_position = RetrySettings.checkpoint
	
	player_camera.global_position = RetrySettings.camera_target


