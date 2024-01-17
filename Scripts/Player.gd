class_name Player
extends CharacterBody2D

@export var visibility : VisibilityComponent


func _process(delta):
	visibility.is_in_light()


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
