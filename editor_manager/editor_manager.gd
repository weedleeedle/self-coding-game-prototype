extends Node

@onready var code_editor_layer: CanvasLayer = %CodeEditorLayer
@onready var code_editor: CodeEditor = %CodeEditor

func edit_script(script: Script) -> void:
	code_editor.edited_script = script
	code_editor_layer.show()

func _on_code_editor_quit():
	code_editor_layer.hide()

func _on_code_editor_saved():
	code_editor_layer.hide()

	var new_script = code_editor.edited_script
	var script_owners: Array[Node] = []
	for node in get_tree().root.get_child(-1).find_children("*"):
		if new_script.instance_has(node):
			node.set_script(null)
			script_owners.push_back(node)

	new_script.reload()
	for script_owner in script_owners:
		script_owner.set_script(new_script)
