extends CharacterBody3D

enum States {attack, idle, chase, die}

var state = States.idle
var hp = 15
var speed = 2
var accel = 10
var gravity = 9.8
var target = null
var damage = 5
var lootToGive = 5

@export var navAgent : NavigationAgent3D
@export var animationPlayer : AnimationPlayer


func _process(delta: float) -> void:
	if hp <= 0:
		state = States.die

func enemy() -> void:
	pass

func giveLoot():
	target.currentGold += lootToGive

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity
	elif(velocity.y != 0.0):
		velocity.y = 0.0
	
	if state == States.idle:
		velocity = Vector3(0.0, velocity.y, 0.0)
		animationPlayer.play("Idle")
		
	elif state == States.chase:
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP, true)
		navAgent.target_position = target.global_position
		var direction = navAgent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		animationPlayer.play("Walk")
		
	elif state == States.attack:
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP, true)
		velocity = Vector3(0.0, velocity.y, 0.0)
		animationPlayer.play("Punch")
		
	elif state == States.die:
		velocity = Vector3(0.0, velocity.y, 0.0)
		animationPlayer.play("Die")
		#if !($DeathTimer.time_left < $DeathTimer.wait_time):
			#$DeathTimer.start()
	
	move_and_slide()

func attack():
	target.hp -= damage

func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.chase
		target = body

func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.idle
		target = null

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.attack

func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.chase


func _on_death_timer_timeout() -> void:
	queue_free()
