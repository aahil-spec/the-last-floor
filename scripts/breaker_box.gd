extends Interactable

@export var connected_light:Light3D
var power_restored=false

@warning_ignore("unused_parameter")
func interact(player_node):
	if not power_restored:
		power_restored=true
		print("Breaker flipped! Power restored.")
		if connected_light:
			connected_light.visible=true
	else:
		print("The power is already on.")
