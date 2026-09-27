extends Area3D

@export var elevator_root:Node3D
@export var elevator_door:AnimatableBody3D
@export var floor_5_target_height:float=0.0

var has_triggered:bool=false
func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if has_triggered:
		return
		
	if body.name=="Player":
		if body.max_unlocked_floor>=5:
			has_triggered=true
			body.show_message("System Override. Travelling to an unknown floor...")
			if elevator_door and not elevator_door.is_door_closed:
				elevator_door.close_door()
				await get_tree().create_timer(0.5).timeout
			if elevator_door:
				elevator_door.is_moving=true
			if elevator_root:
				var tween=create_tween()
				tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
				tween.tween_property(elevator_root,"global_position:y",floor_5_target_height,5.0)
				await tween.finished
			if elevator_door:
				elevator_door.is_moving=false
				elevator_door.open_door()
