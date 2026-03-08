extends CharacterBody3D

#walking variables
@export var base_speed := 4.0
@export var slowingFactor := 4.0

#running variables
@export var runSpeed := 8.0

#jump variables
@export var jump_maxHeight: float = 2.25
@export var jump_timeToPeak: float = 0.4
@export var jump_timeToDescent: float = 0.3

@export var jump_hangTime: float = 0.5

@export var jump_velocity: float = ((2.0 * jump_maxHeight) / jump_timeToPeak ) * -1.0
@export var jump_gravity: float = ((-2.0 * jump_maxHeight) / (jump_timeToPeak * jump_timeToPeak))
@export var jump_fallGravity: float = ((-2.0 * jump_maxHeight) / (jump_timeToDescent * jump_timeToDescent))

@onready var camera = $cameraController/Camera3D

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_logic(delta)
	jump_logic(delta)
	
	move_and_slide()

func move_logic(delta: float) -> void:
	movement_input = Input.get_vector("left", "right", "up", "down").rotated(-camera.global_rotation.y)
	var isRunning: bool = Input.is_action_pressed("run")
	var vel2D = Vector2(velocity.x, velocity.y)
	if movement_input != Vector2.ZERO:
		var speed = runSpeed if isRunning else base_speed
		vel2D += movement_input * speed * delta
		vel2D = vel2D.limit_length(speed)
	else:
		vel2D = vel2D.move_toward(Vector2.ZERO, base_speed * slowingFactor * delta)
	
	velocity.x = vel2D.x
	velocity.z = vel2D.y

func jump_logic(delta: float) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity
	
	var gravity = jump_gravity if velocity.y > 0.0 else jump_fallGravity
	velocity.y += gravity * delta
