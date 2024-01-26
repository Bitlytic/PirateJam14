class_name Contraption
extends Node2D

@export var inverse_power := false
@export var required_power := 1

var last_power_state : bool

var power_sources := []


func _ready():
	update_powered()


func add_source(source):
	if power_sources.has(source):
		return
	
	power_sources.append(source)
	
	update_powered()


func remove_source(source):
	if !power_sources.has(source):
		return
	
	power_sources.erase(source)
	
	update_powered()


func update_powered():
	var power_state = power_sources.size() >= required_power
	
	if power_state != last_power_state:
		last_power_state = power_state
		handle_power(power_state)


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
