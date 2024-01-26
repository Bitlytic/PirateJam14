class_name InteractionHandler
extends Node2D

@export var interaction_shape : CollisionShape2D
@export_flags_2d_physics var interaction_mask : int

var current_interactables : Array[Interactable] = []

var shape_query : PhysicsShapeQueryParameters2D

func _ready():
	shape_query = PhysicsShapeQueryParameters2D.new()
	
	shape_query.shape = interaction_shape.shape
	shape_query.collide_with_areas = true
	shape_query.collide_with_bodies = false
	shape_query.collision_mask = interaction_mask
	shape_query.transform = interaction_shape.global_transform


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if !current_interactables.is_empty():
			var interactable = current_interactables[0]
			if interactable:
				interactable.interact()


func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	
	shape_query.transform = interaction_shape.global_transform
	
	for i in current_interactables:
		i.unhighlight()
	
	current_interactables.clear()
	
	var results = space_state.intersect_shape(shape_query)
	for r in results:
		var collider = r.get("collider")
		var interactable : Interactable = collider.get_owner()
		current_interactables.append(interactable)
		interactable.highlight()

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

