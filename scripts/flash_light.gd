extends Interactable

@export var prompt_text:String="Press E to pick up flashlight"
@onready var pickup_sound = $PickupSound
var is_picked_up = false
func interact(player_node):
	if  is_picked_up == true:
			return
	is_picked_up = true
	player_node.has_flashlight=true
	player_node.flashlight.visible=true
	var light_beam=player_node.flashlight.get_node_or_null("SpotLight3D")
	if light_beam:
		light_beam.visible=false
	visible = false
	if pickup_sound != null:
			pickup_sound.play()
			await pickup_sound.finished
	queue_free()
