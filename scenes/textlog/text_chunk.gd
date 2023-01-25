extends VBoxContainer

var content: Skald.SkaldContent

@onready var text_body = $MarginContainer/TextBody
@onready var attribution_label = $Attribution

# Called when the node enters the scene tree for the first time.
func _ready():
	print(">>> text_chunk start")
	if content == null:
		print(">>> no content")
		return
	attribution_label.text = content.attribution_tag
	text_body.text = content.content
