extends Interactable

var is_open=false
var door_tween:Tween

@warning_ignore("unused_parameter")
func interact(player_node):
	is_open=!is_open
	
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	
	if is_open:
		door_tween.tween_property(self,"rotation:y",deg_to_rad(90),0.5)
		
	else:
		door_tween.tween_property(self,"rotation:y",0.0,0.5)
