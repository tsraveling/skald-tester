extends Label

func dict_to_string(state: Dictionary):
	var str = ""
	for key in state:
		str = "%s: %s\n%s" % [key, state[key], str]
	return str

func _receive_skald_response(response: Skald.SkaldResponse):
	text = "#%s (%d)\n\n%s" % [response.content.section_tag, response.updated_state.block, dict_to_string(response.updated_state.state)]

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEngine.connect("did_receive_skald_response", Callable(self, "_receive_skald_response"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
