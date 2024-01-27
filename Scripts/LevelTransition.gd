extends Area2D


@export var level : PackedScene

@onready var anim_player := $AnimationPlayer


func _ready():
	anim_player.animation_finished.connect(on_anim_finish)


func on_body_entered(body):
	if body is Player:
		$AnimationPlayer.play("fade_out")


func on_anim_finish(anim_name):
	if anim_name == "fade_out":
		RetrySettings.valid = false
		get_tree().change_scene_to_packed(level)
