extends MeshInstance3D


@export var player_node:Node3D
@warning_ignore("unused_parameter")
func _process(delta):
	if player_node:
		var mat=get_active_material(0) as ShaderMaterial
		if mat:
			mat.set_shader_parameter("player_pos",player_node.global_position)
