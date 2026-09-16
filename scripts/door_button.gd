extends Interactable

@export var prompt_text:String="Press E to use door"

@export_enum("open","close") var action:String="close"
@export var elevator_door:AnimatableBody3D

@warning_ignore("unused_parameter")
func interact(player_node):
	if elevator_door:
		if action=="close":
			elevator_door.close_door()
		elif action=="open":
			elevator_door.open_door()
