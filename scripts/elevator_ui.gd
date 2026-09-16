extends CanvasLayer

func _ready():
	var lobby_btn=$ColorRect/VBoxContainer/Button
	var floor2_btn=$ColorRect/VBoxContainer/Button2
	
	lobby_btn.pressed.connect(go_to_lobby)
	floor2_btn.pressed.connect(go_to_floor_2)
	
func go_to_lobby():
	close_ui()
	ElevatorManager.change_floor("lobby")
	
func go_to_floor_2():
	close_ui()
	ElevatorManager.change_floor("floor_2")
	
func close_ui():
	visible=false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
