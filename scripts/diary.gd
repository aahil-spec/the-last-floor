extends Interactable

@export var prompt_text:String="Read Diary"


func interact(player_node):
	if player_node.has_method("show_diary"):
		player_node.show_diary()
