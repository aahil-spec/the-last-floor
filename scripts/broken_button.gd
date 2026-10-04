extends Interactable

@export var prompt_text:String="Press E to select floor"
@export var broken_message:String="The button is dead. It won't let me go down."

func interact(player_node):
	if player_node.has_method("show_message"):
		player_node.show_message(broken_message)
