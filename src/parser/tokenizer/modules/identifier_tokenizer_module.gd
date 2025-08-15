class_name IdentifierTokenizerModule extends TokenizerModule

func get_token_length_from_string(input_string: String) -> int:
	var word := input_string.get_slice(" ", 0)
	var token_length := word.length()
	while not word.is_valid_identifier() and token_length > 0:
		word = word.substr(0, token_length - 1)
		token_length -= 1

	if token_length == 0:
		return -1
	else:
		return token_length

func get_token_from_string(input_string: String) -> GDScriptToken:
	var token_length = get_token_length_from_string(input_string)
	if token_length != -1:
		return GDScriptToken.new(GDScriptToken.Type.IDENTIFIER, input_string.substr(0, token_length))
	else:
		return null
