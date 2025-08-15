class_name WhitespaceTokenizerModule extends TokenizerModule

var current_indent_level := 0
var hard_tabs: bool = true


func get_token_length_from_string(input_string: String) -> int:
    if input_string.begins_with("\n"):
        return 1
    elif input_string.begins_with("\t"):
        hard_tabs = true
        return 1
    elif input_string.begins_with("    "):
        hard_tabs = false
        return 1
    else:
        return -1

func get_token_from_string(input_string: String) -> GDScriptToken:
    if input_string.begins_with("\n"):
        return GDScriptToken.new(GDScriptToken.Type.NEWLINE, "\n")

    if input_string.begins_with("\t"):
        return GDScriptToken.new(GDScriptToken.Type.INDENT, "\t")

    if input_string.begins_with("    "):
        return GDScriptToken.new(GDScriptToken.Type.INDENT, "    ")

    return null
