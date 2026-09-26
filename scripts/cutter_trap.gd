extends Interactable
@export var blade_node:Node3D
@export var flashlight_node:Node3D
@export var physical_button_mesh:Node3D
@export var prompt_text:String="Hold E to brake the cutter"

var is_braking:bool=false
var hold_progress:float=0.0
var required_time:float=8.0
var is_finished:bool=false
var current_speed:float=15.0
var blade_start_pos:Vector3
var flash_start_pos:Vector3
var button_start_pos:Vector3

func _ready():
	if blade_node and flashlight_node:
		blade_start_pos=blade_node.position
		flash_start_pos=flashlight_node.position
	if physical_button_mesh:
		button_start_pos=physical_button_mesh.position
	if flashlight_node and flashlight_node.has_node("SpotLight3D"):
		flashlight_node.get_node("SpotLight3D").visible=false
		
func _process(delta):
	if is_finished:
		return
	if blade_node:
		blade_node.rotate_y(current_speed*delta)
	if is_braking:
		if Input.is_physical_key_pressed(KEY_E) or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			hold_progress+=delta
			current_speed=lerp(15.0,0.0,hold_progress/required_time)
			if hold_progress>=required_time:
				finish_puzzle()
		else:
			is_braking=false
			hold_progress=0.0
			current_speed=15.0
			prompt_text="Hold E to brake the cutter"
			if physical_button_mesh:
				var pop_tween=create_tween()
				pop_tween.tween_property(physical_button_mesh,"position",button_start_pos,0.1)
@warning_ignore("unused_parameter")
func interact(player_node):
	if is_finished or is_braking:
		return
	is_braking=true
	prompt_text="Keep holding E! Don't let go!"
	if physical_button_mesh:
		var push_tween=create_tween()
		var pressed_pos=button_start_pos+Vector3(0,-3.0,0)
		push_tween.tween_property(physical_button_mesh,"position",pressed_pos,0.1)
	
func finish_puzzle():
	is_finished=true
	current_speed=0.0
	prompt_text=""
	if flashlight_node and flashlight_node.has_node("SpotLight3D"):
		flashlight_node.get_node("SpotLight3D").visible=true
	if blade_node and flashlight_node:
		var tween=create_tween().set_parallel(true)
		tween.tween_property(flashlight_node,"position",blade_start_pos,2.0).set_trans(Tween.TRANS_SINE)
		tween.tween_property(blade_node, "position", flash_start_pos, 2.0).set_trans(Tween.TRANS_SINE)
		tween.chain().tween_callback(unlock_flashlight)
func unlock_flashlight():
	if flashlight_node and flashlight_node.has_node("CollisionShape3D"):
		flashlight_node.get_node("CollisionShape3D").disabled=false
		
