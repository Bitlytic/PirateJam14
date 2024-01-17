extends Node2D

@export var test_light : Light2D
@export_flags_2d_physics var collision_mask : int

func _process(delta):
	var space_state := get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(global_position, test_light.global_position, collision_mask)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
