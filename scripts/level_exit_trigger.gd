extends Area3D


var is_loading:bool=false


func _on_body_entered(body):
	if is_loading:
		return
	if body.has_method("level_transition"):
		is_loading=true
		print("DEBUG: Player touched the door trigger!") 
		body.level_transition("res://scenes/floor_10.tscn")
		
