class_name NumberLiteralTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
    var word = input_string.get_slice(" ", 0)
    var token_length := word.length()

    while token_length > 0:
        if word.is_valid_int():
            return word.length()
        if word.is_valid_float():
            return word.length()
        if word.is_valid_hex_number(true):
            return word.length()
        # TODO: check for binary number since for some reason there isn't a built in function for that???
        # ---------
        # If none of these applied, see if we can produce a valid number
        # out of a smaller substring
        token_length -= 1
        word = input_string.substr(0, token_length)

    return -1



func get_token_from_string(input_string: String) -> GDScriptToken:
    var token_len = get_token_length_from_string(input_string)
    if token_len != -1:
        return GDScriptToken.new(GDScriptToken.Type.LITERAL, input_string.substr(0, token_len))

    return null
