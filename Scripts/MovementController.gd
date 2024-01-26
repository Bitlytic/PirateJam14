extends Node2D

@export var jump_velocity = -180.0
@export var speed = 100.0
@export var climb_gravity := 0.5
@export var fall_gravity := 1.0
@export var hang_gravity := 0.3
@export var hang_threshold := 40.0

@export var acceleration_frames := 10
@export var deceleration_frames := 5

@export var coyote_frames := 5
@export var jump_buffer_size := 6

@export var debug_fly := false

var player : Player
var velocity : Vector2
var is_on_floor : bool

var jump_buffer := 0
var aerial_frames := 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dead := false

var player_input : PlayerInput


func _ready():
	player = get_parent()
	player.player_died.connect(on_player_died)


func on_player_died():
	dead = true


func handle_aerial(delta):
	var gravity_multiplier := fall_gravity
	
	if velocity.y < 0:
		if !player_input.jump_held:
			velocity.y *= 0.25
		gravity_multiplier = climb_gravity
	else:
		if abs(velocity.y) < hang_threshold && player_input.jump_held:
			gravity_multiplier = hang_gravity
	
	velocity.y += gravity * gravity_multiplier * delta
	
	aerial_frames += 1


func poll_input():
	if !dead:
		player_input = PlayerInputHandler.get_player_input()
	else:
		player_input = PlayerInput.new()


func _physics_process(delta):
	poll_input()
	
	if debug_fly:
		handle_fly(delta)
		return
	
	velocity = player.velocity
	
	is_on_floor = player.is_on_floor()
	
	if !is_on_floor:
		handle_aerial(delta)
	else:
		aerial_frames = 0
	
	if player_input.jump_pressed:
		jump_buffer = jump_buffer_size
	elif jump_buffer > 0:
		jump_buffer -= 1
	
	if jump_buffer:
		if player_input.directional_input.y > 0 && is_on_floor:
			player.global_position.y += 1
			velocity.y += gravity*delta
			jump_buffer = 0
		elif (is_on_floor || aerial_frames < coyote_frames):
			velocity.y = jump_velocity
			jump_buffer = 0
			aerial_frames = coyote_frames
	
	var direction = player_input.directional_input.x
	var target_speed = direction * speed
	
	if !dead && sign(target_speed) && sign(target_speed) != sign(velocity.x):
		velocity.x *= 0.9
	
	if direction:
		velocity.x = move_toward(velocity.x, target_speed, speed / float(acceleration_frames))
	else:
		var frames = deceleration_frames
		if dead:
			frames = deceleration_frames * 5
		velocity.x = move_toward(velocity.x, 0, speed / float(frames))
	
	player.velocity = velocity


func handle_fly(delta):
	var direction = player_input.directional_input
	
	var speed = 10000.0
	
	if Input.is_action_pressed("move_sprint"):
		speed *= 2.0
	
	elif Input.is_action_pressed("move_crouch"):
		speed *= 0.5
	
	player.velocity = direction * speed * delta
