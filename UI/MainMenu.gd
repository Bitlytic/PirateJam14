extends Control

@export var start_scene : PackedScene = preload("res://Scenes/Intro_Level.tscn")

@export var options_menu : Control


func on_play_clicked():
	get_tree().change_scene_to_packed(start_scene)


func on_options_clicked():
	options_menu.show()


func on_exit_clicked():
	get_tree().quit()
