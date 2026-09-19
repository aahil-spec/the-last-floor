extends AnimatableBody3D


@export var closed_y_position:float=1.512

@onready var open_y_position:float=position.y
var is_door_closed=false

var is_moving:bool=false
func close_door():
	if is_moving:return
	if not is_door_closed:
		is_door_closed=true
		var tween=create_tween()
		tween.tween_property(self,"position:y",closed_y_position,0.5)
		
func open_door():
	if is_moving:return
	if is_door_closed:
		is_door_closed=false
		var tween=create_tween()
		tween.tween_property(self,"position:y",open_y_position,0.5)
	
