extends Interactable

@export var monitor_camera:Camera3D
@export var cctv_locations:Array[Node3D]
@export var prompt_text:String="Press E to switch CCTV (CAM 1)"
var current_cam_index:int=0

func _ready():
	if cctv_locations.size()>0 and monitor_camera:
		monitor_camera.global_transform=cctv_locations[0].global_transform
		
@warning_ignore("unused_parameter")
func interact(player_node):
	if cctv_locations.size()==0 or not monitor_camera:
		return
	current_cam_index+=1
	if current_cam_index>=cctv_locations.size():
		current_cam_index=0
	monitor_camera.global_transform=cctv_locations[current_cam_index].global_transform
	prompt_text="Press E to switch CCTV (CAM " + str(current_cam_index+1)+ ")"
