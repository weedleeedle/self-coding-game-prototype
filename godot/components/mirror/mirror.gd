extends Node2D

@onready var camera: Camera2D = %Camera2D
@onready var viewport: SubViewport = %SubViewport

func _ready():
    viewport.world_2d = get_viewport().world_2d
    camera.global_position = global_position
    # I have no idea what i'm doing here lmao
    camera.global_position.y -= (viewport.size.y as float)
    #camera.global_position.x += (viewport.size.x as float) / 2
    camera.zoom.x = -camera.zoom.x
