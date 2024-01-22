class_name Actuator
extends Interactable

@export var activatables : Array[Contraption] = []


func interact():
	print("I'm an actuator")


func activate_all():
	power_all(true)


func deactivate_all():
	power_all(false)


func power_all(power: bool = false):
	for a in activatables:
		a.handle_power(power)
