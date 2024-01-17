class_name FlippableShape
extends CollisionShape2D

@export var left_position : Vector2

@export var right_position : Vector2

func _ready():
	if !left_position:
		left_position = global_position
	if !right_position:
		right_position = global_position


func face_right():
	position = right_position


func face_left():
	position = left_position
