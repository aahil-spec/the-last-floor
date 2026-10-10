extends Interactable
@export var prompt_text:String="Press E to pick up Fuse"
@onready var pickup_sound = $PickupSound
var is_picked_up = false

func interact(player_node):
	if is_picked_up == true:
			return
	is_picked_up = true
	player_node.has_fuse=true
	if player_node.has_method("show_message"):
		player_node.show_message("Picked up the Fuse.")
	visible = false
	if pickup_sound != null:
			pickup_sound.play()
			await pickup_sound.finished
	queue_free()
