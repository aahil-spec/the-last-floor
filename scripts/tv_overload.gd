extends Interactable

@export var prompt_text:String="Hold E to tune frequency"
@export var dial_mesh:Node3D
@export var tv_screen_mesh:Node3D
@export var locked_keycard:Node3D
@export var static_audio:AudioStreamPlayer3D
@export var shatter_audio:AudioStreamPlayer3D

var is_tuning:bool=false
var hold_progress:float=0.0
var required_time:float=10.0
var is_finished:bool=false
var tv_start_pos:Vector3

func _ready():
	if tv_screen_mesh:
		tv_start_pos=tv_screen_mesh.position
		
func _process(delta):
	if is_finished:
		return
	if is_tuning:
		if Input.is_physical_key_pressed(KEY_E) or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			hold_progress+=delta
			if dial_mesh:
				dial_mesh.rotate_z(3.0*delta)
			if static_audio:
				static_audio.pitch_scale=1.0+(hold_progress*0.15)
			if tv_screen_mesh and hold_progress>5.0:
				var shake=randf_range(-0.03,0.03)
				tv_screen_mesh.position=tv_start_pos+Vector3(shake,shake,0)
			if hold_progress>=required_time:
				overload_tv()
		else:
			is_tuning=false
			hold_progress=0.0
			prompt_text="Hold E to tune frequency"
			if static_audio:
				static_audio.pitch_scale=1.0
				static_audio.stop()
			if tv_screen_mesh:
				tv_screen_mesh.position=tv_start_pos
@warning_ignore("unused_parameter")
func interact(player_node):
	if is_finished or is_tuning:
		return
	is_tuning=true
	prompt_text="Keep holding E! It's getting clearer..."
	if static_audio:
		static_audio.play()
		
func overload_tv():
	is_finished=true
	prompt_text=""
	if static_audio:
		shatter_audio.stop()
		static_audio.queue_free()
	if shatter_audio:
		shatter_audio.play()
	if tv_screen_mesh:
		tv_screen_mesh.visible=false
	if locked_keycard:
		locked_keycard.visible=true
		if locked_keycard.has_node("CollisionShape3D"):
			locked_keycard.get_node("CollisionShape3D").disabled=false
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled=true
