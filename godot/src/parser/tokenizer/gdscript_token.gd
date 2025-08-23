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
    # Yes, we don't *really* parse comments, but we do want to include them in the token stream
    # for syntax highlighting purposes.
    COMMENT,
    # Whitespace
    NEWLINE,
    INDENT,
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
# This is actually the first column that ISN'T the token. It's exclusive, not inclusive.
var end_column: int = 0

func _init(p_type: Type, p_string_rep: String):
    type = p_type
    string_rep = p_string_rep

## Returns true if this token is a keyword (i.e "for", "match", etc.)
func is_keyword() -> bool:
    return type >= Type.IF && type <= Type.YIELD

## A string is a literal that starts with a ' or " p much
func is_string() -> bool:
    return type == Type.LITERAL and (string_rep[0] == "\"" or string_rep[0] == "\'")

## Is this a literal? NOTE THAT STRINGS ARE LITERALS BUT ALSO THEIR OWN THING
## (specifically for like, syntax highlighting)
func is_literal() -> bool:
    return type == Type.LITERAL

func is_symbol() -> bool:
    return (type >= Type.LESS and type <= Type.CARET_EQUAL) or \
            (type >= Type.BRACKET_OPEN and type <= Type.UNDERSCORE)

func is_identifier() -> bool:
    return type == Type.IDENTIFIER

func is_comment() -> bool:
    return type == Type.COMMENT

func is_whitespace() -> bool:
    return type == Type.NEWLINE or type == Type.INDENT
