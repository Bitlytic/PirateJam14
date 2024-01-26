extends Contraption




func turn_on():
	$AnimationPlayer.play("activate")


func turn_off():
	$AnimationPlayer.play("deactivate")
