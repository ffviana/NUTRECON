extends LineEdit


# Declare member variables here. Examples:
var regex = RegEx.new()
var oldtext = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	regex.compile("^[0-9]*$")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		text = new_text   
		oldtext = text
	else:
		text = oldtext
	set_cursor_position(text.length())

func get_value():
	return(int(text))
