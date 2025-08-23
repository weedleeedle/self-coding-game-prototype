class_name AnnotationTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
    if input_string.begins_with("@"):
        # Find the first space ig.
        return input_string.find(" ", 0)

    return -1

func get_token_from_string(input_string: String) -> GDScriptToken:
    var length = get_token_length_from_string(input_string)
    if length == -1:
        length = input_string.length()

    var token = GDScriptToken.new(GDScriptToken.Type.ANNOTATION, input_string.substr(0, length))
    return token
