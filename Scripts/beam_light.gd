class_name BeamLight
extends CommonLight

@export var light_shape : CollisionShape2D


func is_shape(shape: CollisionShape2D) -> bool:
	return shape == light_shape
