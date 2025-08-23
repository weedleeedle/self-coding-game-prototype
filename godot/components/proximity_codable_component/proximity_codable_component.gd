class_name ProximityCodableComponent extends Node2D

## Script to edit
@export var edited_script: Script

func edit() -> void:
    EditorManager.edit_script(edited_script)
