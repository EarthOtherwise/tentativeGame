extends cardState

func enter() -> void: #when entering the base state (in the hand)
	if not card_ui.is_node_ready():
		await card_ui.ready #wait for the parent (cardStateMAchine) to be ready for you
	
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.WEB_GREEN #change the color to the base state color
	card_ui.state.text = "BASE" #change the text so we know we're in the base state
	card_ui.pivot_offset = Vector2.ZERO #the pivot is the 'zero' point. we change this during dragging, change it back when we go to the base state

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, cardState.State.CLICKED)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
