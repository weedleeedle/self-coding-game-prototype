extends Control

@onready var code_edit: CodeEdit = %CodeEdit

func _on_button_pressed():
	var tokens: Array[GDScriptToken] = []

	for line in code_edit.text.split("\n"):
		tokens.append_array(GDScriptTokenizer.tokenize_string(line))

	for token in tokens:
		print(token.Type.keys()[token.type], "\t", token.string_rep)
