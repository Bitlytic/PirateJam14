extends Node

var music_volume := 0.5 : set = on_music_volume_changed
var sound_volume := 0.5 : set = on_sound_volume_changed

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
