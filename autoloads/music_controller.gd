extends Node

var background_music = load("res://audio/thunderstorm.mp3")
var mute = false

func _ready():
	pass
	
func play_music():
	if mute:
		return
		
	if $music.stream == background_music and $music.playing:
		return
	
	$music.stream = background_music
	$music.play()
