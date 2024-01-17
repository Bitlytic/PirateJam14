class_name LightMap
extends Node2D

@export var size := Vector2(64, 64)
@export var cell_size := Vector2(16, 16)
@export var probes_per_cell := 4
@export_flags_2d_physics var raycast_mask : int = 0

var _map := {}


func _ready():
	prepare_map()


func prepare_map():
	_map.clear()
	
	
	update_map()


func update_map():
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(Vector2(), Vector2(), raycast_mask)
	query.collide_with_areas = true
	
	var result : Dictionary = {}
	
	var lights = get_tree().get_nodes_in_group("lights")
	
	var light : PointLight2D
	
	for y in range(size.y):
		for x in range(size.x):
			var vals = []
			for p in probes_per_cell:
				vals.append(false)
			_map[y * size.x + x] = vals
	
	for y in range(size.y):
		for x in range(size.x):
			for i in range(lights):
				light = lights[i]
				var pos := Vector2(x, y)
				pos.x *= cell_size.x
				pos.y *= cell_size.y
				
				if !within_range(light, pos):
					continue
				
				query.from = pos
				query.to = light.global_position
				
				result = space_state.intersect_ray(query)
				
				if result.is_empty():
					_map[y * size.x + x] = [true]


func within_range(light: PointLight2D, pos: Vector2):
	return pos.distance_to(light.global_position) < light.texture_scale * light.texture.get_size().x
