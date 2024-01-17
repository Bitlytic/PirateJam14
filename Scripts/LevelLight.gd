extends DirectionalLight2D

@export var disable := false

func _ready():
	visible = !disable
