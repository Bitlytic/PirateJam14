extends Actuator

@export var standard_time := 2.0
@export var time := 2.0


func _ready():
	sprite = $Sprite2D
	unhighlight()
	power_all(false)


func interact():
	$AnimationPlayer.stop(false)
	$AnimationPlayer.play("tick", -1, standard_time / time)
	
	power_all(true)


func on_animation_finish(anim_name):
	if anim_name == "tick":
		power_all(false)
