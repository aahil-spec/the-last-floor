extends Interactable

@export var prompt_text:String="Press E to Pick up Key"
@export var pickup_message:String="Acquired a small rusty key"
@export var unlocks_elevator_floor:int=0
@export var connected_door:Interactable
@export var auto_open_door:bool=false
@onready var pickup_sound = $PickupSound
var is_picked_up = false
func interact(player_node):
	if player_node.has_method("show_message"):
		player_node.show_message(pickup_message)
	if unlocks_elevator_floor>0:
		if player_node.max_unlocked_floor<unlocks_elevator_floor:
			player_node.max_unlocked_floor=unlocks_elevator_floor
	if connected_door:
		if "is_locked" in connected_door:
			connected_door.is_locked=false
		if auto_open_door and "is_open" in connected_door:
			if not connected_door.is_open:
				connected_door.interact(player_node)
	visible = false
	if  pickup_sound != null:
			pickup_sound.play()
			await pickup_sound.finished
	queue_free()
	
