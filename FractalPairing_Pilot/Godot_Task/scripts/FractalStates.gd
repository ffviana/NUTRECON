extends AnimatedSprite



#onready var button = get_parent()
#onready var buttonSize = button.get_size()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale.x = 1.01
	self.scale.y = 1.01
	self.position.y = 0
	self.position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
