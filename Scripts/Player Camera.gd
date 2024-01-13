extends Camera2D

@export var target : Node2D

var real_position := Vector2()

func _ready():
	if !target:
		push_error(self, " did not have a target!")
		queue_free()
	real_position = global_position


func _physics_process(delta):
	real_position = real_position.lerp(target.global_position, 0.25)
	
	self.global_position = real_position
