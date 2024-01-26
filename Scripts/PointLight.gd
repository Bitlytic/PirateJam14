@tool
extends Contraption

@export var powered := true

@export var light_scale : Vector2 = Vector2.ONE
@export var uniform_scale : bool = true

var light : CommonLight


func _ready():
	light = $PointLight2D
	light.scale = light_scale
	
	handle_power(powered)


func _process(delta):
	if Engine.is_editor_hint():
		if !light:
			light = $PointLight2D
			
		light_scale.y = light_scale.x
		light.scale = light_scale
		light.enabled = powered

func turn_off():
	$AnimationPlayer.play("turn_off_sputter", -1, 0.75)

func turn_on():
	$AnimationPlayer.play("turn_on")
