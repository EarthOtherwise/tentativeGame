extends Node3D

@export var theOneToRespawn : PackedScene
var isTimerStarted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_child_count() <= 1 and !isTimerStarted:
		$Timer.start()
		isTimerStarted = true


func _on_timer_timeout() -> void:
	var instance = theOneToRespawn.instantiate()
	add_child(instance)
	isTimerStarted = false
