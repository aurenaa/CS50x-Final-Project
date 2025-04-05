extends Control

func _ready():
	MusicControllerBasement.play_music()
	
func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menues/mainmenu.tscn")
	MusicControllerBasement.stop_music()
	hide()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

