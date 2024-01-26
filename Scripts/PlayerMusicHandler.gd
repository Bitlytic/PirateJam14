extends AudioStreamPlayer

@export var visibility : VisibilityComponent

@export var happy_track : AudioStream
@export var sad_track : AudioStream

func _ready():
	stream = happy_track
	play()

func _process(delta):
	pass
