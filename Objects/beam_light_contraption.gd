class_name BeamLightContraption
extends Contraption

var light : CommonLight

func _ready():
	light = $Light
	light.enabled = false


func turn_on():
	print("Turning on!")
	light.enabled = true


func turn_off():
	print("Turning off!")
	light.enabled = false
