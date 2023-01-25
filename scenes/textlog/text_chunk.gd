extends HBoxContainer

@export var body = "Lorem ipsum"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextBody.text = body
