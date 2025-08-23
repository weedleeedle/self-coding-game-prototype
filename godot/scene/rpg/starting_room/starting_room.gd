extends Node2D

## Things for the player to say when the level starts.
@export var starting_dialog: Array[String]

## Things for the player to say/think when they start moving.
@export var player_moved_dialog: Array[String]

## How far the player needs to move in order to trigger the "player moved" dialog.
@export var threshold: float = 64.0

@onready var player: RpgCharacter = $RpgCharacter
@onready var player_position: Vector2 = player.global_position
var player_moved_triggered: bool = false

func _ready() -> void:
    player.think(starting_dialog)

func _process(_delta: float) -> void:
    if not player_moved_triggered:
        if player_position.distance_squared_to(player.global_position) > pow(threshold, 2.0):
            player_moved_triggered = true
            player.think(player_moved_dialog)
