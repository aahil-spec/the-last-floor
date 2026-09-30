extends Interactable


@export var prompt_text:String="Press E to unlock cell"
@export var slide_up_distance:float=3.5
@export var requires_key:bool=true

var is_open:bool=false
var door_tween:Tween

func interact(player_node):
	if is_open:
		return
	if requires_key:
		if player_node.has_cell_key==false:
			prompt_text="Locked (Requires Cell Key)"
			if player_node.has_method("show_message"):
				player_node.show_message("It's locked tight. I need the cell key.")
			return
	is_open=true
	prompt_text=""
	if player_node.has_method("show_message"):
		player_node.show_message("Cell unlocked.")
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	var target_y=self.position.y+slide_up_distance
	door_tween.tween_property(self,"position:y",target_y,1.5).set_trans(Tween.TRANS_SINE)
