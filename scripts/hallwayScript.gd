extends Node2D

func _ready():
	if Global.door_name:
		var door_node = find_child(Global.door_name)
		if door_node:
			$Emily.global_position = door_node.global_position
			
	MusicController.play_music()
