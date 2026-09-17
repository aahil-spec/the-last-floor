extends Interactable

@export var prompt_text:String="Press E to open Fire Exit"

@export var locked_message:String="The stairwell is barricaded from the other side."

func interact(player_node):
	if player_node.has_method("show_message"):
		player_node.show_message(locked_message)
