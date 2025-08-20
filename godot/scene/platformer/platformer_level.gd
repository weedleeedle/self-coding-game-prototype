extends Node2D

## The scene to load when the player reaches the goal.
@export_file("*.tscn") var victory_scene_path: String

## Load the victory scene into memory when we first enter the scene.
@onready var victory_scene: PackedScene = load(victory_scene_path)

func _on_goal_goal_reached():
    # Switch to the victory scene when the player reaches the goal!
    get_tree().change_scene_to_packed(victory_scene)

