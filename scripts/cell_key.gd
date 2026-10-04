extends Interactable

@export var prompt_text:String="Press E to pick up Cell Key"
var is_picked_up = false
func interact(player_node):
	if is_picked_up == true:
			return
	is_picked_up = true
	player_node.has_cell_key=true
	if player_node.has_method("show_message"):
			player_node.show_message("Acquired: Security Cell Key.")
	visible = false
	queue_free()
