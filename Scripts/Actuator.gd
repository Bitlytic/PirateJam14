class_name Actuator
extends Interactable

@export var activatables : Array[Contraption] = []


func interact():
	pass


func activate_all():
	power_all(true)


func deactivate_all():
	power_all(false)


func power_all(power: bool = false):
	for a in activatables:
		if power:
			a.add_source(self)
		else:
			a.remove_source(self)
