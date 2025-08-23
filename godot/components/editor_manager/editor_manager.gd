extends Node

@onready var code_editor_layer: CanvasLayer = %CodeEditorLayer
@onready var code_editor: CodeEditor = %CodeEditor

func edit_script(script: Script) -> void:
    code_editor.edited_script = script
    code_editor_layer.show()
    get_tree().paused = true

func _on_code_editor_quit():
    get_tree().paused = false
    code_editor_layer.hide()

func _on_code_editor_saved():
    get_tree().paused = false
    code_editor_layer.hide()

    var new_script = code_editor.edited_script
    var script_owners: Array[Node] = []
    for child in get_tree().root.find_children("*", "", true, false):
        if new_script.instance_has(child):
            script_owners.push_back(child)
            #child.set_script(null)

    # This does break tweens in RpgCharacter... dunno how to fix that.
    # True keeps state here?
    new_script.reload(true)
    # Reattach script.
    #for restore_object in script_owners:
        #restore_object.set_script(new_script)

## Returns a dictionary of properties.
## Key is the property name, value is the current value.
func _get_object_properties(object: Object) -> Dictionary:
    var results := {}
    for property in object.get_property_list():
        var prop_value = object.get(property.name)
        results.set(property.name, prop_value)

    return results
