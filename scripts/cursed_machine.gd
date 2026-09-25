extends Node3D


@export var anim_player:AnimationPlayer
@export var machine_aduio:AudioStreamPlayer3D

var is_possessed:bool=false

func _ready():
	anim_player=find_child("AnimationPlayer",true,false)
	machine_aduio=find_child("AudioStreamPlayer3D",true,false)
	if machine_aduio:
		machine_aduio.stop()
		
func turn_on_anomaly():
	if is_possessed:return
	is_possessed=true
	if anim_player:
		anim_player.play("Animation")
	if machine_aduio:
		machine_aduio.play()
	var tween=create_tween().set_loops()
	var origin_pos=position
	tween.tween_property(self,"position:x",origin_pos.x+0.05,0.03)
	tween.tween_property(self,"position:y",origin_pos.y+0.05,0.03)
	tween.tween_property(self,"position:x",origin_pos.x-0.05,0.03)
	tween.tween_property(self,"position:y",origin_pos.y-0.05,0.03)
	tween.tween_property(self,"position",origin_pos,0.03)
