class_name GDScriptTokenizer extends RefCounted

var tokenizer_modules: Array[TokenizerModule] = []

func register_module(tokenizer_module: TokenizerModule) -> void:
	tokenizer_modules.push_back(tokenizer_module)

static func default_tokenizer() -> GDScriptTokenizer:
	var tokenizer := GDScriptTokenizer.new()
	# Put tokenizer modules in order of priority. This only mattters for things like plain words which can be keywords OR identifiers.
	tokenizer.register_module(WhitespaceTokenizerModule.new())
	tokenizer.register_module(StringTokenizerModule.new())
	tokenizer.register_module(CommentTokenizerModule.new())
	tokenizer.register_module(KeywordTokenizerModule.new())
	tokenizer.register_module(NumberLiteralTokenizerModule.new())
	tokenizer.register_module(SymbolTokenizerModule.new())
	tokenizer.register_module(IdentifierTokenizerModule.new())
	return tokenizer

func tokenize_string(input_string: String, line_num: int) -> Array[GDScriptToken]:
	var tokens: Array[GDScriptToken] = []
	var cur_index := 0
	while cur_index < input_string.length():
		var selected_tokenizer_module = null
		var cur_token_length := -1
		for tokenizer_module in tokenizer_modules:
			cur_token_length = tokenizer_module.get_token_length_from_string(input_string.substr(cur_index))
			if cur_token_length != -1:
				selected_tokenizer_module = tokenizer_module
				break

		# If no tokenizer module could handle the given token, just discard the first character and move
		# onto the next one.
		if selected_tokenizer_module == null:
			cur_index += 1
			continue

		# Otherwise, parse the token and add it to the list of tokens.
		var token = selected_tokenizer_module.get_token_from_string(input_string.substr(cur_index, cur_token_length))
		if token != null:
			# TODO: multi-line tokens... which might only be multiline string literals??? don't think any other tokens can span multiple lines...
			token.start_line = line_num
			token.end_line = line_num
			token.start_column = cur_index
			token.end_column = cur_index + cur_token_length
			tokens.push_back(token)
		cur_index += cur_token_length

	return tokens
