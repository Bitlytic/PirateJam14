extends Actuator

@export var default_activated := false

@onready var activated := default_activated


func _ready():
	sprite = $Sprite2D
	unhighlight()
	power_all(activated)
	handle_animation()


func interact():
	activated = !activated
	
	power_all(activated)
	
	handle_animation()


func handle_animation():
	if activated:
		$AnimationPlayer.play("activate")
	else:
		$AnimationPlayer.play("deactivate")	
