extends Node2D

@onready var anim_player := $AnimationPlayer


func _ready():
	$ColorRect.visible = true
	anim_player.animation_finished.connect(on_anim_finished)
	anim_player.play("fade_in")

func on_anim_finished(anim_name):
	if anim_name == "fade_in":
		queue_free()
