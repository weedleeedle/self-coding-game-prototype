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
func is_valid_script(_script: Script, code: String) -> Error:
    var new_script: GDScript = GDScript.new()
    # check for class_name declaration, remove it.
    new_script.source_code = _strip_class_name(code)
    var error: Error = new_script.reload()
    return error

## When we're creating a fake copy of our source code to check for errors,
## we need to remove any class_name declaration, because otherwise
## we'll have two scripts with the same class_name.
func _strip_class_name(source_code: String) -> String:
    # Tbh we don't super need a tokenizer? But ig we might as well use it.
    var tokenizer := GDScriptTokenizer.default_tokenizer()
    var token_stream: Array[GDScriptToken] = tokenizer.tokenize_string(source_code)
    # Find class_name token, remove it and the next one.
    var cur_token_index := 0
    while cur_token_index < token_stream.size():
        if token_stream[cur_token_index].is_keyword() and token_stream[cur_token_index].string_rep == "class_name":
            token_stream.remove_at(cur_token_index)
            # Remove next token too, which is now the current token.
            token_stream.remove_at(cur_token_index)
            # We only need to do this once i think?
            break

    return _rejoin_token_stream(token_stream)

func _rejoin_token_stream(token_stream: Array[GDScriptToken]) -> String:
    # Rejoin all the original tokens.
    var new_source_code: String = ""
    # Reuse cur_token_index
    var cur_token_index := 0
    for token in token_stream:
        # Actually points to the token after this one bc dumb.
        cur_token_index += 1
        new_source_code += token.string_rep
        # This is dumb, check to see if we should NOT add a space.
        if token.is_whitespace():
            continue
        if token.type == GDScriptToken.Type.PERIOD:
            continue
        # Also if the NEXT token is a dot, don't put a period. IS WEIRD I KNOW
        if token_stream.size() > cur_token_index and token_stream[cur_token_index].type == GDScriptToken.Type.PERIOD:
            continue

        new_source_code += " "

    print(new_source_code)

    return new_source_code


func _on_quit_button_pressed() -> void:
    quit.emit()

func _on_save_button_pressed() -> void:
    var error = is_valid_script(edited_script, code_edit.text)
    if error:
        error_descriptor.show()
        return

    # If no error...
    error_descriptor.hide()
    edited_script.source_code = code_edit.text
    saved.emit()
