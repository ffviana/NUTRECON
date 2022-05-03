extends Node2D

export(ButtonGroup) var group

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in group.get_buttons():
		i.connect("pressed",self,"button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Function to collect Responses
func button_pressed():
	print(group.get_pressed_button())

# Functions to change
func _on_Fractal1_mouse_entered():
	$Fractal2/state.set_frame(1)
	$Fractal3/state.set_frame(1)
	$Fractal4/state.set_frame(1)
	$Fractal5/state.set_frame(1)
	$Fractal6/state.set_frame(1)

func _on_Fractal1_mouse_exited():
	$Fractal2/state.set_frame(0)
	$Fractal3/state.set_frame(0)
	$Fractal4/state.set_frame(0)
	$Fractal5/state.set_frame(0)
	$Fractal6/state.set_frame(0)

func _on_Fractal2_mouse_entered():
	$Fractal1/state.set_frame(1)
	$Fractal3/state.set_frame(1)
	$Fractal4/state.set_frame(1)
	$Fractal5/state.set_frame(1)
	$Fractal6/state.set_frame(1)

func _on_Fractal2_mouse_exited():
	$Fractal1/state.set_frame(0)
	$Fractal3/state.set_frame(0)
	$Fractal4/state.set_frame(0)
	$Fractal5/state.set_frame(0)
	$Fractal6/state.set_frame(0)

func _on_Fractal3_mouse_entered():
	$Fractal1/state.set_frame(1)
	$Fractal2/state.set_frame(1)
	$Fractal4/state.set_frame(1)
	$Fractal5/state.set_frame(1)
	$Fractal6/state.set_frame(1)

func _on_Fractal3_mouse_exited():
	$Fractal1/state.set_frame(0)
	$Fractal2/state.set_frame(0)
	$Fractal4/state.set_frame(0)
	$Fractal5/state.set_frame(0)
	$Fractal6/state.set_frame(0)

func _on_Fractal4_mouse_entered():
	$Fractal1/state.set_frame(1)
	$Fractal2/state.set_frame(1)
	$Fractal3/state.set_frame(1)
	$Fractal5/state.set_frame(1)
	$Fractal6/state.set_frame(1)

func _on_Fractal4_mouse_exited():
	$Fractal1/state.set_frame(0)
	$Fractal2/state.set_frame(0)
	$Fractal3/state.set_frame(0)
	$Fractal5/state.set_frame(0)
	$Fractal6/state.set_frame(0)

func _on_Fractal5_mouse_entered():
	$Fractal1/state.set_frame(1)
	$Fractal2/state.set_frame(1)
	$Fractal3/state.set_frame(1)
	$Fractal4/state.set_frame(1)
	$Fractal6/state.set_frame(1)

func _on_Fractal5_mouse_exited():
	$Fractal1/state.set_frame(0)
	$Fractal2/state.set_frame(0)
	$Fractal3/state.set_frame(0)
	$Fractal4/state.set_frame(0)
	$Fractal6/state.set_frame(0)

func _on_Fractal6_mouse_entered():
	$Fractal1/state.set_frame(1)
	$Fractal2/state.set_frame(1)
	$Fractal3/state.set_frame(1)
	$Fractal4/state.set_frame(1)
	$Fractal5/state.set_frame(1)

func _on_Fractal6_mouse_exited():
	$Fractal1/state.set_frame(0)
	$Fractal2/state.set_frame(0)
	$Fractal3/state.set_frame(0)
	$Fractal4/state.set_frame(0)
	$Fractal5/state.set_frame(0)
