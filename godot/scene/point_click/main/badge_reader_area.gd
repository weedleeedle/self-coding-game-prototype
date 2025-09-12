class_name BadgeReaderArea extends Area2D

signal badge_scanned()

## The item the player needs to have in their inventory in order to leave.
@export var badge_item: InventoryItem

@onready var label: Label = $Label

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event.is_action_pressed("click"):
		if Inventory.has_item(badge_item):
			badge_scanned.emit()
		else:
			label.show()
			await create_tween().tween_interval(1).finished
			label.hide()
