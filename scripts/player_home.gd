extends CharacterBody3D


@export var walk_speed=3.0
@export var mouse_sensitivity=0.002
@export var fade_screen:ColorRect
@onready var head=$Head
@onready var camera=$Head/Camera3D
@onready var message_label=$HUD/MessageLabel
@onready var interact_ray=$Head/Camera3D/InteractRay
@onready var interact_label=$HUD/InteractPrompt
@onready var note_overlay=$HUD/NoteOverlay
@onready var note_text=$HUD/NoteOverlay/NotePaper/NoteText
@onready var diary_overlay=$DiaryOverlay

var is_reading_diary:bool=false
var is_reading:bool=false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if fade_screen:
		fade_screen.visible=true
		fade_screen.modulate.a=1.0
	camera.rotation_degrees=Vector3(-10,0,75)
	var tween=create_tween()
	if fade_screen:
		tween.tween_property(fade_screen,"modulate:a",0.0,3.0)
	tween.parallel().tween_property(camera,"rotation_degrees:z",0.0,0.6).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(camera, "rotation_degrees:x", 0.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func():show_message("...it was all a dream?", 4.0))
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion and Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x*mouse_sensitivity)
		camera.rotate_x(-event.relative.y*mouse_sensitivity)
		camera.rotation.x=clamp(camera.rotation.x,deg_to_rad(-80),deg_to_rad(80))
	if event.is_action_pressed("interact"):
		if is_reading_diary:
			diary_overlay.visible=false
			is_reading_diary=false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_viewport().set_input_as_handled()
			return
		if is_reading:
			note_overlay.visible=false
			is_reading=false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			return
		if interact_ray and interact_ray.is_colliding():
			var target=interact_ray.get_collider()
			if target is Interactable:
				target.interact(self)
func _physics_process(delta):
	if not is_on_floor():
		velocity.y-=9.8*delta
	var input_dir=Input.get_vector("move_left","move_right","move_up","move_down")
	var direction=(head.transform.basis*Vector3(input_dir.x,0,input_dir.y)).normalized()
	if direction:
		velocity.x=direction.x*walk_speed
		velocity.z=direction.z*walk_speed
	else:
		velocity.x=move_toward(velocity.x,0,walk_speed)
		velocity.z=move_toward(velocity.z,0,walk_speed)
	move_and_slide()
	interact_label.visible=false
	if not is_reading and not is_reading_diary:
		
		if interact_ray and interact_ray.is_colliding():
			var target=interact_ray.get_collider()
			if target is Interactable:
				interact_label.visible=true
				if "prompt_text" in target:
					interact_label.text=target.prompt_text
				else:
					interact_label.text="Press E to interact"
func show_message(text_to_show:String,duration:float=3.0):
	if message_label:
		message_label.text=text_to_show
		message_label.visible=true
		await get_tree().create_timer(duration).timeout
		message_label.visible=false
		
func show_note(content:String):
	if note_text and note_overlay:
		note_text.text=content
		note_overlay.visible=true
		is_reading=true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func show_diary():
	if diary_overlay:
		diary_overlay.visible=true
		is_reading_diary=true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
