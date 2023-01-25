extends VBoxContainer

## Called when the player selects a button
## - index: real index of button selected
signal on_select_choice

var button = preload("res://scenes/choices/choice_button.tscn")
var choice_texts = []

## Removes all existing buttons
func _remove_children():
	for n in get_children():
		remove_child(n)
		n.queue_free()


## Adds choice buttons
func _layout_choice_buttons(choices):
	
	_remove_children()
	choice_texts.clear()
	
	for choice in choices:
		var new_button = button.instantiate()
		new_button.real_choice_index = choice.real_index
		new_button.connect("select_choice",Callable(self,"_on_select_choice"))
		new_button.text = choice.text
		choice_texts.append(choice.text)
		add_child(new_button)


## Adds simple continue button
func _layout_continue_button():
	
	_remove_children()
	choice_texts.clear()
	
	var new_button = button.instantiate()
	new_button.connect("select_choice",Callable(self,"_on_select_choice"))
	new_button.text = "Continue"
	add_child(new_button)


## Called when a button is selected
func _on_select_choice(index):
	var choice_text = choice_texts[index] if len(choice_texts) > index else null
	GameEngine.make_choice(index, choice_text)


## Receives choice update signal from event bus
func _receive_response(response: Skald.SkaldResponse):
	if response.choices:
		_layout_choice_buttons(response.choices)
	else:
		_layout_continue_button()

	
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEngine.connect("did_receive_skald_response",Callable(self,"_receive_response"))
