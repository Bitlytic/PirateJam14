class_name LightProbe
extends Node2D

@export_flags_2d_physics var raycast_mask := 0b10100000
@export_flags_2d_physics var core_mask := 0b10000000

@export var disable_probing := false
@export var draw_debug := false

var sprite : Sprite2D

var _lights : Array

func _ready():
	_lights = get_tree().get_nodes_in_group("lights")
	sprite = $Sprite2D


func is_in_light() -> bool:
	if disable_probing:
		return false
	
	if sprite:
		sprite.visible = draw_debug
	
	_lights = get_tree().get_nodes_in_group("lights")
	
	var lights = []
	var dist : float = 0.0
	
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(), raycast_mask)
	query.collide_with_areas = true
	query.hit_from_inside = true
	
	for light: PointLight2D in _lights:
		dist = (global_position - light.global_position).length()
		
		if dist > (light.texture.get_size().x / 2.0) * light.texture_scale:
			# Light out of range, shouldn't even check
			continue
		
		if light is CoreLight:
			query.collision_mask = core_mask
		else:
			query.collision_mask = raycast_mask
		
		query.to = light.global_position
		
		var result = space_state.intersect_ray(query)

		if result.is_empty():
			lights.append(light)
	
	if sprite:
		sprite.modulate.r = 0 if lights.is_empty() else 1
	
	return !lights.is_empty()
