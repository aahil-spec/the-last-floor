extends Interactable

@export var prompt_text:String="Press E to use elevator"
@export var target_floor:String="lobby"

@export var target_height:float=0.0
@export var elevator_door:AnimatableBody3D

@export var elevator_root:Node3D

@export var floor_number:int=2

@export var target_floor_group:Node3D
@export var load_chunk_path:String=""
@export var unload_chunk_name:String=""
@warning_ignore("unused_parameter")
func interact(player_node):
	if not player_node.has_keycard:
		player_node.show_message("Access Denied: Security Keycard Required")
		return
		
	if floor_number>player_node.max_unlocked_floor:
		player_node.show_message("Error: Floor " + str(floor_number) + " is locked.")
		return
	if elevator_door and elevator_door.is_moving:
		player_node.show_message("Safety Lock: Elevator is in motion.")
		return
	if elevator_door and not elevator_door.is_door_closed:
		player_node.show_message("Safety Lock: Close the doors first")
		return
	player_node.show_message("Access Granted:Traveling...")
	if elevator_door:
		elevator_door.is_moving=true
	if "fade_screen" in player_node and player_node.fade_screen:
		player_node.fade_screen.visible=true
		var fade_out=create_tween()
		fade_out.tween_property(player_node.fade_screen,"modulate:a",1.0,1.0)
		await fade_out.finished
	var world=get_tree().current_scene
	if load_chunk_path!="":
		var new_chunk_scene=load(load_chunk_path)
		if new_chunk_scene:
			world.add_child(new_chunk_scene.instantiate())
	if unload_chunk_name!="":
		var old_chunk=world.get_node_or_null(unload_chunk_name)
		if old_chunk:
			old_chunk.queue_free()
	if world.has_method("activate_floor") and target_floor_group:
		world.activate_floor(target_floor_group)
	var tween=create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(elevator_root,"global_position:y",target_height,5.0)
	await tween.finished
	if elevator_door:
		elevator_door.is_moving=false
	if "fade_screen" in player_node and player_node.fade_screen:
		var fade_in=create_tween()
		fade_in.tween_property(player_node.fade_screen,"modulate:a",0.0,1.0)
		await fade_in.finished
		player_node.fade_screen.visible=false
