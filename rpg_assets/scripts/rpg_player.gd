extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var sensitivity = 0.003
@onready var camera = $Head
var isOnCooldown: bool = false
@onready var animationPlayer = $SwordSwing
@onready var cooldownTimer = $AttackCooldown
@onready var hpBar = $HUD/HealthBar
@onready var goldLabel = $HUD/Gold

var currentGold: int = 0
var hp: int = 50
@export var maxHp: int = 50

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Head/FirstPersonCamera.current = true
	hpBar.max_value = maxHp

func update_hud():
	hpBar.value = hp
	goldLabel.text = str(currentGold)

func _process(_delta: float) -> void:
	update_hud()
	attack()
	_switch_view()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func attack():
	if Input.is_action_just_pressed("left_mouse") and !isOnCooldown:
		animationPlayer.play("swordSwing")
		isOnCooldown = true
		cooldownTimer.start()

func _switch_view():
	if Input.is_action_just_pressed("switch"):
		if $Head/FirstPersonCamera.current:
			$Head/ThirdPersonCamera.current = true
		else:
			$Head/FirstPersonCamera.current = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_attack_cooldown_timeout() -> void:
	isOnCooldown = false
