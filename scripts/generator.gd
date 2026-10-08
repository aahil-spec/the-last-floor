extends Interactable

@export var prompt_text:String="Press E to add Fuel (0/3)"

@export var wheel_1:Node3D
@export var wheel_2:Node3D
@export var spin_speed:float=10.0

var current_fuel:int=0
var max_fuel:int=3
var is_running:bool=false

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

func _process(delta):
	if is_running:
		if wheel_1:
			wheel_1.rotation.y+=spin_speed*delta
		if wheel_2:
			wheel_2.rotation.y-=(spin_speed*1.5)*delta
