extends Area2D

@export var target_scene: PackedScene

func _input(event):
	if event.is_action_pressed("interact"):
		if !target_scene:
			print("No Scene")
			return
		if get_overlapping_bodies().size() > 0:
			if Global.flashlight_interacted:
				next_level()
			else:
				$InteractUI/flashlightDark.show()
			
func next_level():
	var ERR = get_tree().change_scene_to_file("res://scenes/hallway.tscn")
	
	if ERR != OK:
		print("Error in door scene")
		
func _process(delta):
	Global.door_name = name
