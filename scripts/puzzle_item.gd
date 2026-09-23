extends Interactable

@export var prompt_text:String="Press E to interact"
@export var is_sacrifice_panel:bool=false
@export var clown_manager:Node3D

@export var hand_animator:AnimationPlayer
@export var animaton_name:String="Anim01"
@export var freeze_time:float=1.23

func interact(player_node):
	$CollisionShape3D.disabled=true
	if hand_animator:
		hand_animator.play(animaton_name)
		await get_tree().create_timer(freeze_time).timeout
		hand_animator.pause()
	if is_sacrifice_panel:
		clown_manager.trigger_sacrifice(player_node)
	else:
		clown_manager.fix_anomaly(self)
