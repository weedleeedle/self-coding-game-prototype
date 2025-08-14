## Custom Syntax Highlighter designed to emulate/replicate the functionality of [class GDScriptSyntaxHighlighter]
## But it *does* allow for instantiation in game. This is basically a recreation of the
## *actual* gdscript_highlighter.cpp code but in GDScript bc why not.
class_name CodeEditorSyntaxHighlighter extends SyntaxHighlighter

const

class ColorRegion:
    enum Type {
        TYPE_NONE,
        TYPE_STRING,
        TYPE_MULTILINE_STRING,
        TYPE_COMMENT,
        TYPE_CODE_REGION
    }

    var type: Type = Type.TYPE_NONE
    var color: Color
    var start_key: String
    var end_key: String
    var line_only := false
    var r_prefix := false
    var is_string := false
    var is_comment := false

var color_regions: Array[ColorRegion]
var color_region_cache: Dictionary[int, int]
var class_names: Dictionary[StringName, Color]
var reserved_keywords: Dictionary[StringName, Color]
var member_keywords: Dictionary[StringName, Color]
var global_functions: Array[StringName]

enum Type {
    NONE,
    REGION,
    NODE_PATH,
    NODE_REF,
    ANNOTATION,
    STRING_NAME,
    SYMBOL,
    NUMBER,
    FUNCTION,
    SIGNAL,
    KEYWORD,
    MEMBER,
    IDENTIFIER,
    TYPE
}

@export var font_color: Color
@export var symbol_color: Color
@export var global_function_color: Color
@export var function_definition_color: Color
@export var built_in_type_color: Color
@export var number_color: Color
@export var member_variable_color: Color
@export var string_color: Color
@export var node_path_color: Color
@export var node_ref_color: Color
@export var annotation_color: Color
@export var string_name_color: Color
@export var type_color: Color

enum CommentMarkerLevel {
    COMMENT_MARKER_CRITICAL,
    COMMENT_MARKER_WARNING,
    COMMENT_MARKER_NOTICE,
    COMMENT_MARKER_MAX
}

@export var comment_marker_colors: Array[Color] = Array[CommentMarkerLevel.size()]
var comment_markers: Dictionary[String, CommentMarkerLevel]

func _is_symbol(p_char: int) -> bool:
    return p_char != '_'.unicode_at(0) and \
            ((p_char >= '!'.unicode_at(0) and p_char <= '/'.unicode_at(0)) or \
            (p_char >= ':'.unicode_at(0) and p_char <= '@'.unicode_at(0)) or \
            (p_char >= '['.unicode_at(0) and p_char <= '`'.unicode_at(0)) or \
            (p_char >= '{'.unicode_at(0) and p_char <= '~'.unicode_at(0)) or \
            p_char == '\t'.unicode_at(0) or \
            p_char == ' '.unicode_at(0))

func _get_line_syntax_highlighting(p_line: int) -> Dictionary:
    var color_map: Dictionary
    var next_type: Type = Type.NONE
    var current_type: Type = Type.NONE
    var prev_type: Type = Type.NONE

    var prev_text: String
    var prev_column := 0
    var prev_is_char := false
    var prev_is_digit := false
    var prev_is_binary_op := false

    var in_keyword := false
    var in_word := false
    var in_number := false
    var in_node_path := false
    var in_node_ref := false
    var in_annotation := false
    var in_string_name := false
    var is_hex_notation := false
    var is_bin_notation := false
    var in_member_variable := false
    var in_lambda := false

    var in_function_name := false
    var in_function_declaration := false
    var in_signal_declaration := false
    var is_after_func_signal_declaration := false
    var in_var_const_declaration := false
    var is_after_var_const_declaration := false
    var expect_type := false

    var in_declaration_params := 0
    var in_declaration_params_dicts := 0
    var in_type_params := 0

    var keyword_color: Color
    var color: Color

    color_region_cache[p_line] = -1
    var in_region := -1
    if p_line != 0:
        var prev_region_line := p_line - 1
        while prev_region_line > 0 and not color_region_cache.has(prev_region_line):
            prev_region_line -= 1
        for i in range(prev_region_line, p_line - 1):
            get_line_syntax_highlighting(i)

        if not color_region_cache.has(p_line - 1):
            get_line_syntax_highlighting(p_line - 1)

        in_region = color_region_cache[p_line - 1]

    var line := get_text_edit().get_line_with_ime(p_line)
    var line_length = str.length()
    var prev_color: Color

    if in_region != -1 and line_length == 0:
        color_region_cache[p_line] = in_region

    for j in range(line_length):
        var highlighter_info: Dictionary

        color = font_color
        var is_char := !_is_symbol(line.unicode_at(j))
        var is_a_symbol := _is_symbol(line.unicode_at(j))
        var is_a_digit = line[j].is_valid_int()
        var is_binary_op := false

        if is_a_symbol or in_region != -1:
            var from := j

            if in_region == -1:
                while from < line_length:
                    if line.unicode_at(from) == '\\'.unicode_at(0):
                        from += 2
                        continue
                    break

            if from != line_length:
                if in_region == -1:
                    var r_prefix := from > 0 and line.unicode_at(from - 1) == 'r'.unicode_at(0)
                    for c in range(color_regions.size()):
                        var chars_left: int = line_length - from
                        var start_key_length = color_regions[c].start_key.length()
                        var end_key_length = color_regions[c].end_key.length()
                        if chars_left < start_key_length:
                            continue

                        if color_regions[c].is_string and color_regions[c].r_prefix != r_prefix:
                            continue

                        var is_match := true
                        var start_key := color_regions[c].start_key
                        for k in range(start_key_length):
                            if start_key.unicode_at(k) != line.unicode_at(from + k):
                                is_match = false
                                break

                        if color_regions[c].type == ColorRegion.Type.TYPE_CODE_REGION:
                            var line_stripped_split = line.strip_edges().split(" ", false, 1)
                            if not line_stripped_split.is_empty() and line_stripped_split[0] != "#region" and line_stripped_split[0] != "#endregion":
                                is_match = false

                            if !is_match:
                                continue

                            in_region = c
                            from += start_key_length

                            if end_key_length == 0 or color_regions[c].line_only or from + end_key_length > line_length:
                                if line.find('\\', from) >= 0:
                                    break

                            prev_color = color_regions[in_region].color
                            highlighter_info["color"] = color_regions[c].color
                            color_map[j] = highlighter_info

                            j = line_length
                            if not color_regions[c].line_only:
                                color_region_cache[p_line] = c

                        break

                    if j == line_length and !color_regions[in_region].is_comment:
                        continue


                if in_region != -1:
                    var region_color: Color = color_regions[in_region].color
                    if in_node_path and color_regions[in_region].type == ColorRegion.Type.TYPE_STRING:
                        region_color = node_path_color

                    if in_node_ref and color_regions[in_region].type == ColorRegion.Type.TYPE_STRING:
                        region_color = node_ref_color

                    if in_string_name and color_regions[in_region].type == ColorRegion.Type.TYPE_STRING:
                        region_color = string_name_color

                    prev_color = region_color
                    highlighter_info["color"] = region_color
                    color_map[j] = highlighter_info

                    if color_regions[in_region].is_comment:
                        var marker_start_pos := from
                        var marker_len := 0
                        while from <= line_length:
                            if from < line_length and BSearchUtil.bsearch_util_range(line[from], BSearchUtil.xid_continue):
                                marker_len += 1
                            else:
                                if marker_len > 0:
                                    var E := comment_markers.find(line.substr(marker_start_pos, marker_len))
                                    if E != -1:
                                        var marker_highlighter_info: Dictionary
                                        marker_highlighter_info["color"] = comment_marker_colors[E]
                                        color_map[marker_start_pos] = marker_highlighter_info
                                        var marker_continue_highligher_info: Dictionary
                                        marker_continue_highligher_info["color"] = region_color
                                        color_map[from] = marker_continue_highligher_info
                                marker_start_pos = from + 1
                                marker_len = 0
                            from += 1

                        from = line_length - 1
                        j = from
                    else:
                        # Left off on line 243 lmao






