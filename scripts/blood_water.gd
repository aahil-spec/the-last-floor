extends Interactable

@export var prompt_text:String="Press E to inspect bathtub"
@export var water_mesh:MeshInstance3D
@export var heartbeat_audio:AudioStreamPlayer3D
@export var blood_color:Color=Color(0.3,0.0,0.0)
@export var shader_color_name:String="shader_parameter/water_color"

var has_triggered:bool=false

func interact(player_node):
	if has_triggered:
		return
	has_triggered=true
	prompt_text=""
	if player_node.has_method("show_message"):
		player_node.show_message("Something is wrong...")
	if heartbeat_audio:
		heartbeat_audio.play()
	start_hallucination(player_node)
	
func start_hallucination(player_node):
	var material=water_mesh.get_surface_override_material(0)
	var tween=create_tween().set_parallel(true)
	if material:
		tween.tween_property(material,shader_color_name,blood_color,6.0)
	if heartbeat_audio:
		tween.tween_property(heartbeat_audio,"volume_db",0.0,6.0)
	if player_node.camera:
		tween.tween_property(player_node.camera,"fov",110.0,6.0)
	tween.chain().tween_callback(finish_halluciantion.bind(player_node))

func finish_halluciantion(player_node):
	if player_node.has_method("show_message"):
		player_node.show_message("Get out of my head.")
