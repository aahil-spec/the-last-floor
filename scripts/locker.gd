extends Interactable

@export var prompt_text="PRess E to open locker"
@export var anim_player:AnimationPlayer
@export var animation_name:String="Action"
var is_open:bool=false

func _ready():
	if anim_player:
		anim_player.play(animation_name)
		anim_player.seek(0.0,true)
		anim_player.pause()
@warning_ignore("unused_parameter")
func interact(player_node):
	if is_open:
		return
	is_open=true
	prompt_text=""
	if anim_player:
		anim_player.play(animation_name)
		await get_tree().create_timer(3.6725).timeout
		anim_player.pause()
