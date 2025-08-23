class_name InteractableComponent extends Node2D

## This signal is emitted when this object is interacted with.
signal interacted_with()

func interact() -> void:
    interacted_with.emit()
