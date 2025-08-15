class_name SymbolTokenizerModule extends TokenizerModule

const SYMBOLS: Array[String] = [
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
]

func get_token_length_from_string(input_string: String) -> int:
    var symbol_index = _get_symbol_index_from_string(input_string)
    if symbol_index != -1:
        return SYMBOLS[symbol_index].length()

    return -1

func get_token_from_string(input_string: String) -> GDScriptToken:
    var symbol_index = _get_symbol_index_from_string(input_string)
    if symbol_index == -1:
        return null

    var symbol_type = GDScriptToken.Type.LESS + symbol_index
    var symbol_length = SYMBOLS[symbol_index].length()
    return GDScriptToken.new(symbol_type, input_string.substr(0, symbol_length))

func _get_symbol_index_from_string(input_string: String) -> int:
    var token = input_string.get_slice(" ", 0)
    var token_length := token.length()
    var symbol_index = SYMBOLS.find(token)
    # This isn't a valid symbol.
    while symbol_index == -1 and token_length >= 1:
        # Attempt to shrink the token and see if the subset
        # is a valid symbol
        token_length -= 1
        token = input_string.substr(0, token_length)
        symbol_index = SYMBOLS.find(token)

    return symbol_index

