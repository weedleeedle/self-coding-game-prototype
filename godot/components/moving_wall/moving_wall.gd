extends CharacterBody2D

## The target for this moving wall to follow.
@export var target: Node2D

## How hard to push the moving wall to the target position
@export var restoration_force: float = 100.0

## When to stop pushing and manually set the position.
@export var margin: float = 10.0

func _physics_process(_delta: float) -> void:
    # How far we are from the target. We only track the y position,
    # since this wall moves up and down.
    var displacement = target.global_position.y - self.global_position.y
    if displacement > margin:
        # Apply restoration force
        velocity.y += displacement * restoration_force

        move_and_slide()
    else:
        # We are close enough to the target position to just set it manually.
        self.global_position.y = target.global_position.y
