extends Interactable

@export var prompt_text:String="Press E to use elevator"
@export var target_floor:String="lobby"

@export var target_height:float=0.0
@export var elevator_door:AnimatableBody3D

@export var elevator_root:Node3D

@export var floor_number:int=2
var is_moving:bool=false
@warning_ignore("unused_parameter")
func interact(player_node):
	if not player_node.has_keycard:
		player_node.show_message("Access Denied: Security Keycard Required")
		return
	if floor_number>player_node.max_unlocked_floor:
		player_node.show_message("Error:Floor"+str(floor_number)+"is locked.")
	if player_node.has_method("show_message"):
		player_node.show_message("Safety Lock: Elevator is in motion")
		return
	if elevator_door and not elevator_door.is_door_closed:
		player_node.show_message("Safety Lock: Close the doors first")
		return
	player_node.show_message("Access Granted:Traveling...")
	if elevator_door:
		elevator_door.is_moving=true
	var tween=create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(elevator_root,"global_position:y",target_height,5.0)
	await tween.finished
	if elevator_door:
		elevator_door.is_moving=false
