extends PointLight2D
class_name CommonLight

func _ready():
	add_to_group("lights")
	color = Color.hex(0xdef0ffff)
