extends Interactable

@export var prompt_text:String="Press E to pick up Security Keycard"

func interact(player_node):
	player_node.has_keycard=true
	queue_free()
