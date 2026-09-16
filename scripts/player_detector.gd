extends Area3D


@onready var door=$"../ElevatorDoor"
var is_door_closed=false

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.name=="Player" and not is_door_closed:
		is_door_closed=true
		var tween=create_tween()
		tween.tween_property(door,"position:y",1.512,0.15).set_trans(Tween.TRANS_BOUNCE)
