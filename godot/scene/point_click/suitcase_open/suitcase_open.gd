class_name SuitcaseOpen extends Node2D

signal badge_taken()

@export var badge_removed: bool = false:
    get:
        return badge_removed
    set(value):
        badge_removed = value
        _update_sprite(badge_removed)

@export var badge_item: InventoryItem

@onready var badge_taken_sprite: Sprite2D = $SuitcaseBadgeTaken

func _ready() -> void:
    badge_removed = PointClickState.badge_taken

func remove_badge() -> void:
    if badge_removed:
        return

    badge_removed = true
    # Add badge to player inventory.
    Inventory.add_item(badge_item)
    badge_taken.emit()

func _update_sprite(p_badge_removed: bool) -> void:
    if not badge_taken_sprite:
        return

    badge_taken_sprite.visible = p_badge_removed
    PointClickState.badge_taken = p_badge_removed

func _on_badge_area_input_event(_viewport:Node, event: InputEvent, _shape_idx:int) -> void:
    if event is InputEventMouseButton and event.is_pressed() and not badge_removed:
        remove_badge()
