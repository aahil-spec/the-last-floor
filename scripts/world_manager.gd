extends Node3D


@export var all_floors:Array[Node3D]

func _ready():
	if all_floors.size()>0:
		activate_floor(all_floors[0])
		
func activate_floor(target_floor:Node3D):
	for f in all_floors:
		if f ==target_floor:
			f.visible=true
			f.process_mode=Node.PROCESS_MODE_INHERIT
		else:
			f.visible=false
			f.process_mode=Node.PROCESS_MODE_DISABLED
