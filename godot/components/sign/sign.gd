class_name Sign extends Node2D

signal dialog_progressed
signal dialog_finished

@export var dialog: Array[String]

@onready var dialog_label: Label = %DialogLabel

var current_dialog_index: int = 0
var loops: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# This function shows the next line of dialog.
func next_dialog() -> void:
    # If we loop the dialog_index, emit that we finished the dialog.
    if current_dialog_index == 0 and loops > 0:
        dialog_finished.emit()

    if dialog.size() == 0:
        push_warning("This sign doesn't have any dialog :c")
        return

    _set_sign_text(dialog[current_dialog_index])
    # Tell the world that this sign showed its dialog.
    dialog_progressed.emit()
    current_dialog_index += 1
    current_dialog_index = current_dialog_index % dialog.size()

    if current_dialog_index == 0:
        loops += 1

func _set_sign_text(text: String) -> void:
    var vert_margin := 32
    dialog_label.text = text
    # Center label above sign.
    dialog_label.position.x = -dialog_label.size.x / 2
    dialog_label.position.y = -dialog_label.size.y - vert_margin
    dialog_label.show()

# This function is called when the player interacts with this object.
func _on_interactable_component_interacted_with():
    pass # Replace with function body.
