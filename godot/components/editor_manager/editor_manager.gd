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
            print(child)
            child.set_script(null)
            script_owners.push_back(child)


    new_script.reload()
    for script_owner in script_owners:
        script_owner.set_script(new_script)
