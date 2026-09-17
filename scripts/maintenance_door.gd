extends Interactable

@export var prompt_text:String="Locked - Requires Power"
var is_locked:bool=true
var is_open:bool=false

@warning_ignore("unused_parameter")
func interact(player_node):
	if is_locked:
		return
	if not is_open:
		is_open=true
		prompt_text=""
		var tween=create_tween()
		tween.tween_property(self,"position:y",position.y+2.5,1.0)
		
func unlock_door():
	is_locked=false
	prompt_text="Press E to open Maintenance Door"
