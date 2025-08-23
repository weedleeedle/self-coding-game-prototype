extends Node2D

## Things for the player to say when the level starts.
@export var starting_dialog: Array[String]

@onready var player: RpgCharacter = $RpgCharacter

func _ready() -> void:
    player.think(starting_dialog)
