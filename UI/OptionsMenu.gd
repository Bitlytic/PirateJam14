extends Control

@onready var fullscreen_option_button := $PanelContainer/VBoxContainer/FullscreenOption/OptionButton

func _process(delta):
	
	if !visible:
		return
		
	if Input.is_action_just_pressed("pause"):
		hide()



func on_visibility_changed():
	if visible:
		fullscreen_option_button.grab_focus()
