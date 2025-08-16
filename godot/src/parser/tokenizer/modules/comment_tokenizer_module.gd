## Removes comments from the token stream.
class_name CommentTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
    if not input_string.begins_with("#"):
        return -1

    # Find the next newline after the comment starts
    return input_string.find("\n", 1)

func get_token_from_string(input_string: String) -> GDScriptToken:
    # This function never actually returns a token.
    # Comments are just removed.
    return null
