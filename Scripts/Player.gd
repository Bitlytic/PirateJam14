class_name Player
extends CharacterBody2D

@export var visibility : VisibilityComponent

var max_health := 1.0
@onready var health := max_health


func _process(delta):
	if !visibility.is_in_light():
		health -= delta
		if health <= 0:
			pass
	else:
		health = max_health


func _physics_process(delta):
	
	handle_flip_visuals()
	
	move_and_slide()


func handle_flip_visuals():
	if velocity.x > 0:
		$Sprite.flip_h = false
		$FlipController.face_right()
	elif velocity.x < 0:
		$Sprite.flip_h = true
		$FlipController.face_left()
