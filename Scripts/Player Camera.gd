extends Camera2D

@export var target : Node2D

@export var follow : bool = true

var real_position := Vector2()

func _ready():
	if !target:
		push_error(self, " did not have a target!")
		queue_free()
	real_position = global_position


func _physics_process(delta):
	if !follow:
		return
	
	real_position = real_position.lerp(target.global_position, 0.25)
	
	self.global_position = real_position
