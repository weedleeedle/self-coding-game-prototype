extends CharacterBody2D


const SPEED := 300.0
var moving_right := true

@onready var wall_detector_ray: RayCast2D = %WallDetectorRay

func _physics_process(delta: float) -> void:
    # Apply gravity
    if not is_on_floor():
        velocity += get_gravity() * delta

    velocity.x = SPEED * (1 if moving_right else -1)

    # If we collide with something (i.e a wall),
    # flip directions
    if wall_detector_ray.is_colliding():
        moving_right = !moving_right
        # Also flip the ray direction.
        wall_detector_ray.rotation = deg_to_rad(0) if moving_right else deg_to_rad(180)

    move_and_slide()
