extends Control



func _process(delta):
	if !visible:
		return
		
	if Input.is_action_just_pressed("pause"):
		hide()
