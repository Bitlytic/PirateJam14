extends Control

func on_menu_clicked():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")


func on_resume_clicked():
	hide()
	get_tree().paused = false
