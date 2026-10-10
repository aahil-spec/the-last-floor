extends Interactable

var is_open=false
var door_tween:Tween

@export var is_locked:bool=false
@export var requires_key:bool=false
@onready var open_sound = $OpenSound
@onready var close_sound = $CloseSound
@warning_ignore("unused_parameter")
func interact(player_node):
	if is_locked:
		if requires_key:
			if player_node.has_method("show_message"):
				player_node.show_message("It's locked. I need to find the key.")
		else:
			if player_node.has_method("show_message"):
				player_node.show_message("It's locked from the other side.")
		return
	is_open=!is_open
	
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	
	if is_open:
		if open_sound != null:
				open_sound.play()
		door_tween.tween_property(self,"rotation:y",deg_to_rad(90),0.5)
		
	else:
		if close_sound != null:
				close_sound.play()
		door_tween.tween_property(self,"rotation:y",0.0,0.5)
