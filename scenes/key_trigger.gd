extends Area3D
@export var mannequin_node: Node3D
@export var scare_spot: Marker3D
@export var audio_player: AudioStreamPlayer
@export var dramatic_player: AudioStreamPlayer
@export var clown_player: AudioStreamPlayer
var trap_sprung = false

func teleport_mannequin():
		if trap_sprung == false and mannequin_node != null and scare_spot != null:
				mannequin_node.global_position = scare_spot.global_position
				if audio_player != null:
						audio_player.play()
				if dramatic_player != null:
						dramatic_player.play()
				if clown_player != null:
						clown_player.play()
				trap_sprung = true

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		teleport_mannequin()
