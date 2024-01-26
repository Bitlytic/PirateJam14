extends HBoxContainer


@export var option_text := "Music Volume"

@export var option_name := "music_volume"

@export var min_text := "0"
@export var max_text := "1"
@export var min_amount := 0.0
@export var max_amount := 1.0


@onready var value_edit := $VBoxContainer/HBoxContainer/ValueEdit
@onready var value_slider := $VBoxContainer/ValueSlider

@onready var min_label := $VBoxContainer/HBoxContainer/MinimumLabel
@onready var max_label := $VBoxContainer/HBoxContainer/MaximumLabel

@onready var option_label := $OptionLabel


var current_value := 0.0

func _ready():
	current_value = GameSettings.get(option_name)
	
	value_edit.text = str(current_value)
	value_slider.set_value_no_signal(current_value)
	
	min_label.text = min_text
	max_label.text = max_text
	
	value_slider.min_value = min_amount
	value_slider.max_value = max_amount
	
	option_label.text = option_text


func on_value_changed(value):
	if value is String:
		
		if value.is_valid_float():
			value = float(value)
		else:
			value = current_value
	
	value = clamp(value, min_amount, max_amount)
	
	current_value = value
	
	value_edit.text = str(current_value)
	GameSettings.set(option_name, current_value)
	
	value_slider.set_value_no_signal(current_value)
	value_edit.text = str(current_value)
	value_edit.release_focus()
