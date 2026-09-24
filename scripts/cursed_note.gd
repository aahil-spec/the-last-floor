extends Interactable

@export var prompt_text:String="Press E to read note"
@export var spooky_radio:Node3D
@export_multiline var note_content:String="Use the elevator.\n\nDo not use the stairs after midnight."

func interact(player_node):
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled=true
	if player_node.has_method("show_note"):
		player_node.show_note(note_content)
	if spooky_radio and spooky_radio.has_method("turn_on"):
		await get_tree().create_timer(1.5).timeout
		spooky_radio.turn_on()
