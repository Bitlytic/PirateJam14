extends Control

@onready var retry_button := $RetryButton


func _ready():
	var player = get_tree().get_first_node_in_group("player")
	player.player_died.connect(on_player_died)


func on_player_died():
	show()


func on_visibility_changed():
	if visible:
		retry_button.grab_focus()


func on_retry_pressed():
	get_tree().reload_current_scene()
	hide()
