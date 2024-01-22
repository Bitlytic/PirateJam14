class_name Interactable
extends Node2D

@export var sprite : Sprite2D

func interact():
	pass


func highlight():
	if sprite:
		sprite.material.set("shader_param/width", 1)


func unhighlight():
	if sprite:
		sprite.material.set("shader_param/width", 0)