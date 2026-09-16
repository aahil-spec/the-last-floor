extends Interactable


@export var connected_ui:CanvasLayer

@warning_ignore("unused_parameter")
func interact(player_node):
	if connected_ui:
		connected_ui.visible=true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
