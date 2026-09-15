extends Node


var floors={
	"lobby":"res://scenes/lobby.tscn",
	"floor_2":"res://scenes/floor2.tscn"
}
var current_floor="lobby"

func change_floor(floor_name:String):
	if floors.has(floor_name):
		print("Elevator descending/ascending to: ", floor_name)
		get_tree().change_scene_to_file(floors[floor_name])
		current_floor=floor_name
	else:
		print("Anomaly: Elevator refused the floor request.")
