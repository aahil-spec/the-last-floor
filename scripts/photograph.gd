extends Interactable

@export var prompt_text:String="Press E to look at Photo"

@export var photo_texture:Texture2D
@onready var photo_sound = $PhotoSound
func interact(player_node):
	if photo_sound != null:
			photo_sound.play()
	if player_node.has_method("show_photo") and photo_texture:
			player_node.show_photo(photo_texture)
