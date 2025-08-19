class_name CustomGDScriptSyntaxHighlighter extends SyntaxHighlighter

var default_color: Color = Color(1,1,1)
var text_edit : TextEdit
var tokenizer = GDScriptTokenizer.default_tokenizer()

func _get_line_syntax_highlighting(line_num: int) -> Dictionary:
    text_edit = get_text_edit()
    default_color = get_text_edit().get_theme_color("font_color")
    var color_dict: Dictionary = {}
    var line_str := text_edit.get_line_with_ime(line_num)

    var tokens = tokenizer.tokenize_string(line_str, line_num)
    var cur_token_index := 0
    while cur_token_index < tokens.size():
        var token: GDScriptToken = tokens[cur_token_index]

        if token.is_comment():
            _add_color_to_dict(color_dict, token, text_edit.get_theme_color("comment_color"))
            cur_token_index += 1
            continue

        if token.is_keyword():
            _add_color_to_dict(color_dict, token, text_edit.get_theme_color("keyword_color"))
            cur_token_index += 1
            continue

        if token.is_string():
            _add_color_to_dict(color_dict, token, text_edit.get_theme_color("string_color"))
            cur_token_index += 1
            continue

        if token.is_literal() and not token.is_string():
            _add_color_to_dict(color_dict, token, text_edit.get_theme_color("number_color"))
            cur_token_index += 1
            continue

        if token.is_symbol():
            _add_color_to_dict(color_dict, token, text_edit.get_theme_color("symbol_color"))
            cur_token_index += 1
            continue

        if token.is_identifier():
            cur_token_index = _handle_identifier(color_dict, tokens, cur_token_index)
            continue

        cur_token_index += 1

    color_dict.sort()
    return color_dict

# This function handles parsing any identifiers we find.
# Returns the next cur_token_index.
func _handle_identifier(color_dict: Dictionary, tokens: Array[GDScriptToken], cur_token_index: int) -> int:

    # Most obvious case, if the next token is a ( symbol, this is a function.
    # (Ig it could also be a class, WHOOPS)
    if cur_token_index + 1 < tokens.size() and tokens[cur_token_index + 1].type == GDScriptToken.Type.PARENTHESIS_OPEN:
        _add_color_to_dict(color_dict, tokens[cur_token_index], text_edit.get_theme_color("function_color"))
        return cur_token_index + 1

    else:
        return cur_token_index + 1

func _add_color_to_dict(color_dict: Dictionary, token: GDScriptToken, color: Color) -> void:
    color_dict.set(
        token.start_column,
        {
            "color": color,
        }
    )
    color_dict.set(
        token.end_column,
        {
            "color": default_color,
        }
    )
