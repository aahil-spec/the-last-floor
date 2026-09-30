extends Area3D


@export var monster_animator:AnimationPlayer
@export var door_bang_audio:AudioStreamPlayer3D
@export var prophecy_delay:float=5.0

var has_triggered:bool=false

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if has_triggered:
		return
	if body.name=="Player":
		has_triggered=true
		if monster_animator:
			monster_animator.play("approach_door")
		await get_tree().create_timer(prophecy_delay).timeout
		if door_bang_audio:
			door_bang_audio.play()
		if body.has_method("show_message"):
			body.show_message("...It's right outside.")
