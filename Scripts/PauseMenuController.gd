extends Node2D

var pause_menu : Control


func _ready():
	pause_menu = get_tree().get_first_node_in_group("pause_menu")


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var paused = pause_menu.visible
		paused = !paused
		
		pause_menu.visible = paused
		
		if paused:
			get_tree().paused = true
		else:
			get_tree().paused = false 
