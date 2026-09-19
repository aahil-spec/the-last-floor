extends Node3D

@export var screen_notifier:VisibleOnScreenNotifier3D

@export var new_position:Vector3
@export var new_rotation:Vector3

var anomaly_armed:bool=false
var has_been_seen:bool=false
var has_moved:bool=false

@warning_ignore("unused_parameter")
func _process(delta):
	if anomaly_armed and not has_moved:
		if screen_notifier.is_on_screen():
			has_been_seen=true
		if has_been_seen and not screen_notifier.is_on_screen():
			position=new_position
			rotation_degrees=new_rotation
			has_moved=true
