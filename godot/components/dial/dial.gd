@tool
class_name Dial extends Node2D

signal selected_digit_changed(digit: int)

## The selected digit
@export var digit: int:
    get:
        return digit
    set(value):
        digit = _set_valid_digit(value)
        _position_sprite(digit)
        selected_digit_changed.emit(digit)

# Offset from the first digit (0)
var base_offset: int = 200

# How big each digit is.
var digit_size: int = 100

# Whether or not the mouse is being dragged.
var dragged: bool = false
# Where the mouse was grabbed.
var grab_offset: Vector2

@onready var dial_display: Sprite2D = %DialDisplay

func _unhandled_input(event: InputEvent) -> void:
    if dragged and event is InputEventMouseMotion:
        dial_display.position.y += event.relative.y
        dial_display.position.y = _wrap_sprite_position(dial_display.position.y)

    if dragged and event is InputEventMouseButton and event.is_released():
        dragged = false
        digit = _get_shown_digit_at_position(dial_display.position.y)

## Displays the portion of the sprite associated with the digit.
func _position_sprite(digit: int) -> void:
    if not dial_display:
        return

    dial_display.position.y = -base_offset - digit_size * _set_valid_digit(digit)

func _get_shown_digit_at_position(y_position: float) -> int:
    var offset_position = -y_position - base_offset
    return ((round(offset_position / digit_size) as int) + 10) % 10

## Forces the number to be between 0 and 9.
func _set_valid_digit(number: int) -> int:
    return min(max(number, 0), 9)

func _wrap_sprite_position(y_position: float) -> float:
    # We want to keep the y_position between -200 (0) and -1100 (9) p much.
    # If we go above -200 we want to have that wrap around to -1100.
    # So we map -200 and -1100 to 0 and 900 ig?
    var offset_position = -y_position - base_offset
    var wrapped_offset = fmod(offset_position + digit_size * 10, digit_size * 10)
    var inverted_offset_position = -wrapped_offset - base_offset
    return inverted_offset_position

func _on_grab_area_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
    if event.is_action_pressed("click"):
        dragged = true
