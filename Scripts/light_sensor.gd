extends Actuator

var power_state := false
var light_probes : Array[LightProbe] = []

func _ready():
	for p in $Probes.get_children():
		if p is LightProbe:
			light_probes.append(p)


func _physics_process(delta):
	var valid = false
	
	for p in light_probes:
		if p.is_in_light():
			valid = true
			break
	
	if valid == power_state:
		return
	
	power_state = valid
	
	if valid:
		activate()
		print("Activated!")
	else:
		deactivate()
		print("Deactivated!")

func activate():
	activate_all()
	$AnimationPlayer.play("activate")
	

func deactivate():
	deactivate_all()
	$AnimationPlayer.play("deactivate")
