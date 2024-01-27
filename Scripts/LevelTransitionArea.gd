class_name LevelTransitionArea
extends Area2D


@export var checkpoint : Node2D

@export var camera_target : Node2D
@export var player_camera : PlayerCamera
@export var camera_zoom := 3.0

@export_flags_2d_physics var player_collision_mask : int = 0b00000001

var travel_time := 0.75

func _ready():
	if !player_camera:
		# Fuck it, we'll just register it globally lmao
		player_camera = get_tree().get_first_node_in_group("player_camera")
	
	collision_mask = player_collision_mask
	body_entered.connect(on_body_entered)


func on_body_entered(_body):
	
	if !player_camera:
		player_camera = get_tree().get_first_node_in_group("player_camera")
	
	if player_camera.global_position == camera_target.global_position || player_camera.target_position == camera_target.global_position:
		return

	player_camera.target_position = camera_target.global_position
	
	if checkpoint:
		RetrySettings.camera_target = camera_target.global_position
		RetrySettings.checkpoint = checkpoint.global_position
		RetrySettings.valid = true
