extends Node2D

signal socket_powered

@export var contraptions : Array[Contraption]


var powered_buffer_size := 5
var powered_buffer := 0
var powered := false
var core_colliding := false


func _ready():
	turn_off_contraptions()


func on_core_enter(_body: RigidBody2D):
	core_colliding = true
	powered_buffer = powered_buffer_size
	if !powered:
		turn_on_contraptions()


func on_core_leave(_body: RigidBody2D):
	core_colliding = false


func _physics_process(_delta):
	if !core_colliding && powered_buffer > 0:
		powered_buffer -= 1
		
		if powered_buffer <= 0:
			turn_off_contraptions()
		
	elif core_colliding:
		powered_buffer = powered_buffer_size


func power_contraptions():
	for c in contraptions:
		if c:
			if powered:
				c.add_source(self)
			else:
				c.remove_source(self)


func turn_on_contraptions():
	powered = true
	power_contraptions()
	socket_powered.emit()


func turn_off_contraptions():
	powered = false
	power_contraptions()
