extends CharacterBody3D


@export var	 SPEED = 0.1
const JUMP_VELOCITY = 4.5

var look_dir: Vector2
var mouse_captured: bool = false

@onready var interactionRayCast: RayCast3D = $Camera3D/interaction

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	capture_mouse()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()
	
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func _rotate_camera(sens_mod: float = 1.0) -> void:
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
	

	

func _physics_process(delta):
	
	# why did NO RESOURCE tell me that .basis just GIVES THE VECTOR OF THE CAMERA
	# I SPENT SO MUCH TIME TRYING TO DO WEIRD CAMERA STUFF
	# I could have literally just gotten the vector and then moved towards it the whole time
	# anger
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var walk_dir = camera.get_global_transform().basis
	
	
	if(interactionRayCast.is_colliding()):
		print(interactionRayCast.get_collider().name)
	
		
	
	velocity += walk_dir *direction* SPEED
	if(Input.is_action_pressed("stop")):
		
		velocity = velocity.move_toward(Vector3.ZERO,0.2)
	
	
	

	move_and_slide()
