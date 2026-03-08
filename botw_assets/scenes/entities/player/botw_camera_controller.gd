extends Node3D

@export var MOUSE_SENSITIVITY := 0.005
@export var MINIMUM_ANGLE := -0.8
@export var MAXIMUM_ANGLE := 0.3


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * MOUSE_SENSITIVITY)

func rotate_from_vector(v: Vector2):
	if v.length() == 0: return
	rotation.y -= v.x
	rotation.x -= v.y
	rotation.x = clamp(rotation.x, MINIMUM_ANGLE, MAXIMUM_ANGLE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
