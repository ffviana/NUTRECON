extends Node2D

# Declare member variables here. Examples:
var ans: int
var answers: Array
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ITI.visible = true
	$Fractals.visible = false
	$ITI/RichTextLabel.visible = false

#	for i in group.get_buttons():
#		i.connect("pressed",self,"button_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		save(answers)
		get_tree().quit()

func save(content):
	var file = File.new()
	file.open("res://save_exp.json", File.WRITE) # Change NAME to somessing usefol
	file.store_line(JSON.print(content))
	file.close()

func popupConfirmation():
	$TEXT1.visible = false
	$ConfirmationQuestion.visible = true

func startITI():
	$Fractals.visible = false
	$ITI/RichTextLabel.visible = true
	$ITI.visible = true

func startTrial():
	$IntroMessage.visible = false
	$ITI.visible = false
	$ConfirmationQuestion.visible = false
	$Fractals.visible = true
	$TEXT1.visible = true
	$Fractals/Fractal1/state.set_frame(0)
	$Fractals/Fractal2/state.set_frame(0)
	$Fractals/Fractal3/state.set_frame(0)
	$Fractals/Fractal4/state.set_frame(0)
	$Fractals/Fractal5/state.set_frame(0)
	$Fractals/Fractal6/state.set_frame(0)

func _on_Fractal1_pressed():
	ans = 1
	popupConfirmation()
	$Fractals/Fractal2/state.set_frame(1)
	$Fractals/Fractal3/state.set_frame(1)
	$Fractals/Fractal4/state.set_frame(1)
	$Fractals/Fractal5/state.set_frame(1)
	$Fractals/Fractal6/state.set_frame(1)

func _on_Fractal2_pressed():
	ans = 2
	popupConfirmation()
	$Fractals/Fractal1/state.set_frame(1)
	$Fractals/Fractal3/state.set_frame(1)
	$Fractals/Fractal4/state.set_frame(1)
	$Fractals/Fractal5/state.set_frame(1)
	$Fractals/Fractal6/state.set_frame(1)

func _on_Fractal3_pressed():
	ans = 3
	popupConfirmation()
	$Fractals/Fractal1/state.set_frame(1)
	$Fractals/Fractal2/state.set_frame(1)
	$Fractals/Fractal4/state.set_frame(1)
	$Fractals/Fractal5/state.set_frame(1)
	$Fractals/Fractal6/state.set_frame(1)

func _on_Fractal4_pressed():
	ans = 4
	popupConfirmation()
	$Fractals/Fractal1/state.set_frame(1)
	$Fractals/Fractal2/state.set_frame(1)
	$Fractals/Fractal3/state.set_frame(1)
	$Fractals/Fractal5/state.set_frame(1)
	$Fractals/Fractal6/state.set_frame(1)

func _on_Fractal5_pressed():
	ans = 5
	popupConfirmation()
	$Fractals/Fractal1/state.set_frame(1)
	$Fractals/Fractal2/state.set_frame(1)
	$Fractals/Fractal3/state.set_frame(1)
	$Fractals/Fractal4/state.set_frame(1)
	$Fractals/Fractal6/state.set_frame(1)

func _on_Fractal6_pressed():
	ans = 6
	popupConfirmation()
	$Fractals/Fractal1/state.set_frame(1)
	$Fractals/Fractal2/state.set_frame(1)
	$Fractals/Fractal3/state.set_frame(1)
	$Fractals/Fractal4/state.set_frame(1)
	$Fractals/Fractal5/state.set_frame(1)


func _on_Yes_pressed():
	answers.append(ans)
	startITI()

func _on_No_pressed():
	startTrial()

func _on_fixationButton_pressed():
	startTrial()
