extends Interactable
@export var prompt_text: String = "Press E to read Dairy"
@export_multiline var dairy_entry: String = "Write your lore here..."
func interact(player_node):
		if player_node.has_method("show_note"):
				player_node.show_note(dairy_entry)
