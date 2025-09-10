extends Node2D

# Generate a random, secret code when we first load the scene.
@onready var secret_code = randi_range(0, 999)

signal code_solved()

var solved: bool = false

var _dials: Array[Dial]

func _register_dials(dials: Array[Dial]) -> void:
    for dial in dials:
        dial.selected_digit_changed.connect(_on_dial_selected_digit_changed)

    _dials = dials

# Converts the three digits shown on the dials to the numerical code
func _get_shown_code(dials: Array[Dial]) -> int:
    var current_total := 0
    for dial in dials:
        current_total = current_total * 10 + dial.digit

    return current_total

func _on_dial_selected_digit_changed(_digit: int) -> void:
    var code = _get_shown_code(_dials)
    if code == secret_code:
        solved = true
        code_solved.emit()
