extends Node2D

func _on_interactable_focused(interactor):
	pass

func _on_interactable_interacted(interactor):
	MusicControllerBathroom.play_music()
	pass
	
func _on_interactable_unfocused(interactor):
	pass
	
	
