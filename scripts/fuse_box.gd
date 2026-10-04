extends Interactable

@export var prompt_text:String="Press E to inspect Fuse Box"
@export var lights_parent:Node3D
@export var secret_wall_hole:CSGBox3D
var power_restored:bool=false

func interact(player_node):
	if power_restored:
		return
	if player_node.has_fuse:
		power_restored=true
		player_node.has_fuse=false
		prompt_text="Power is online."
		if player_node.has_method("show_message"):
			player_node.show_message("The fuse fit. The power is back online!")
		if lights_parent:
			lights_parent.visible=true
		if secret_wall_hole:
			secret_wall_hole.visible=true
	else:
		if player_node.has_method("show_message"):
			player_node.show_message("The main fuse is missing. I need to find a replacement. ")
