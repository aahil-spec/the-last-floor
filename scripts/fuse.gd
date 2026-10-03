extends Interactable
@export var prompt_text:String="Press E to pick up Fuse"



func interact(player_node):
	player_node.has_fuse=true
	if player_node.has_method("show_message"):
		player_node.show_message("Picked up the Fuse.")
	queue_free()
