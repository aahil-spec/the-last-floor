extends Interactable

@export var prompt_text:String="Press E to pick up flashlight"

func interact(player_node):
	player_node.has_flashlight=true
	player_node.flashlight.visible=true
	var light_beam=player_node.flashlight.get_node_or_null("SpotLight3D")
	if light_beam:
		light_beam.visible=false
	queue_free()
