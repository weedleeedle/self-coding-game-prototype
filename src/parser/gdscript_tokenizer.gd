class_name GDScriptTokenizer extends Object

static func tokenize_string(input_string: String) -> Array[GDScriptToken]:
	var tokens: Array[GDScriptToken] = []
	var cur_index := 0
	while cur_index < input_string.length():
		var token_len := GDScriptToken.get_first_token_length_from_string(input_string.substr(cur_index))
		# Move onto the next character
		if token_len == -1:
			cur_index += 1
			continue

		# Otherwise, parse the token and add it to the list of tokens.
		var token = GDScriptToken.get_token_from_string(input_string.substr(cur_index, token_len))
		tokens.push_back(token)
		cur_index += token_len

	return tokens
