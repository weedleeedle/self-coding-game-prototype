class_name ClickSceneLoader extends Area2D

@export_file("*.tscn") var scene_to_load: String = ""

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event.is_action_pressed("click"):
        get_tree().change_scene_to_file.call_deferred(scene_to_load)
