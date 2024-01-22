class_name InteractionHandler
extends Node2D

var current_interactables : Array[Interactable] = []


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if !current_interactables.is_empty():
			var interactable = current_interactables[0]
			if interactable:
				interactable.interact()


func on_area_enter(area: Area2D):
	var owner := area.owner
	
	if !(owner is Interactable):
		return
	
	if current_interactables.has(owner):
		return
	
	owner.highlight()
	current_interactables.append(owner)


func on_area_exit(area: Area2D):
	var owner := area.owner
	
	if !(owner is Interactable):
		return
	
	if !current_interactables.has(owner):
		return
	
	owner.unhighlight()
	current_interactables.erase(owner)
	
	
