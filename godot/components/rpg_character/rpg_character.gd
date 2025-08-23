extends CharacterBody2D

## Time in seconds to show a line of text above the player's head
@export var thinking_show_time: float = 2.0

## How far the player can be from an interactable for it to count.
@export var max_distance_to_interactable: float = 100.0

const SPEED = 300.0

@onready var thinking_label: Label = %ThinkingLabel

func _ready() -> void:
	think("Hi :3")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("edit"):
		edit()

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * SPEED

	move_and_slide()

## Returns the nearest ProximityCodableComponent, or null if none were found close enough.
func _get_nearest_codable_component() -> ProximityCodableComponent:
	var threshold = pow(max_distance_to_interactable, 2.0)
	print(threshold)
	for node in get_tree().get_nodes_in_group("editable"):
		print(node.global_position.distance_squared_to(global_position))

	var close_nodes = get_tree().get_nodes_in_group("editable") \
			.filter(func (node): return node.global_position.distance_squared_to(global_position) <= threshold)

	print(close_nodes)

	if close_nodes.is_empty():
		return null

	var closest_node: Node2D = close_nodes[0]
	var closest_node_distance: float = closest_node.global_position.distance_squared_to(global_position)
	for node in close_nodes:
		var new_distance: float = node.global_position.distance_squared_to(global_position)
		if new_distance < closest_node_distance:
			closest_node = node
			closest_node_distance = new_distance

	return closest_node

func edit() -> void:
	var codable: ProximityCodableComponent = _get_nearest_codable_component()
	if codable == null:
		return

	codable.edit()

func think(text: String) -> void:
	var vert_margin := 32
	thinking_label.text = text
	# Center label above player
	thinking_label.position.x = -thinking_label.size.x / 2
	thinking_label.position.y = -thinking_label.size.y - vert_margin
	thinking_label.show()
	await create_tween().tween_interval(thinking_show_time).finished
	thinking_label.hide()
