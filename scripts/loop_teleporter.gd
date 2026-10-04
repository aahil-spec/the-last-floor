extends Area3D


@export var start_marker:Marker3D
@export var observers:Array[Interactable]
@export var exit_door:Interactable

func _on_body_entered(body):
	if body.name=="Player":
		var someone_is_watching=false
		for prop in observers:
			if prop.is_watching:
				someone_is_watching=true
				break
		if someone_is_watching:
			body.global_position=start_marker.global_position
			if body.has_method("show_message"):
				body.show_message("I'm back at the start... Did they do this?")
		else:
			if body.has_method("show_message"):
				body.show_message("The air feels different. The loop is broken.")
			if exit_door:
				exit_door.is_locked=false
			queue_free()
