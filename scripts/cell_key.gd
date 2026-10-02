extends Interactable

@export var prompt_text:String="Press E to pick up Cell Key"

func interact(player_node):
	player_node.has_cell_key=true
	if player_node.has_method("show_message"):
		player_node.show_message("Acquired: Security Cell Key.")
	queue_free()
