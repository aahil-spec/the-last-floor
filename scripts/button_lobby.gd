extends Interactable

@export var prompt_text:String="Press E to use elevator"
@export var target_floor:String="lobby"

@export var target_height:float=0.0
@export var elevator_door:AnimatableBody3D

@export var elevator_root:Node3D
@warning_ignore("unused_parameter")
func interact(player_node):
	if elevator_door and not elevator_door.is_door_closed:
		return
	var tween=create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(elevator_root,"global_position:y",target_height,5.0)
	await tween.finished
