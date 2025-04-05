extends Node2D

func _on_interactable_focused(interactor):
	pass # Replace with function body.


func _on_interactable_interacted(interactor):
	$Interactable/InteractUI.hide()

func _on_interactable_unfocused(interactor):
	pass # Replace with function body.
