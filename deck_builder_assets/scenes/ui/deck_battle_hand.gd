class_name hand
extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		var card_ui := child as cardUI
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: cardUI) -> void:
	child.reparent(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
