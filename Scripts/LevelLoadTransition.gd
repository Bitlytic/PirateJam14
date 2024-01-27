extends Node2D

@onready var anim_player := $AnimationPlayer

var player : Node2D


func _ready():
	$ColorRect.visible = true
	anim_player.animation_finished.connect(on_anim_finished)
	anim_player.play("fade_in")


func _process(_delta):
	if !player:
		player = get_tree().get_first_node_in_group("player")
	
	if !player:
		return
	
	global_position = player.global_position


func on_anim_finished(anim_name):
	if anim_name == "fade_in":
		queue_free()
