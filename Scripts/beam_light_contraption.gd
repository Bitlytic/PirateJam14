class_name BeamLightContraption
extends Contraption

var light : CommonLight

var light_energy := 0.0



func _ready():
	light = $Light
	light_energy = light.energy
	handle_power(false)


func turn_on():
	light.enabled = true
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(light, "color:a", light_energy, 0.05)


func turn_off():
	var callback = func():
		light.enabled = false
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(light, "color:a", 0.5, 0.05).finished.connect(callback)
