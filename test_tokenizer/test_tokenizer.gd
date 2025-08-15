extends Control

@onready var code_edit: CodeEdit = %CodeEdit
var tokenizer = GDScriptTokenizer.default_tokenizer()

func _on_button_pressed():
	var tokens: Array[GDScriptToken] = []
	var cur_line := 0
	for line in code_edit.text.split("\n"):
		tokens.append_array(tokenizer.tokenize_string(line, cur_line))
		cur_line += 1

	for token in tokens:
		print(token.Type.keys()[token.type], "\t", token.string_rep)
