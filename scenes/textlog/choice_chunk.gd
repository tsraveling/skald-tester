extends RichTextLabel

@export var body = "Lorem ipsum"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "[right]%s[/right]" % body
