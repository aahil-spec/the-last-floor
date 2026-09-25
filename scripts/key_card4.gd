extends Interactable

@export var prompt_text:String="Press E to pick up Security Keycard"
@export var floor_to_unlock:int=2
func interact(player_node):
	player_node.max_unlocked_floor=floor_to_unlock
	player_node.has_keycard=true
	if player_node.has_method("show_message"):
		player_node.show_message("Floor " + str(floor_to_unlock) + " Elevator Access Granted")
	get_tree().call_group("washing_machines","turn_on_anomaly")
	queue_free()
