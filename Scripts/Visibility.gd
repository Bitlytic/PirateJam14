class_name VisibilityComponent
extends Node


var _probes : Array[LightProbe]

func _ready():
	for child in get_children():
		if child is LightProbe:
			_probes.append(child)


func is_in_light() -> bool:
	
	var result := false
	
	for probe: LightProbe in _probes:
		if probe.is_in_light():
			result = true
			#break
	
	return result
