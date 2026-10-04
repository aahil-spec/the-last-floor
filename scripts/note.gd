extends Interactable

@export var prompt_text:String="Press E to read note"

@export_multiline var note_content:String="Use the elevator.\n\nDo not use the stairs after midnight."
@onready  var paper_sound = $PaperSound
func interact(player_node):
	if paper_sound != null:
			paper_sound.play()
	if player_node.has_method("show_note"):
			player_node.show_note(note_content)
