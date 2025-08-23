class_name CodableComponent extends Area2D

## Script to edit
@export var edited_script: Script

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event.is_action_pressed("edit"):
        EditorManager.edit_script(edited_script)

