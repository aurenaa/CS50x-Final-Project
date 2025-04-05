extends CharacterBody2D

@export var speed: int = 75
@onready var animations = $AnimationPlayer
@onready var footsteps_audio = $Footsteps
var isWalking = false

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()

func Emily():
	pass
	

func handleInput():
	var moveDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moveDirection*speed
	
	if moveDirection.length() > 0:
		isWalking = true
	else:
		isWalking = false

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
		elif footsteps_audio.is_playing():
			footsteps_audio.stop()
		
	else:
		var direction = "down"
		if velocity.x < 0: 
			direction = "left"
		elif velocity.x > 0: 
			direction = "right"
		elif velocity.y < 0: 
			direction = "up"
	
		animations.play("emily_" + direction)
		
	if isWalking && !footsteps_audio.is_playing():
		footsteps_audio.play()
