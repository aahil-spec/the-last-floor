extends Interactable

@export var connected_light:Light3D
@export var maintenance_door:AnimatableBody3D
var power_restored=false
@export var prompt_text:String="Press E to restore lights"

@warning_ignore("unused_parameter")
func interact(player_node):
	if not power_restored:
		power_restored=true
		prompt_text="Power restored"
		if connected_light:
			connected_light.visible=true
		if maintenance_door:
			maintenance_door.unlock_door()
		player_node.max_unlocked_floor=3
