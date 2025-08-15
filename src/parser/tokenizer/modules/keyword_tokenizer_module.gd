## This tokenizer module parses keywords.
class_name KeywordTokenizerModule extends TokenizerModule

# These keywords are listed in the same order as they apear in the GDScriptToken.Type enum.
const KEYWORDS: Array[String] = [
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
]

func get_token_length_from_string(input_string: String) -> int:
    var first_word = input_string.get_slice(" ", 0)
    for keyword in KEYWORDS:
        if first_word == keyword:
            return first_word.length()

    return -1

func _search_keywords(keyword: String) -> int:
    for keyword_idx in range(KEYWORDS.size()):
        if keyword == KEYWORDS[keyword_idx]:
            return keyword_idx
    return -1

func get_token_from_string(input_string: String) -> GDScriptToken:
    var token_length := get_token_length_from_string(input_string)
    var keyword := input_string.substr(0, token_length)
    var keyword_idx := _search_keywords(keyword)
    var token_type := GDScriptToken.Type.IF + keyword_idx
    return GDScriptToken.new(token_type, keyword)


