extends Node2D

func _on_interactable_focused(interactor):
	$Interactable/InteractUI.show()

func _on_interactable_interacted(interactor):
	MusicControllerLivingroom.stop_music()
	$Interactable/InteractUI.hide()
	$Interactable/InteractUI2.show()
	Global.radio_interacted = true
	print("True")

func _on_interactable_unfocused(interactor):
	$Interactable/InteractUI.hide()
	$Interactable/InteractUI2.hide()
