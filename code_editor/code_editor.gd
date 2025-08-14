class_name CodeEditor extends PanelContainer

@export var edited_script: Script:
	get:
		return edited_script
	set(value):
		set_script_in_editor(value)
		edited_script = value

signal saved
signal quit

@onready var code_edit: CodeEdit = %CodeEdit

func _ready() -> void:
    pass

func set_script_in_editor(script: Script) -> void:
	code_edit.text = script.source_code

func _on_quit_button_pressed() -> void:
	quit.emit()

func _on_save_button_pressed() -> void:
	edited_script.source_code = code_edit.text
	saved.emit()
