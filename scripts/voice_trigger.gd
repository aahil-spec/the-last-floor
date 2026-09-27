extends Area3D


@export var voice_audio:AudioStreamPlayer3D
var has_triggered:bool=false

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if has_triggered:
		return
	if body.name=="Player":
		has_triggered=true
		if voice_audio:
			voice_audio.play()
