class_name GDScriptToken extends Object

const TOKEN_NAMES: Array[String] = [
	#"Empty",  # EMPTY,
	# Basic
	#"Annotation",  # ANNOTATION
	#"Identifier", # IDENTIFIER,
	#"Literal", # LITERAL,
	# Comparison
	"<", # LESS,
	"<=", # LESS_EQUAL,
	">", # GREATER,
	">=", # GREATER_EQUAL,
	"==", # EQUAL_EQUAL,
	"!=", # BANG_EQUAL,
	# Logical
	"and", # AND,
	"or", # OR,
	"not", # NOT,
	"&&", # AMPERSAND_AMPERSAND,
	"||", # PIPE_PIPE,
	"!", # BANG,
	# Bitwise
	"&", # AMPERSAND,
	"|", # PIPE,
	"~", # TILDE,
	"^", # CARET,
	"<<", # LESS_LESS,
	">>", # GREATER_GREATER,
	# Math
	"+", # PLUS,
	"-", # MINUS,
	"*", # STAR,
	"**", # STAR_STAR,
	"/", # SLASH,
	"%", # PERCENT,
	# Assignment
	"=", # EQUAL,
	"+=", # PLUS_EQUAL,
	"-=", # MINUS_EQUAL,
	"*=", # STAR_EQUAL,
	"**=", # STAR_STAR_EQUAL,
	"/=", # SLASH_EQUAL,
	"%=", # PERCENT_EQUAL,
	"<<=", # LESS_LESS_EQUAL,
	">>=", # GREATER_GREATER_EQUAL,
	"&=", # AMPERSAND_EQUAL,
	"|=", # PIPE_EQUAL,
	"^=", # CARET_EQUAL,
	# Control flow
	"if", # IF,
	"elif", # ELIF,
	"else", # ELSE,
	"for", # FOR,
	"while", # WHILE,
	"break", # BREAK,
	"continue", # CONTINUE,
	"pass", # PASS,
	"return", # RETURN,
	"match", # MATCH,
	"when", # WHEN,
	# Keywords
	"as", # AS,
	"assert", # ASSERT,
	"await", # AWAIT,
	"breakpoint", # BREAKPOINT,
	"class", # CLASS,
	"class_name", # CLASS_NAME,
	"const", # TK_CONST,
	"enum", # ENUM,
	"extends", # EXTENDS,
	"func", # FUNC,
	"in", # TK_IN,
	"is", # IS,
	"namespace", # NAMESPACE
	"preload", # PRELOAD,
	"self", # SELF,
	"signal", # SIGNAL,
	"static", # STATIC,
	"super", # SUPER,
	"trait", # TRAIT,
	"var", # VAR,
	"void", # TK_VOID,
	"yield", # YIELD,
	# Punctuation
	"[", # BRACKET_OPEN,
	"]", # BRACKET_CLOSE,
	"{", # BRACE_OPEN,
	"]", # BRACE_CLOSE,
	"(", # PARENTHESIS_OPEN,
	")", # PARENTHESIS_CLOSE,
	",", # COMMA,
	";", # SEMICOLON,
	".", # PERIOD,
	"..", # PERIOD_PERIOD,
	"...", # PERIOD_PERIOD_PERIOD,
	":", # COLON,
	"$", # DOLLAR,
	"->", # FORWARD_ARROW,
	"_", # UNDERSCORE,
	# Whitespace
	#"Newline", # NEWLINE,
	#"Indent", # INDENT,
	#"Dedent", # DEDENT,
	# Constants
	"PI", # CONST_PI,
	"TAU", # CONST_TAU,
	"INF", # CONST_INF,
	"NaN", # CONST_NAN,
	# Error message improvement
	#"VCS conflict marker", # VCS_CONFLICT_MARKER,
	"`", # BACKTICK,
	"?", # QUESTION_MARK,
	# Special
	#"Error", # ERROR,
	#"End of file", # EOF,
];

enum Type {
	# Comparison
	LESS,
	LESS_EQUAL,
	GREATER,
	GREATER_EQUAL,
	EQUAL_EQUAL,
	BANG_EQUAL,
	# Logical
	AND,
	OR,
	NOT,
	AMPERSAND_AMPERSAND,
	PIPE_PIPE,
	BANG,
	# Bitwise
	AMPERSAND,
	PIPE,
	TILDE,
	CARET,
	LESS_LESS,
	GREATER_GREATER,
	# Math
	PLUS,
	MINUS,
	STAR,
	STAR_STAR,
	SLASH,
	PERCENT,
	# Assignment
	EQUAL,
	PLUS_EQUAL,
	MINUS_EQUAL,
	STAR_EQUAL,
	STAR_STAR_EQUAL,
	SLASH_EQUAL,
	PERCENT_EQUAL,
	LESS_LESS_EQUAL,
	GREATER_GREATER_EQUAL,
	AMPERSAND_EQUAL,
	PIPE_EQUAL,
	CARET_EQUAL,
	# Control flow
	IF,
	ELIF,
	ELSE,
	FOR,
	WHILE,
	BREAK,
	CONTINUE,
	PASS,
	RETURN,
	MATCH,
	WHEN,
	# Keywords
	AS,
	ASSERT,
	AWAIT,
	BREAKPOINT,
	CLASS,
	CLASS_NAME,
	TK_CONST, # Conflict with WinAPI.
	ENUM,
	EXTENDS,
	FUNC,
	TK_IN, # Conflict with WinAPI.
	IS,
	NAMESPACE,
	PRELOAD,
	SELF,
	SIGNAL,
	STATIC,
	SUPER,
	TRAIT,
	VAR,
	TK_VOID, # Conflict with WinAPI.
	YIELD,
	# Punctuation
	BRACKET_OPEN,
	BRACKET_CLOSE,
	BRACE_OPEN,
	BRACE_CLOSE,
	PARENTHESIS_OPEN,
	PARENTHESIS_CLOSE,
	COMMA,
	SEMICOLON,
	PERIOD,
	PERIOD_PERIOD,
	PERIOD_PERIOD_PERIOD,
	COLON,
	DOLLAR,
	FORWARD_ARROW,
	UNDERSCORE,
	# Constants
	CONST_PI,
	CONST_TAU,
	CONST_INF,
	CONST_NAN,
	# These are extra tokens that do not correspond to
	# The symbols defined in TOKEN_NAMES.
	EMPTY,
	# Basic
	ANNOTATION,
	IDENTIFIER,
	LITERAL,
	# Whitespace
	NEWLINE,
	INDENT,
	DEDENT,
	# Error message improvement
	VCS_CONFLICT_MARKER,
	BACKTICK,
	QUESTION_MARK,
	# Special
	ERROR,
	TK_EOF, # "EOF" is reserved
	TK_MAX
};

## The type of token this represents.
var type: Type

## The underlying string that makes up this token
var string_rep: String

var start_line: int = 0
var end_line: int = 0
var start_column: int = 0
var end_column: int = 0

## This regex is used to check for strings
static var _string_regex: RegEx = RegEx.new()

func _init(p_type: Type, p_string_rep: String):
	type = p_type
	string_rep = p_string_rep


static func get_first_token_length_from_string(input_string: String) -> int:
	# Compile the string regex if it isn't compiled yet.
	if not _string_regex.is_valid():
		_string_regex.compile(r"^r?(\"{3}|'{3}|\"|'){1}.*\1")

	# If the provided string starts with a string literal, we consume the entire thing as a token.
	var _string_regex_results = _string_regex.search(input_string)
	if _string_regex_results != null:
		# This should be the same as the length of the string???
		return _string_regex_results.get_end()

	# Otherwise we are NOT in a string, we want to grab up until the next whitespace and see if it's a valid token, and if not we work our way down.
	var input_word: String = input_string.get_slice(" ", 0)
	for i in range(input_word.length(), 0, -1):
		# If we ever produce a valid token, we return the length of that token.
		if get_token_from_string(input_word.substr(0, i)) != null:
			return i

	# If both of these steps fail, I think we just return -1?
	return -1

static func get_token_from_string(input_string: String) -> GDScriptToken:
	var token_name_index := TOKEN_NAMES.find(input_string)
	if token_name_index != -1:
		return GDScriptToken.new(token_name_index, input_string)
	# If this isn't a keyword or a predefined symbol,
	# We have to like... search for class names or whatever.
	else:
		# Anything that starts with an @ is an annotation.
		# TODO: check for valid annotation? We can't get the list of annotations via code but we could probably write a list ourselves if we really wanted to.
		if input_string[0] == "@" and input_string.substr(1).is_valid_unicode_identifier():
			return GDScriptToken.new(Type.ANNOTATION, input_string)

		if input_string.is_valid_int():
			return GDScriptToken.new(Type.LITERAL, input_string)

		if input_string.is_valid_float():
			return GDScriptToken.new(Type.LITERAL, input_string)

		if input_string.is_valid_hex_number():
			return GDScriptToken.new(Type.LITERAL, input_string)

		if not _string_regex.is_valid():
			_string_regex.compile(r"^r?(\"{3}|'{3}|\"|'){1}.*\1")
		if _string_regex.search(input_string) != null:
			return GDScriptToken.new(Type.LITERAL, input_string)

		match(input_string):
			"null":
				return GDScriptToken.new(Type.LITERAL, input_string)
			"false":
				return GDScriptToken.new(Type.LITERAL, input_string)
			"true":
				return GDScriptToken.new(Type.LITERAL, input_string)

		if input_string.is_valid_unicode_identifier():
			return GDScriptToken.new(Type.IDENTIFIER, input_string)

		return null
