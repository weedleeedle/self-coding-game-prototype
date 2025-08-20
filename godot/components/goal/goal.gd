extends Node2D

## This signal is fired when the player reaches the goal, yippee!
signal goal_reached()

## This area detects specifically for the player.
func _on_player_detector_area_body_entered(_body: Node2D) -> void:
    goal_reached.emit()

