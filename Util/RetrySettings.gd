extends Node

var checkpoint : Vector2
var camera_target : Vector2


var valid := false


func reset():
	valid = false
	checkpoint = Vector2()
	camera_target = Vector2()
