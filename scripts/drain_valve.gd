extends Interactable

@export var prompt_text:String="Press E to turn drainage valve"

@export var water_mesh:MeshInstance3D
@export var water_trigger:Area3D
@export var connected_elevator_door:AnimatableBody3D
@export var rotation_spped:float=3.0

var hold_time:float=0.0
var max_hold_time:float=10.0
var start_y:float=4.364
var is_drained:bool=false

func _ready():
	if water_mesh:
		start_y=water_mesh.position.y
func interact(player_node):
	if not is_drained:
		if player_node.has_method("show_message"):
			player_node.show_message("Turning the valve... it's heavy.")
func hold_interact(delta,player_node):
	if is_drained:
		return
	hold_time += delta
	var progress=hold_time/max_hold_time
	prompt_text="Turning Valve:"+str(int(progress*100))+"%"
	rotation.x+=rotation_spped*delta
	if water_mesh:
		water_mesh.position.y=start_y-(1.5*progress)
	if hold_time>=max_hold_time:
		finish_draining(player_node)
func finish_draining(player_node):
	is_drained=true
	prompt_text="Valve fully open."
	if water_trigger:
		water_trigger.queue_free()
	player_node.is_in_water=false
	player_node.walk_speed=3.0
	if player_node.has_method("show_message"):
		player_node.show_message("The water drained. The elevator should open now.")
	if connected_elevator_door and connected_elevator_door.has_method("open_door"):
		connected_elevator_door.open_door()
	if player_node.camera:
		var tween=create_tween()
		tween.tween_property(player_node.camera,"fov",75.0,4.0)
