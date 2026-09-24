extends Interactable

@export var prompt_text:String="Press E to open"
var is_open:bool=false
@onready var hinge=get_parent()

@warning_ignore("unused_parameter")
func interact(player_node):
	if is_open:
		return
	is_open=true
	prompt_text=""
	$CollisionShape3D.disabled=true
	
	var tween=create_tween()
	tween.tween_property(hinge,"rotation_degrees:y",90.0,0.5)
