extends Control


func _ready():
	$Control/MenuButton.grab_focus()


func on_menu_clicked():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")
	GlobalMusicPlayer.stop_playing()
