extends Interactable

@export var prompt_text:String="Read Diary"
@export_multiline var story_text:String=""

func interact(player_node):
	if player_node.has_method("show_note"):
		player_node.show_note(story_text)
