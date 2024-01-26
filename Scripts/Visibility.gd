class_name VisibilityComponent
extends Node


var _probes : Array[LightProbe]

var is_in_core_light := false

func _ready():
	for child in get_children():
		if child is LightProbe:
			_probes.append(child)


func is_in_light() -> bool:
	
	var result := false
	
	is_in_core_light = false
	
	for probe: LightProbe in _probes:
		if probe.is_in_light():
			result = true
		if probe.is_in_core_light():
			is_in_core_light = true
			#break
	
	return result
