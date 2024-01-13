extends CharacterBody2D


@export var jump_velocity = -100.0
@export var speed = 100.0
@export var climb_gravity := 0.5
@export var fall_gravity := 1.0

@export var acceleration_frames := 20
@export var deceleration_frames := 10

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_aerial(delta):
	if velocity.y < 0:
		if !Input.is_action_pressed("move_jump"):
			velocity.y *= 0.9
		velocity.y += gravity * climb_gravity * delta
	else:
		velocity.y += gravity * fall_gravity * delta

func _physics_process(delta):
	if not is_on_floor():
		handle_aerial(delta)
	
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var direction = Input.get_axis("move_left", "move_right")
	var target_speed = direction * speed
	
	if sign(target_speed) && sign(target_speed) != sign(velocity.x):
		velocity.x *= 0.9
	
	if direction:
		velocity.x = move_toward(velocity.x, target_speed, speed / float(acceleration_frames))
	else:
		velocity.x = move_toward(velocity.x, 0, speed / float(deceleration_frames))
	
	move_and_slide()
