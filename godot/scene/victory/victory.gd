extends Control

@export_file("*.tscn") var title_scene_path: String

@onready var title_scene = load(title_scene_path)

## Switch to the title scene when the button is pressed.
func _on_back_to_title_button_pressed():
    get_tree().change_scene_to_packed(title_scene)

