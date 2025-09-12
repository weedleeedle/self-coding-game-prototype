class_name InventoryItem extends Resource

@export var item_id: String

func eq(other: InventoryItem) -> bool:
    return self.item_id == other.item_id

func _init(p_item_id := "") -> void:
    item_id = p_item_id
