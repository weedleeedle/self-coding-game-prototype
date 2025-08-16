## Base class for TokenizerModules which the [class GDScriptTokenizer] uses to parse code into tokens.
class_name TokenizerModule extends Object

## The [class GDScriptTokenizer] will pass the entire input string
## to each tokenizer module in turn until one of them says it can handle
## the input string.
##
## This function is expected to return the length of the token that it wants.
##
## If the module cannot handle the given starting string, it should return -1.
func get_token_length_from_string(input_string: String) -> int:
    return -1

## This function is called after [method get_token_length_from_string] to
## parse the actual input string. Instead of being given the entire input string,
## the function will only be given the substring given by the length returned from [method get_token_length_from_string].
##
## The [class GDScriptTokenizer] will check for null, so it is possible to discard a token here, but it is not advised.
## The only time you might want to do that is with the CommentTokenizer,
## which wants to consume the entire comment but doesn't actually return a token with it.
func get_token_from_string(input_string: String) -> GDScriptToken:
    return null
