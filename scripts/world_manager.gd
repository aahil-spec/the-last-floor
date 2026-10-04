extends Node3D


@export var all_floors:Array[Node3D]

func _ready():
	if all_floors.size()>0:
		activate_floor(all_floors[0])
		
func activate_floor(target_floor:Node3D):
	var floor_index=all_floors.find(target_floor)
	if floor_index==-1:
		return
	var batch_start=(floor_index/3)*3
	var batch_end=batch_start+2
	for i in range (all_floors.size()):
		if i >=batch_start and i <= batch_end:
			all_floors[i].visible=true
		else:
			all_floors[i].visible=false
