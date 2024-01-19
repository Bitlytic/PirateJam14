extends CommonLight
class_name LightBeam2D

func _ready():
	add_to_group("lights")
	
	var space_state := get_world_2d().direct_space_state
	
	var query := PhysicsPointQueryParameters2D()
	
	space_state.intersect_point()
