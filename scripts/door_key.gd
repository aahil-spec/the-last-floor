extends Interactable

@export var prompt_text:String="Press E to Pick up Key"

@export var connected_door:Interactable

func interact(player_node):
	player_node.max_unlocked_floor=3
	if player_node.has_method("show_message"):
		player_node.show_message("Floor 3 Elevator Access Granted")
	if connected_door and not connected_door.is_open:
		connected_door.interact(player_node)
	queue_free()
