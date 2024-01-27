extends Control

@export var start_scene : PackedScene = preload("res://Scenes/Intro_Level.tscn")

@export var options_menu : Control

@onready var play_button : Control = $VBoxContainer/PlayButton

func _ready():
	play_button.grab_focus()


func on_play_clicked():
	get_tree().change_scene_to_packed(start_scene)
	GlobalMusicPlayer.start_playing()


func on_options_clicked():
	options_menu.show()

func on_options_hidden():
	play_button.grab_focus()


func on_exit_clicked():
	get_tree().quit()
