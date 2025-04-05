extends Node2D

var music_started = false

func _ready():
	if Global.door_name:
		var door_node = find_child(Global.door_name)
		if door_node:
			$Emily.global_position = door_node.global_position
			
	if not Global.radio_interacted:
		if not music_started:
			MusicControllerLivingroom.play_music()
			music_started = true

	MusicController.play_music()
