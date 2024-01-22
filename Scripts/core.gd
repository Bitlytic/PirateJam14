extends Interactable

@export var enable_breathing := false

@export var breathing_curve : Curve
@export var breathing_time := 2.0

var current_lifetime := 0.0
var light : PointLight2D
var starting_scale

func _ready():
	light = $"Core Light"
	starting_scale = light.texture_scale

func _process(delta):
	if !enable_breathing:
		light.texture_scale = starting_scale
		return
	
	current_lifetime += delta
	
	if current_lifetime > breathing_time:
		current_lifetime = 0.0
	
	var brightness = breathing_curve.sample(current_lifetime / breathing_time)
	
	light.texture_scale = starting_scale * brightness
