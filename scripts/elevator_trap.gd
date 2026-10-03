extends Area3D



@export var elevator_door:AnimatableBody3D
var has_triggered:bool=false

func _on_body_entered(body):
	if body.name=="Player" and not has_triggered:
		has_triggered=true
		if elevator_door and elevator_door.has_method("close_door"):
			elevator_door.close_door()
		if body.has_method("show_message"):
			body.show_message("The door slammed shut. The water short-circuited the system.")
