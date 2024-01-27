extends Node2D

@export var visibility : VisibilityComponent

var happy_music : AudioStreamMP3 = preload("res://Music/Lightfarer-Ambience-Happy-Trim.mp3")
var sad_music : AudioStreamMP3 = preload("res://Music/Lightfarer-Ambience-Sad-Trim.mp3")

var background_music : AudioStreamMP3 = preload("res://Music/Lightfarer-Ambience-Trim.mp3")

var sad_stream : AudioStreamPlayer
var happy_stream : AudioStreamPlayer


var background_stream : AudioStreamPlayer

var last_happy := false

func _ready():
	sad_stream = AudioStreamPlayer.new()
	sad_stream.stream = sad_music
	sad_stream.volume_db = 0.0
	sad_stream.bus = "Music"
	
	add_child(sad_stream)
	
	
	happy_stream = AudioStreamPlayer.new()
	happy_stream.stream = happy_music
	happy_stream.volume_db = -30.0
	happy_stream.bus = "Music"
	
	add_child(happy_stream)
	
	
	background_stream = AudioStreamPlayer.new()
	background_stream.stream = background_music
	background_stream.bus = "Music"
	
	add_child(background_stream)
	
	stop_playing()


func start_playing():
	sad_stream.play()
	happy_stream.play()
	background_stream.play()
	
	process_mode = Node.PROCESS_MODE_ALWAYS

	pass

func stop_playing():
	sad_stream.stop()
	happy_stream.stop()
	background_stream.stop()
	
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	if !visibility || !is_instance_valid(visibility):
		visibility = get_tree().get_first_node_in_group("visibility")
	
	if !visibility:
		return
	
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
