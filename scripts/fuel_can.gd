extends Interactable

@export var prompt_text:String="Press E to pick up Fuel"

func interact(player_node):
	if "fuel_count" in player_node:
		player_node.fuel_count+=1
	if player_node.has_method("show_message"):
		player_node.show_message("Picked up Fuel Can.(" + str(player_node.fuel_count) + "/3)")
	queue_free()
