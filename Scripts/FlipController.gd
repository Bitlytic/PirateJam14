extends Node2D

@export var nodes_to_flip : Array[Node2D] = []

var original_positions : Array[Vector2] = []

func _ready():
	for i in nodes_to_flip.size():
		var node = nodes_to_flip[i]
		original_positions.append(node.position)


func face_right():
	for i in nodes_to_flip.size():
		var node = nodes_to_flip[i]
		if node is Sprite2D:
			node.scale.x = 1
			continue
		node.position = original_positions[i]


func face_left():
	for i in nodes_to_flip.size():
		var node = nodes_to_flip[i]
		if node is Sprite2D:
			node.scale.x = -1
			continue
		node.position = original_positions[i]
		node.position.x *= -1
