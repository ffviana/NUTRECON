extends AnimatedSprite



#onready var button = get_parent()
#onready var buttonSize = button.get_size()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	# Fractals scales
	# self.scale.x = 1.025
	# self.scale.y = 1.025
	# Shapes scale
	self.scale.x = 1.615
	self.scale.y = 1.595
	self.position.y = 0
	self.position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
