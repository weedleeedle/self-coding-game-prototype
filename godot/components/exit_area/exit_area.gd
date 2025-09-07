extends Area2D

@export_file("*.tscn") var scene_to_switch_to_path: String
@onready var scene_to_switch_to: PackedScene = load(scene_to_switch_to_path)

func _on_body_entered(_body: Node2D) -> void:
    get_tree().change_scene_to_packed.call_deferred(scene_to_switch_to)
