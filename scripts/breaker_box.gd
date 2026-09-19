extends Interactable

@export var connected_light:Light3D
@export var maintenance_door:AnimatableBody3D
var power_restored=false
@export var prompt_text:String="Press E to restore lights"

@export var scare_audio:AudioStreamPlayer3D
@export var creepy_prop:Node3D

@warning_ignore("unused_parameter")
func interact(player_node):
	if not power_restored:
		power_restored=true
		prompt_text="Power restored"
		if connected_light:
			connected_light.visible=true
		if maintenance_door:
			maintenance_door.unlock_door()
		if scare_audio:
			scare_audio.play()
		if creepy_prop:
			creepy_prop.anomaly_armed=true
