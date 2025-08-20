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
@onready var error_descriptor: Label = %ErrorDescriptor

func _ready() -> void:
    pass

func set_script_in_editor(script: Script) -> void:
    code_edit.text = script.source_code

## Tests a script with a new body of code.
## Returns the Error enum, which is 0 if it's okay,
func is_valid_script(script: Script, code: String) -> Error:
    var new_script: GDScript = GDScript.new()
    new_script.source_code = code
    var error: Error = new_script.reload()
    return error

func _on_quit_button_pressed() -> void:
    quit.emit()

func _on_save_button_pressed() -> void:
    var error = is_valid_script(edited_script, code_edit.text)
    if error:
        error_descriptor.show()
        error_descriptor.text = "AAAAAAAAAA"
        return

    # If no error...
    error_descriptor.hide()
    edited_script.source_code = code_edit.text
    saved.emit()

