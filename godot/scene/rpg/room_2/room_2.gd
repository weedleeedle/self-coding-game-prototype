extends Node2D

@export var starting_dialog: Array[String]

## Things for player to say when they attempt to interact with something.
@export var sign_interacted_with_dialog: Array[String]
var sign_interacted_with_dialog_shown := false

@export_file("*.tscn") var main_scene_path: String
@onready var main_scene: PackedScene = load(main_scene_path)

@onready var player: RpgCharacter = $RpgCharacter
@onready var sign: Sign = $Sign

func _ready() -> void:
    player.think(starting_dialog)

func _on_rpg_character_interactable_interaction_attempted():
    if not sign_interacted_with_dialog_shown:
        player.think(sign_interacted_with_dialog)
        sign_interacted_with_dialog_shown = true


func _on_sign_dialog_finished():
    get_tree().change_scene_to_packed(main_scene)

