class_name StringTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
    if not (input_string.begins_with("\"") or input_string.begins_with("\'")):
        return -1


    # whether the string starts with a " or '.
    var quote_char = input_string[0]
    # Find the string's matching counterpart and ignore escaped string chars.

    var ending_quote_index := input_string.find(quote_char, 1)
    # check for whether or not this string is escaped
    while ending_quote_index != -1 and input_string[ending_quote_index - 1] == "\\":
        # Find the next " or ' instead
        ending_quote_index = input_string.find(quote_char, ending_quote_index)

    if ending_quote_index == -1:
        # Whoops, this is a bad string. Whatever we'll just tokenize the whole thing ig
        return input_string.length()

    # Add 1 to include both starting and ending quotes
    return ending_quote_index + 1

func get_token_from_string(input_string: String) -> GDScriptToken:
    var length := get_token_length_from_string(input_string)
    return GDScriptToken.new(GDScriptToken.Type.LITERAL, input_string.substr(0, length))
