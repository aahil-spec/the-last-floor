extends CanvasLayer

@onready var panel_art=$PanelArt
@onready var lobby_btn=$PanelArt/LobbyBtn
@onready var floor2_btn=$PanelArt/Floor2Btn
@onready var close_btn=$PanelArt/CloseBtn

func _ready():
	lobby_btn.pressed.connect(go_to_lobby)
	floor2_btn.pressed.connect(go_to_floor_2)
	close_btn.pressed.connect(close_ui)
	panel_art.modulate.a=0.0
	
func open_ui():
	visible=true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var tween=create_tween()
	tween.tween_property(panel_art,"modulate:a",1.0,0.3)
	
func go_to_lobby():
	close_ui()
	ElevatorManager.change_floor("lobby")
	
func go_to_floor_2():
	close_ui()
	ElevatorManager.change_floor("floor_2")
	
func close_ui():
	var tween=create_tween()
	tween.tween_property(panel_art,"modulate:a",0.0,0.2)
	await tween.finished
	visible=false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
