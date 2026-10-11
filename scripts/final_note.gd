extends Interactable


@export var prompt_text:String="Read Note"
@export var note_content:String="It is time to wake up."
@export var resident:CharacterBody3D

var has_been_read:bool=false

func interact(player_node):
	if has_been_read:
		return
	player_node.show_note(note_content)
	has_been_read=true
	if resident:
		resident.wait_for_note_close()
