## Isolates comments in the script and returns them as comment
## tokens, each of which consists of one entire comment, including
## the leading #.
class_name CommentTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
    if not input_string.begins_with("#"):
        return -1

    # Find the next newline after the comment starts
    var newline_pos = input_string.find("\n", 1)
    # Return the position of the next newline. If one isn't found, we just
    # consume the rest of the string.
    return newline_pos if newline_pos != -1 else input_string.length()

func get_token_from_string(input_string: String) -> GDScriptToken:
    # We expect comments to start with a #
    if not input_string.begins_with("#"):
        return null

    # Find the next newline after the commend starts
    return GDScriptToken.new(GDScriptToken.Type.COMMENT, input_string.get_slice("\n", 0))
