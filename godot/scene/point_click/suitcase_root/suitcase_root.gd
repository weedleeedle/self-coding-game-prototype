class_name SuitcaseRoot extends Node2D

@export var suitcase_opened: bool:
	get:
		return suitcase_opened
	set(value):
		suitcase_opened = value
		_update_suitcase_opened(suitcase_opened)

@onready var suitcase_front: Node2D = $SuitcaseFront
@onready var suitcase_open: Node2D = $SuitcaseOpen

func _ready() -> void:
	_update_suitcase_opened(suitcase_opened)

func _on_suitcase_opened() -> void:
	suitcase_opened = true

func _update_suitcase_opened(p_suitcase_opened: bool) -> void:
	suitcase_open.visible = p_suitcase_opened
	suitcase_front.visible = !p_suitcase_opened
