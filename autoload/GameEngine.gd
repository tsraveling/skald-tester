extends Node

signal did_receive_skald_response(response: Skald.SkaldResponse)
signal player_did_choose(choice: int, text: String)
signal did_restart

var initial_state = {}

var game_state

func get_initial_state():
	if Skald.skald_object == null or Skald.skald_object["testbeds"] == null or len(Skald.skald_object["testbeds"]) < 1:
		return {}
	print(">>> We have a testbed")
	
	# If there is a testbed, use it
	var default = Skald.skald_object["testbeds"][0]
	if default["sets"] == null:
		return {}
	print("We have sets")
	return default["sets"]

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
	emit_signal("did_restart")
	print(">>> Loading %s" % file)
	Skald.load(file)
	initial_state = get_initial_state()
	print(">>> Getting first ....")
	var response = Skald.get_first(initial_state)
	_process_response(response)	
