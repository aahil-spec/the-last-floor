extends CharacterBody3D

@export var walk_speed=3.0
@export var jump_velocity=4.5
@export var mouse_sensitivity=0.002

@onready var head=$Head
@onready var camera=$Head/Camera3D
@onready var flashlight=$Head/Camera3D/FlashLight
@onready var interact_ray=$Head/Camera3D/InteractRay


@onready var interact_label=$HUD/InteractPrompt

var has_flashlight=false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x*mouse_sensitivity)
		camera.rotate_x(-event.relative.y*mouse_sensitivity)
		camera.rotation.x=clamp(camera.rotation.x,deg_to_rad(-80),deg_to_rad(80))
	if event.is_action_pressed("interact"):
		if interact_ray.is_colliding() and interact_ray.get_collider() is Interactable:
			var target=interact_ray.get_collider()
			target.interact(self)
		elif has_flashlight:
			var light_beam=flashlight.get_node_or_null("SpotLight3D")
			if light_beam:
				light_beam.visible=not light_beam.visible
		
func _physics_process(delta):
	interact_label.visible=false
	
	if interact_ray.is_colliding() and interact_ray.get_collider() is Interactable:
		var target=interact_ray.get_collider()
		interact_label.visible=true
		if "prompt_text" in target:
			interact_label.text=target.prompt_text
		else:
			interact_label.text="Press E to interact"
	elif has_flashlight:
		interact_label.visible=true
		interact_label.text="Press E to turn on and off"
	if not is_on_floor():
		velocity.y-=ProjectSettings.get_setting("physics/3d/default_gravity")*delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y=jump_velocity
	var input_dir=Input.get_vector("move_left","move_right","move_up","move_down")
	var direction=(head.transform.basis*Vector3(input_dir.x,0,input_dir.y)).normalized()
	
	if direction:
		velocity.x=direction.x*walk_speed
		velocity.z=direction.z*walk_speed
	else:
		velocity.x=move_toward(velocity.x,0,walk_speed)
		velocity.z=move_toward(velocity.z,0,walk_speed)
	move_and_slide()
	
