extends Area3D


@export var start_marker:Marker3D
@export var observers:Array[Interactable]
@export var exit_door:Interactable
@export var warning_note:Interactable
@export var hallway_lights:Array[OmniLight3D]

var loop_count:int=0
var scary_messages=[
	"They won't let you leave if they can see you.",
	"I SAID TURN THEM AWAY",
	"WHY AREN'T YOU LISTENING?",
	"DON'T LOOK AT THEM... MAKE THEM SINK."
]
func _on_body_entered(body):
	if body.name=="Player":
		var someone_is_watching=false
		for prop in observers:
			if prop.is_watching:
				someone_is_watching=true
				break
		if someone_is_watching:
			loop_count+=1
			if warning_note:
				var msg_index=min(loop_count,scary_messages.size()-1)
				if "note_text" in warning_note: warning_note.note_text=scary_messages[msg_index]
				elif "content" in warning_note: warning_note.content=scary_messages[msg_index]
			if hallway_lights.size()>0:
				var light_to_kill=hallway_lights.pop_front()
				if light_to_kill:
					light_to_kill.visible=false
			body.global_position=start_marker.global_position
			if body.has_method("show_message"):
				body.show_message("I'm back at the start... Did they do this?")
		else:
			if body.has_method("show_message"):
				body.show_message("The air feels different. The loop is broken.")
			if exit_door:
				exit_door.is_locked=false
			queue_free()
