extends Interactable

@export var prompt_text:String="Press E to read note"

@export_multiline var note_content:String="Use the elevator.\n\nDo not use the stairs after midnight."

func interact(player_node):
	if player_node.has_method("show_note"):
		player_node.show_note(note_content)
