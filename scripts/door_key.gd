extends Interactable

@export var prompt_text:String="Press E to Pick up Key"

@export var connected_door:Interactable
@onready var pickup_sound = $PickupSound
var is_picked_up = false
func interact(player_node):
	if is_picked_up == true:
			return
	is_picked_up =  true
	player_node.max_unlocked_floor=3
	if player_node.has_method("show_message"):
		player_node.show_message("Floor 3 Elevator Access Granted")
	if connected_door and not connected_door.is_open:
		connected_door.interact(player_node)
	visible = false
	if pickup_sound != null:
			pickup_sound.play()
			await pickup_sound.finished
	queue_free()
