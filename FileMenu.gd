extends MenuButton

signal did_click_load

func _select_item(id):
	match id:
		0:
			emit_signal("did_click_load")
		1:
			get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_popup().connect("id_pressed", Callable(self, "_select_item"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
