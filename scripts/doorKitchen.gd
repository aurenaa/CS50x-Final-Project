extends Area2D

@export_global_file("*.tscn", "*.scn") var target_scene
	
func _process(delta):
	Global.door_name = name
	
func _input(event):
	if event.is_action_pressed("interact"):
		if !target_scene:
			print("No Scene")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()
			
func next_level():
	var ERR = get_tree().change_scene_to_file(target_scene)
	
	if ERR != OK:
		print("Error in door scene")
