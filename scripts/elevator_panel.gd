extends Interactable


@export var connected_ui:CanvasLayer

var is_moving:bool=false
@warning_ignore("unused_parameter")
func interact(player_node):
	connected_ui.open_ui()
