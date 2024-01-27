extends Node

var music_volume := 0.5 : set = on_music_volume_changed
var sound_volume := 0.5 : set = on_sound_volume_changed

var fullscreen_mode := 0 : set = on_fullscreen_mode_changed

var fullscreen_modes := [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN,
	DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
]

func _ready():
	on_music_volume_changed(music_volume)


func on_music_volume_changed(val):
	music_volume = val
	
	var bus_idx := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(val))

func on_sound_volume_changed(val):
	sound_volume = val
	
	var bus_idx := AudioServer.get_bus_index("Sound")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(val))


func on_fullscreen_mode_changed(val):
	fullscreen_mode = val
	DisplayServer.window_set_mode(fullscreen_modes[fullscreen_mode])
