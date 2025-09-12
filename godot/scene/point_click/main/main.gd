extends Node2D

@export_file("*.tscn") var victory_scene_path: String

func _on_badge_reader_area_badge_scanned():
    get_tree().change_scene_to_file(victory_scene_path)

