extends OmniLight3D


@export var normal_energy:float=1.0

func _ready():
	light_energy=normal_energy
	start_flicker_routine()
	
func start_flicker_routine():
	while true:
		var calm_time=randf_range(1,5.0)
		await get_tree().create_timer(calm_time).timeout
		var stutters=randi_range(1,4)
		for i in range(stutters):
			light_energy=randf_range(0.0,0.2)
			await get_tree().create_timer(randf_range(0.05,0.15)).timeout
			
			light_energy=normal_energy
			await get_tree().create_timer(randf_range(0.05,0.25)).timeout
