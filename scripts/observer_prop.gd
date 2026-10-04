extends Interactable

@export var prompt_text:String="Press E to turn away"
var is_watching:bool=true

@export var turn_degrees:float=180.0
func interact(player_node):
	if not is_watching:
		return
	is_watching=false
	prompt_text=""
	if player_node.has_method("show_message"):
		player_node.show_message("It feels safer with it facing the wall...")
	var target_rotation=rotation.y+deg_to_rad(turn_degrees)
	var tween=create_tween()
	tween.tween_property(self,"rotation:y",target_rotation,0.5)
