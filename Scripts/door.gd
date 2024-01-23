extends Contraption




func turn_on():
	print("Bruh")
	$AnimationPlayer.play("activate")


func turn_off():
	print("Bruh'nt")
	$AnimationPlayer.play("deactivate")
