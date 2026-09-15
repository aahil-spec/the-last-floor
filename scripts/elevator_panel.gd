extends Interactable

@warning_ignore("unused_parameter")
func interact(player_node):
	if ElevatorManager.current_floor=="lobby":
		ElevatorManager.change_floor("floor_2")
	else:
		print("Returning to Lobby...")
		ElevatorManager.change_floor("lobby")
