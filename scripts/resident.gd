extends CharacterBody3D

@export var speed:float=2.5
@onready var nav_agent=$NavigationAgent3D
@export var visual_mesh:Node3D
@export var stand_shape:CollisionShape3D
@export var crawl_shape:CollisionShape3D

@export var is_throne_event:bool=false
@export var charge_speed:float=25.0
@export var home_scene_path:String="res://scenes/players_home.tscn"
var throne_state:String="sitting_idle"
@onready var anim_player=$Model/AnimationPlayer
var player_node:Node3D
var step_timer:float=0.0
var is_resetting:bool=false

@export var sound_laugh:AudioStreamPlayer3D
@export var sound_crawl: AudioStreamPlayer3D
@export var sound_jumpscare: AudioStreamPlayer3D
func _ready():
	player_node=get_tree().get_first_node_in_group("player")
	set_physics_process(false)
	add_to_group("monster")
	if anim_player:
		if is_throne_event:
			anim_player.play("sitting_idle")
		else:
			anim_player.play("standing")
	if stand_shape and crawl_shape:
		stand_shape.set_deferred("disabled",false)
		crawl_shape.set_deferred("disabled",true)
	if has_node("KillBox"):
		$KillBox.body_entered.connect(_on_kill_box_body_entered)
		if has_node("KillBox/CollisionShape3D"):
			$KillBox/CollisionShape3D.set_deferred("disabled", true)
func _physics_process(delta):
	if is_resetting or not player_node:
		return
	if not is_on_floor():
		velocity.y-=9.8*delta
	if is_throne_event:
		if throne_state=="charging":
			var direction=global_position.direction_to(player_node.global_position)
			direction.y=0
			direction=direction.normalized()
			velocity.x=direction.x*charge_speed
			velocity.z=direction.z*charge_speed
			look_at(Vector3(player_node.global_position.x,global_position.y,player_node.global_position.z),Vector3.UP)
			move_and_slide()
		return
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
			if has_node("KillBox/CollisionShape3D"):
				$KillBox/CollisionShape3D.set_deferred("disabled",false)
			if sound_crawl and not sound_crawl.playing:
				sound_crawl.play()
	else:
		if anim_player and anim_player.current_animation!="standing":
			anim_player.play('standing')
			if stand_shape and crawl_shape:
				stand_shape.set_deferred("disabled",false)
				crawl_shape.set_deferred("disabled",true)
			if has_node("KillBox/CollisionShape3D"):
				$KillBox/CollisionShape3D.set_deferred("disabled",true)
			if sound_crawl:
				sound_crawl.stop()
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
	if body==player_node:
		if is_throne_event and throne_state=="charging":
			trigger_wakeup()
		elif not is_throne_event:
			if anim_player and anim_player.current_animation=="standing":
				return 
			catch_player()
func wait_for_note_close():
	if is_throne_event:
		throne_state="waiting"
		
func _process(_delta):
	if is_throne_event and throne_state=="waiting" and player_node and not player_node.is_reading:
		throne_state="laughing"
		if sound_laugh:
			sound_laugh.play()
		if anim_player:
			anim_player.play("sitting_laughing")
			await anim_player.animation_finished
			throne_state="charging"
			if stand_shape and crawl_shape:
				stand_shape.set_deferred("disabled",true)
				crawl_shape.set_deferred("disabled",false)
			if has_node("KillBox/CollisionShape3D"):
				$KillBox/CollisionShape3D.set_deferred("disabled",false)
			global_position.y+=1.5
			anim_player.play("running_crawl")
			if sound_crawl:
				sound_crawl.play()
			set_physics_process(true)
func trigger_wakeup():
	if player_node and player_node.fade_screen:
		player_node.fade_screen.modulate.a=1.0
		player_node.fade_screen.visible=true
	if sound_jumpscare:
		sound_jumpscare.play()
		await sound_jumpscare.finished
	get_tree().call_deferred("change_scene_to_file",home_scene_path)
