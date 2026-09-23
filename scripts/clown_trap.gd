extends StaticBody3D


@export var clown_audio:AudioStreamPlayer
@export var footstep_audio:AudioStreamPlayer
@export var dramatic_audio:AudioStreamPlayer
var trap_sprung:bool=false

func _ready():
	visible=false
	$CollisionShape3D.disabled=true
	
func spring_trap():
	if not trap_sprung:
		trap_sprung=true
		visible=true
		$CollisionShape3D.disabled=false
		if clown_audio:
			clown_audio.play()
		if footstep_audio:
			footstep_audio.play()
		if dramatic_audio:
			dramatic_audio.play()
