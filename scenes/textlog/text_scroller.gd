extends ScrollContainer

var text_chunk = preload("res://scenes/textlog/text_chunk.tscn")
var choice_chunk = preload("res://scenes/textlog/choice_chunk.tscn")

@onready var _scrollbar = get_v_scroll_bar()
@onready var _text_list = $MarginContainer/TextList


## Waits 100ms, then scrolls to bottom.
func _scroll_to_bottom():
	await get_tree().create_timer(.1).timeout
	self.scroll_vertical = _scrollbar.max_value
	
	
## Adds a new choice chunk describing the player's choice
func _add_choice(body):
	var chunk = choice_chunk.instantiate()
	if not chunk:
		print(">>> TEXT CHUNK FAILED")
	chunk.body = body
	_text_list.add_child(chunk)


## Receive signal to add text
func _receive_response(response: Skald.SkaldResponse):
	var content: Skald.SkaldContent = response.content
	var chunk = text_chunk.instantiate()
	if not chunk:
		print(">>> TEXT CHUNK FAILED")
	chunk.content = content
	_text_list.add_child(chunk)
	_scroll_to_bottom()
	

## Receive player choice to add text if it's not just continue
func _receive_player_choice(index, choice_text):
	if choice_text != null:
		_add_choice(choice_text)
	_scroll_to_bottom()

func _on_restart():
	for n in _text_list.get_children():
		_text_list.remove_child(n)
		n.queue_free()
	self.scroll_vertical = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEngine.connect("did_receive_skald_response", Callable(self, "_receive_response"))
	GameEngine.connect("player_did_choose", Callable(self,"_receive_player_choice"))
	GameEngine.connect("did_restart", Callable(self, "_on_restart"))
