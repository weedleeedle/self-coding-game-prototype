extends CharacterBody2D

## Time in seconds to show a line of text above the player's head
@export var thinking_show_time: float = 2.0

const SPEED = 300.0

@onready var thinking_label: Label = %ThinkingLabel

func _ready() -> void:
    think("Hi :3")

func _physics_process(_delta: float) -> void:
    velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * SPEED

    move_and_slide()

func think(text: String) -> void:
    var vert_margin := 32
    thinking_label.text = text
    # Center label above player
    thinking_label.position.x = -thinking_label.size.x / 2
    thinking_label.position.y = -thinking_label.size.y - vert_margin
    thinking_label.show()
    await create_tween().tween_interval(thinking_show_time).finished
    thinking_label.hide()
