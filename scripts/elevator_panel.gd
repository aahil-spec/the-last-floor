extends Interactable


@export var connected_ui:CanvasLayer

@warning_ignore("unused_parameter")
func interact(player_node):
	connected_ui.open_ui()
