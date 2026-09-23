extends Interactable

@export var prompt_text:String="Press E to pick up Key"
@export var anomlay_clown:StaticBody3D

func interact(player_node):
	player_node.max_unlocked_floor=4
	if player_node.has_method("show_message"):
		player_node.show_message("Floor 4 Elevator Access Granted")
		
	if anomlay_clown and anomlay_clown.has_method("spring_trap"):
		anomlay_clown.spring_trap()
	queue_free()
