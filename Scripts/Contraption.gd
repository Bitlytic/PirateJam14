class_name Contraption
extends Node2D

@export var inverse_power := false
@export var required_power := 1

var last_power_count

var power_sources := []


func _ready():
	update_powered()
	
	if inverse_power:
		handle_power(false)


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
	var power_count = power_sources.size()
	
	var was_powered_last = false
	if last_power_count:
		was_powered_last = last_power_count >= required_power
	var powered_now = power_count >= required_power
	
	if was_powered_last != powered_now:
		last_power_count = power_sources.size()
		handle_power(last_power_count >= required_power)


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
