class_name LightProbe
extends Node2D

@export_flags_2d_physics var raycast_mask := 0b10100000
@export_flags_2d_physics var core_mask := 0b10000000
@export_flags_2d_physics var beam_mask := 0b00010000

@export var disable_probing := false
@export var draw_debug := false
@export var debug_probe := false

var sprite : Sprite2D

var _lights : Array

func _ready():
	_lights = get_tree().get_nodes_in_group("lights")
	sprite = $Sprite2D


func is_in_light() -> bool:
	if !is_instance_valid(self):
		return false
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
	
	var point_query := PhysicsPointQueryParameters2D.new()
	
	point_query.position = global_position
	point_query.collide_with_areas = true
	point_query.collide_with_bodies = false
	
	point_query.collision_mask = beam_mask
	
	var beam_results = space_state.intersect_point(point_query)
	
	for light: PointLight2D in _lights:
		if !light.enabled:
			continue
		
		# Beam lights use area to check bounds, maybe others should too?
		# Point lights have now been added to this, other should definitely do this.
		if light is AreaLight:
			var valid := false
			for beam in beam_results:
				var l = beam['collider'].get_parent()
				
				if l == light:
					valid = true
					break
			
			if !valid:
				continue
			
		else:
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


func _process(delta):
	if debug_probe:
		is_in_light()
