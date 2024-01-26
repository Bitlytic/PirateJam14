extends Contraption


@export var rotation_amount := 90.0

var _probes_holder : Node
var beam_center : Node2D
var beam_light : BeamLightContraption

var probes : Array[LightProbe]

@onready var starting_rotation : float = global_rotation

func _ready():
	_probes_holder = $Probes
	beam_center = $BeamCenter
	beam_light = $BeamCenter/BeamLight
	
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


func _physics_process(_delta):
	#debug_test(delta)
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

func turn_on():
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "global_rotation", starting_rotation + deg_to_rad(rotation_amount), 1.0)


func turn_off():
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "global_rotation", starting_rotation, 1.0)
