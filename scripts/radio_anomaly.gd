extends Node3D


@export var radio_audio:AudioStreamPlayer3D
var has_triggered:bool=false

func turn_on():
	if not has_triggered:
		has_triggered=true
		if radio_audio:
			radio_audio.play()
