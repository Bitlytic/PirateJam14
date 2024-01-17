extends Node2D

@export var jump_velocity = -180.0
@export var speed = 100.0
@export var climb_gravity := 0.5
@export var fall_gravity := 1.0
@export var hang_gravity := 0.5
@export var hang_threshold := 20.0

@export var acceleration_frames := 10
@export var deceleration_frames := 5

@export var debug_fly := false

var player : Player
var velocity : Vector2
var is_on_floor : bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	player = get_parent()


func handle_aerial(delta):
	var gravity_multiplier := fall_gravity
	
	if velocity.y < 0:
		if !Input.is_action_pressed("move_jump"):
			velocity.y *= 0.5
		gravity_multiplier = climb_gravity
	else:
		if abs(velocity.y) < hang_threshold && Input.is_action_pressed("move_jump"):
			gravity_multiplier = hang_gravity
	
	velocity.y += gravity * gravity_multiplier * delta


func _physics_process(delta):
	if debug_fly:
		handle_fly(delta)
		return
	
	velocity = player.velocity
	
	is_on_floor = player.is_on_floor()
	
	if !is_on_floor:
		handle_aerial(delta)
	
	if Input.is_action_just_pressed("move_jump") and is_on_floor:
		velocity.y = jump_velocity
	
	var direction = Input.get_axis("move_left", "move_right")
	var target_speed = direction * speed
	
	if sign(target_speed) && sign(target_speed) != sign(velocity.x):
		velocity.x *= 0.9
	
	if direction:
		velocity.x = move_toward(velocity.x, target_speed, speed / float(acceleration_frames))
	else:
		velocity.x = move_toward(velocity.x, 0, speed / float(deceleration_frames))
	
	player.velocity = velocity


func handle_fly(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var speed = 10000.0
	
	if Input.is_action_pressed("move_sprint"):
		speed *= 2.0
	
	elif Input.is_action_pressed("move_crouch"):
		speed *= 0.5
	
	player.velocity = direction * speed * delta
