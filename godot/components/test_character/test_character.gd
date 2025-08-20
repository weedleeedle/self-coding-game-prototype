extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = Input.get_axis("move_left", "move_right") * SPEED

	move_and_slide()

## This signal is fired when the player collides with an enemy. Ouch!
func _on_hurtbox_area_entered(_area: Area2D) -> void:
	# This is equivalent to a level reset.
	get_tree().reload_current_scene()
