@tool
class_name StarField extends Control

@export var amount: int:
    get:
        if !emitter:
            return 0
        return emitter.amount
    set(value):
        if emitter:
            emitter.amount = value

@onready var emitter: CPUParticles2D = %Emitter

