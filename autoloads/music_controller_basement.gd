extends Node

var menu_music = load("res://audio/basement.mp3")
var mute = false

func _ready():
	pass
	
func play_music():
	if mute:
		return
		
	if $music.stream == menu_music and $music.playing:
		return
	
	$music.stream = menu_music
	$music.play()
	
func stop_music():
	$music.stop()
