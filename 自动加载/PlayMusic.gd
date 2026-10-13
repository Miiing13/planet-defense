extends Node

var BackgroundMusic=load("res://游戏资源/音乐/Big Eyes.mp3")

func _ready():
	var AudioPlayer=AudioStreamPlayer.new()
	add_child(AudioPlayer)
	AudioPlayer.stream=BackgroundMusic
	AudioPlayer.bus="Music"
	AudioPlayer.stream.loop=true
	AudioPlayer.play()
