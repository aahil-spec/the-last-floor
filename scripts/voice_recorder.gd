extends Interactable

@export var prompt_text:String="Press E to play Recording"
@export var voice_audio:AudioStream
@export_multiline var subtitle:String="Alex: I dont understand.... the elevator just took me to Floor 13. There is no Floor 13."

@onready var audio_player=$AudioStreamPlayer3D

func interact(player_node):
	if audio_player.stream!=voice_audio:
		audio_player.stream=voice_audio
		
	if not audio_player.playing:
		audio_player.play()
		
		if player_node.has_method("show_message"):
			player_node.show_message(subtitle,voice_audio.get_length())
	else:
		audio_player.stop()
