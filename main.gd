extends Control

const FILE_DIALOG_SIZE = Vector2(800,400)

@onready var file_dialog = $FileDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_select_file(path):
	Skald.load(path)
	

func _on_menu_load():
	file_dialog.popup_centered(FILE_DIALOG_SIZE)
