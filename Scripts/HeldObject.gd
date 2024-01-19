extends Node2D

@export var held_object : RigidBody2D

@export var object_collision : CollisionShape2D

var pickup_target : Node2D

func _ready():
	if held_object:
		hold_object(held_object)

func _process(delta):
	if Input.is_action_just_pressed("drop"):
		
		if held_object != null:
			drop_object()
		elif pickup_target != null:
			hold_object(pickup_target)
			pickup_target = null


func hold_object(node: RigidBody2D):
	held_object = node
	
	held_object.global_position = global_position
	held_object.reparent(self)
	
	held_object.process_mode = Node.PROCESS_MODE_DISABLED
	held_object.freeze = true
	
	#object_collision.disabled = true


func drop_object():
	if !held_object:
		push_error("Dropping object when it doesn't exist!")
		return
	held_object.process_mode = Node.PROCESS_MODE_INHERIT
	held_object.freeze = false
	held_object.reparent(get_tree().root)
	
	held_object = null
	
	#object_collision.disabled = true


func _on_pickup_range_body_entered(body):
	pickup_target = body


func _on_pickup_range_body_exited(body):
	if body == pickup_target:
		pickup_target = null