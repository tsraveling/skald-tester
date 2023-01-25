extends Node

signal did_receive_skald_response(response: Skald.SkaldResponse)
signal player_did_choose(choice: int, text: String)

var initial_state = {
	your_name = "Decker"
}

var game_state

func make_choice(index, text):
	var response = Skald.get_next(index, game_state)
	emit_signal("player_did_choose", index, text)
	_process_response(response)

func _process_response(response: Skald.SkaldResponse):
	print(">>> Received Skald response")
	game_state = response.updated_state
	print(">>> content: %s (%d choices)" % [response.content.content, len(response.choices)])
	emit_signal("did_receive_skald_response", response)
	
func begin(file: String):
	print(">>> Loading %s" % file)
	Skald.load(file)
	print(">>> Getting first ....")
	var response = Skald.get_first(initial_state)
	_process_response(response)
