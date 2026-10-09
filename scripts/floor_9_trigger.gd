extends Area3D


@export var elevator_doors:Node3D

func _on_body_entered(body):
	if body.is_in_group("player"):
		if elevator_doors and elevator_doors.has_method("close_and_lock"):
			elevator_doors.close_and_lock()
		if body.has_method("show_message"):
			body.show_message("The power died. The elevator is dead.")
		queue_free()
		
	
