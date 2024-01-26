class_name PlayerCamera
extends Camera2D

@export var target : Node2D

@export var follow : bool = true

var target_position: set = set_target_position

var current_tween : Tween

var real_position := Vector2()

func _ready():
	add_to_group("player_camera")
	real_position = global_position


func _physics_process(_delta):
	if !follow:
		return
	
	real_position = real_position.lerp(target.global_position, 0.25)
	
	self.global_position = real_position


func set_target_position(new_pos):
	if new_pos == target_position:
		return
		
	target_position = new_pos
	
	if current_tween:
		current_tween.stop()
	
	current_tween = create_tween()
	current_tween.finished.connect(on_tween_finished)
	
	current_tween.set_ease(Tween.EASE_IN_OUT)
	current_tween.set_trans(Tween.TRANS_SINE)
	
	current_tween.tween_property(self, "global_position", target_position, 0.75)
	

func on_tween_finished():
	current_tween = null
