extends CharacterBody3D

@export var speed:float=4.5
@onready var nav_agent=$NavigationAgent3D
@export var visual_mesh:Node3D
var player_node:Node3D
var step_timer:float=0.0
func _ready():
	player_node=get_tree().get_first_node_in_group("player")
func _physics_process(delta):
	if not player_node:
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
		step_timer+=delta*12.0
		if visual_mesh:
			visual_mesh.position.y=sin(step_timer)*0.12
			visual_mesh.rotation.z=sin(step_timer*0.5)*0.1
			visual_mesh.rotation.z=0.15+(sin(step_timer*2.0)*0.03)
	else:
		if visual_mesh:
			visual_mesh.position.y=lerp(visual_mesh.position.y,0.0,delta*5.0)
			visual_mesh.rotation.z=lerp(visual_mesh.rotation.z,0.0,delta*5.0)
			visual_mesh.rotation.x=lerp(visual_mesh.rotation.x,0.0,delta*5.0)
	move_and_slide()
	
