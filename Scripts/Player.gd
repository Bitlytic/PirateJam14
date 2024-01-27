class_name Player
extends CharacterBody2D

signal player_died

@export var visibility : VisibilityComponent

var death_anim_length := 1.0

var max_health := 0.3
var health : float

var sprite : Sprite2D

var starting_light

@onready var body_controller : AnimationPlayer = $AnimationPlayer

@onready var face_controller : AnimationPlayer = $FaceController

@onready var anim_tree : AnimationTree = $AnimationTree

@onready var debounce_timer : Timer = $DeathDebounceTimer

var last_facing_direction := "right"

func _ready():
	if has_node("RobotSprite"):
		sprite = $RobotSprite
	starting_light = $ScreenLight.energy
	max_health = max_health + death_anim_length
	health = max_health
	#face_controller.play("idle")
	anim_tree.set("parameters/conditions/idle", true)
	
	debounce_timer.timeout.connect(on_debounce_finish)

func _process(delta):
	if !visibility.is_in_light():
		if health > 0:
			health -= delta
			if health <= death_anim_length:
				#face_controller.play("die")
				anim_tree.set("parameters/conditions/die", true)
				pass
		else:
			player_died.emit()
	else:
		if !debounce_timer.is_stopped():
			debounce_timer.stop()
		health = max_health
		anim_tree.set("parameters/conditions/die", false)
	var anim = "idle"
	
	if velocity:
		if velocity.x > 0:
			last_facing_direction = "right"
		elif velocity.x < 0:
			last_facing_direction = "left"
		
		var motion_type = "run"
		
		if velocity.y:
			motion_type = "jump"
			if velocity.y > 0:
				motion_type += "_fall"
		
		anim = motion_type + "_" + last_facing_direction
		
	body_controller.play(anim)
	
	$ScreenLight.energy = health / max_health * starting_light


func _physics_process(_delta):
	
	handle_flip_visuals()
	
	move_and_slide()


func on_debounce_finish():
	player_died.emit()


func handle_flip_visuals():
	if velocity.x > 0:
		sprite.flip_h = false
		$FlipController.face_right()
	elif velocity.x < 0:
		sprite.flip_h = true
		$FlipController.face_left()
