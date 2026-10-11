extends Interactable

@export var prompt_text:String="Press E to add Fuel (0/3)"

@export var secret_path_box:CSGBox3D
@export var monster:CharacterBody3D
@export var run_label:Label
@export var anim_player:AnimationPlayer
@export var generator_sound:AudioStreamPlayer3D

var current_fuel:int=0
var max_fuel:int=3
var is_running:bool=false

func _ready():
	if monster:
		monster.set_physics_process(false)
func interact(player_node):
	if is_running:
		return
	if player_node.fuel_count>0:
		player_node.fuel_count-=1
		current_fuel=current_fuel+1
		prompt_text="Press E to add Fuel (" + str(current_fuel) + "/" + str(max_fuel) + ")"
		if player_node.has_method("show_message"):
			player_node.show_message("Poured fuel into the tank.")
		if current_fuel>=max_fuel:
			start_generator(player_node)
	else:
		if player_node.has_method("show_message"):
			player_node.show_message("It's empty. I need to find gas cans.")
		
func start_generator(player_node):
	is_running=true
	prompt_text="Generator is running."
	if player_node.has_method("show_message"):
		player_node.show_message("Power restored! But what was that noise...?")
	if anim_player:
		anim_player.play("Take 001")
	if generator_sound:
		generator_sound.play()
	trigger_chase_sequence()
	

func trigger_chase_sequence():
	await get_tree().create_timer(3.0).timeout
	if run_label:
		run_label.visible=true
	if secret_path_box:
		secret_path_box.visible=true
	if monster:
		monster.set_physics_process(true)
	await get_tree().create_timer(2.0).timeout
	if run_label:
		run_label.visible=false
