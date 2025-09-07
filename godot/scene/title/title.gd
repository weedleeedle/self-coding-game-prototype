extends Control

@export_file("*.tscn") var platformer_scene_path: String
@onready var platformer_scene: PackedScene = load(platformer_scene_path)

@export_file("*.tscn") var rpg_scene_path: String
@onready var rpg_scene: PackedScene = load(rpg_scene_path)

func _on_platformer_button_pressed():
    get_tree().change_scene_to_packed(platformer_scene)

func _on_rpg_button_pressed():
    get_tree().change_scene_to_packed(rpg_scene)
