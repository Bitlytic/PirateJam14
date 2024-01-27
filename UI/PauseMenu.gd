extends Control

@export var options_menu : Control

@onready var options_button := $OptionsButton

var options_shown := false

func on_menu_clicked():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")
	GlobalMusicPlayer.stop_playing()


func on_options_clicked():
	options_menu.show()

func on_visibility_changed():
	if visible:
		options_button.grab_focus()

func on_options_visibility_changed():
	options_shown = options_menu.visible
	if visible && !options_shown:
		options_button.grab_focus()
