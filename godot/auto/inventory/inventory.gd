## Inventory service
extends Node

var inventory: Array[InventoryItem]

func add_item(item: InventoryItem) -> void:
    if has_item(item):
        return

    inventory.push_back(item)

func remove_item(item: InventoryItem) -> void:
    var index = find_item_in_inventory(item)
    if index == -1:
        return

    inventory.remove_at(index)

## Returns the index of the inventory item, or -1 if the inventory item doesn't exist.
func find_item_in_inventory(item: InventoryItem) -> int:
    for i in range(inventory.size()):
        if inventory[i].eq(item):
            return i

    return -1

func has_item(item: InventoryItem) -> bool:
    for inventory_item in inventory:
        if inventory_item.eq(item):
            return true

    return false
