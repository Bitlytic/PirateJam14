class_name Contraption
extends Node2D

@export var inverse_power := false


func _ready():
	handle_power(false)


func handle_power(powered: bool):
	# If powered and inverse_power, turn off
	# If powered and not inverse_power, turn on
	
	if powered:
		if inverse_power:
			turn_off()
		else:
			turn_on()
	else:
		if inverse_power:
			turn_on()
		else:
			turn_off()


func turn_on():
	pass


func turn_off():
	pass
