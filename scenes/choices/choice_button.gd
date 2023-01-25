extends Button

signal select_choice
var real_choice_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _pressed():
	emit_signal("select_choice", real_choice_index)
