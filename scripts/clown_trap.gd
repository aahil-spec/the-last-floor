extends StaticBody3D

@export var red_emergency_light:OmniLight3D
@export var clown_audio:AudioStreamPlayer
@export var footstep_audio:AudioStreamPlayer
@export var door_slam:AudioStreamPlayer3D
@export var room_door:Node3D
@export var closed_rotation_y:float=0.0
@export var floating_anomalies:Array[Node3D]
var trap_sprung:bool=false
var anomalies_fixed:int=0
var trapped_player:Node3D
func _ready():
	visible=false
	$CollisionShape3D.disabled=true
	if red_emergency_light:
		red_emergency_light.visible=false
	for anomaly in floating_anomalies:
		if anomaly:
			anomaly.visible=false
			if anomaly.has_node("CollisionShape3D"):
				anomaly.get_node("CollisionShape3D").disabled=true
func spring_trap():
	if not trap_sprung:
		trap_sprung=true
		visible=true
		$CollisionShape3D.disabled=false
		if clown_audio:
			clown_audio.play()
		if footstep_audio:
			footstep_audio.play()
		if door_slam:
			door_slam.play()
		if room_door:
			var tween=create_tween()
			tween.tween_property(room_door,"rotation_degrees:y",closed_rotation_y,0.15)
		
func trigger_sacrifice(player_node):
	trapped_player=player_node
	if red_emergency_light:
		red_emergency_light.visible=true
	var player_light=trapped_player.find_child("*lash*",true,false)
	if player_light:
		player_light.visible=false
	if "has_flashlight" in trapped_player:
		trapped_player.has_flashlight=false
	for anomaly in floating_anomalies:
		if anomaly:
			anomaly.visible=true
			if anomaly.has_node("CollisionShape3D"):
				anomaly.get_node("CollisionShape3D").disabled=false
func fix_anomaly(anomaly_node:Node3D):
	var tween=create_tween()
	tween.tween_property(anomaly_node,"position:y",anomaly_node.position.y-1.595,0.2)
	anomalies_fixed+=1
	if anomalies_fixed>=3:
		await tween.finished
		escape_room()
func escape_room():
	if room_door:
		var tween=create_tween()
		tween.tween_property(room_door,"rotation_degrees:y",90.0,1.0)
		await tween.finished
	if red_emergency_light:
		red_emergency_light.visible=false
	queue_free()
	
