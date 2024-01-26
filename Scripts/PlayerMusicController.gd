extends Node2D

@export var visibility : VisibilityComponent

@export var sad_stream : AudioStreamPlayer
@export var happy_stream : AudioStreamPlayer


var last_happy := false


func _process(delta):
	var is_happy := visibility.is_in_core_light
	
	if is_happy != last_happy:
		last_happy = is_happy
		update_stream(is_happy)
	


func update_stream(is_happy):
	var quiet_stream
	var regular_stream
	
	if is_happy:
		regular_stream = happy_stream
		quiet_stream = sad_stream
	else:
		regular_stream = sad_stream
		quiet_stream = happy_stream
	
	var quiet_tween = create_tween()
	quiet_tween.set_ease(Tween.EASE_IN)
	quiet_tween.set_trans(Tween.TRANS_EXPO)
	quiet_tween.tween_property(quiet_stream, "volume_db", -30, 0.25)
	
	var regular_tween = create_tween()
	regular_tween.set_ease(Tween.EASE_OUT)
	regular_tween.set_trans(Tween.TRANS_EXPO)
	regular_tween.tween_property(regular_stream, "volume_db", 0, 0.25)
