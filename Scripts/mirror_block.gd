extends Node2D


@export var _probes_holder : Node
@export var beam_center : Node2D
@export var beam_light : BeamLightContraption

var probes : Array[LightProbe]


func _ready():
	for c in _probes_holder.get_children():
		if c is LightProbe:
			probes.append(c)


func debug_test(delta):
	if Input.is_action_pressed("ui_left"):
		global_position.x -= 20 * delta
	elif Input.is_action_pressed("ui_right"):
		global_position.x += 20 * delta
	 
	if Input.is_action_pressed("ui_up"):
		global_position.y -= 20 * delta
	elif Input.is_action_pressed("ui_down"):
		global_position.y += 20 * delta
	
	if Input.is_action_pressed("ui_page_up"):
		global_rotation -= deg_to_rad(90*delta)
	elif Input.is_action_pressed("ui_page_down"):
		global_rotation += deg_to_rad(90*delta)


func _physics_process(delta):
	debug_test(delta)
	var probes_in_light : Array[LightProbe] = []
	for probe in probes:
		if probe.is_in_light():
			probes_in_light.append(probe)
	
	# If no probes or only one are hit
	if probes_in_light.size() <= 1:
		beam_light.handle_power(false)
		return
	beam_light.handle_power(true)

	var first_probe = probes_in_light[0]
	var last_probe = probes_in_light[probes_in_light.size()-1]
	
	var center = last_probe.global_position + first_probe.global_position
	center /= 2.0
	beam_center.global_position = center

	var diff = first_probe.global_position - last_probe.global_position
	
	# Max diff is ~17 for now
	# At max, beam should be 0.55 scale
	
	beam_light.scale.y = (diff.length() / 17.0) * 0.55

