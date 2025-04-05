extends Node2D

func _on_interactable_focused(interactor):
	$Interactable/InteractUI.hide()

func _on_interactable_interacted(interactor):
	CatController.play_music()
	
func _on_interactable_unfocused(interactor):
	$Interactable/InteractUI.hide()
