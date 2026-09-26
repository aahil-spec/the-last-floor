extends Interactable

var is_open=false
var door_tween:Tween

@export var requires_flashlight:bool=false
@export var prompt_text: String = "Press E to open"

@warning_ignore("unused_parameter")
func interact(player_node):
	if requires_flashlight and not is_open:
		if player_node.has_flashlight==false:
			prompt_text = "Cant go Inside yet."
			if player_node.has_method("show_nessage"):
				player_node.show_message("Cant go Inside yet.")
			return
	is_open=!is_open
	
	if is_open:
		prompt_text=""
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	
	if is_open:
		door_tween.tween_property(self,"rotation:y",deg_to_rad(90),0.5)
		
	else:
		door_tween.tween_property(self,"rotation:y",0.0,0.5)
