class_name cardUI
extends Control

signal reparent_requested(which_card_ui: cardUI)

@onready var color: ColorRect = $tempColour
@onready var state: Label = $state
@onready var drop_point_detector: Area2D = $dropPointDetector
@onready var card_state_machine: cardStateMachine = $cardStateMachine as cardStateMachine
@onready var targets: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
