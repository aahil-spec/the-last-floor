extends CharacterBody3D

@export var speed:float=2.5
@onready var nav_agent=$NavigationAgent3D
@export var visual_mesh:Node3D
@export var stand_shape:CollisionShape3D
@export var crawl_shape:CollisionShape3D

@onready var anim_player=$Model/AnimationPlayer
var player_node:Node3D
var step_timer:float=0.0
var is_resetting:bool=false
func _ready():
	player_node=get_tree().get_first_node_in_group("player")
	set_physics_process(false)
	add_to_group("monster")
	if anim_player:
		anim_player.play("standing")
	if stand_shape and crawl_shape:
		stand_shape.set_deferred("disabled",false)
		crawl_shape.set_deferred("disabled",true)
	if has_node("KillBox"):
		$KillBox.body_entered.connect(_on_kill_box_body_entered)
func _physics_process(delta):
	if is_resetting or not player_node:
		return
	if not is_on_floor():
		velocity.y-=9.8*delta
	nav_agent.target_position=player_node.global_position
	var current_location=global_position
	var next_location=nav_agent.get_next_path_position()
	var new_velocity=(next_location-current_location).normalized()*speed
	velocity.x=new_velocity.x
	velocity.z=new_velocity.z
	if velocity.length()>0.1:
		look_at(Vector3(player_node.global_position.x,global_position.y,player_node.global_position.z),Vector3.UP)
		if anim_player and anim_player.current_animation!="crawl":
			anim_player.play("crawl")
			if stand_shape and crawl_shape:
				stand_shape.set_deferred("disabled",true)
				crawl_shape.set_deferred("disabled",false)
	else:
		if anim_player and anim_player.current_animation!="standing":
			anim_player.play('standing')
			if stand_shape and crawl_shape:
				stand_shape.set_deferred("disabled",false)
				crawl_shape.set_deferred("disabled",true)
	move_and_slide()
	
	
func catch_player():
	if is_resetting:
		return
	is_resetting=true
	if anim_player:
		anim_player.play("standing")
	if stand_shape and crawl_shape:
		stand_shape.set_deferred("disabled",false)
		crawl_shape.set_deferred("disabled",true)
	if player_node.has_method("play_death_screen"):
		player_node.play_death_screen()
func reset_position():
	var push_dir=(global_position-player_node.global_position)
	push_dir.y=0
	push_dir=push_dir.normalized()
	if push_dir==Vector3.ZERO:
		push_dir=Vector3.BACK
	global_position=player_node.global_position+(push_dir*4.0)
	await get_tree().create_timer(3.0).timeout
	is_resetting=false
func _on_kill_box_body_entered(body):
	if anim_player and anim_player.current_animation=="standing":
		return
	if body==player_node:
		catch_player()
