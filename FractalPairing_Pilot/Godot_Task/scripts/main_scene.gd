extends Node2D

# Create other file to save missed attempts

var ans: int
var sub_id: String
var sub_dataPath: String
var answers: Dictionary

var Fractal_misPress = []
var Trial = 0
var ChoiceTimestamp = OS.get_unix_time()

var dateTime = OS.get_datetime()
var year = dateTime.year;
var month = dateTime.month;
var day = dateTime.day;
var hour = dateTime.hour;
var minute = dateTime.minute;


# Called whenever a Fractal is pressed
func _Fractal_pressed(which):
	# Holds answer for until confirmation
	ans = which.get_index() 
	ChoiceTimestamp = OS.get_unix_time()
	
	# Goes through Fractal Buttons
	for i in $Fractals.get_children():
		if i != which:
			i.get_child(0).set_frame(1) # Changes Fractal State
	fractalDisable()
	popupConfirmation()

# Called when the node enters the scene tree for the first time.
func _ready():
	$SubjectID.visible = true
	answers = {'User': [],'Trial': [], 'Fractal misPress':[],'Choice Timestamp': [], 'Confirmation Timestamp': [],'Value': []}
	$IntroMessage.visible = false
	$ITI/Background.visible = true
	$ITI/RichTextLabel.visible = false
	# Connect all Fractal buttons 
	for b in $Fractals.get_children(): 
		b.connect("pressed", self, "_Fractal_pressed",[b])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Esc to Exit Program
	if Input.is_action_pressed("ui_cancel"):
		save(answers, sub_dataPath)
		get_tree().quit()

func save(content, sub_id):
	var file = File.new()
	file.open( str(sub_id), File.WRITE) # Change NAME to somessing usefol
	file.store_line(to_json(content))
	file.close()

func popupConfirmation():
	$TEXT1.visible = false
	$ConfirmationQuestion.visible = true
	fractalDisable()

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
	fractalEnable()

func fractalDisable():
	for i in $Fractals.get_children():
		i.disabled = true

func fractalEnable():
	for i in $Fractals.get_children():
		i.disabled = false
		i.get_child(0).set_frame(0)

func _on_Yes_pressed():
	Trial += 1
	answers["User"].push_back(Trial)
	answers["Trial"].push_back(Trial)
	answers["Fractal misPress"].push_back(Fractal_misPress)
	answers["Choice Timestamp"].push_back(OS.get_unix_time())
	answers["Confirmation Timestamp"].push_back(OS.get_unix_time())
	answers["Value"].push_back(ans)
	startITI()

func _on_No_pressed():
	Fractal_misPress.append(ans)
	startTrial()

func _on_fixationButton_pressed():
	startTrial()

func _on_LineEdit_text_entered(new_text):
	sub_id = "ercffa_%03d" % int(new_text)
	sub_dataPath = "user://%s_%02d-%02d-%s_%02d-%02d.json" % [sub_id, day, month, year, hour, minute]
	print(sub_dataPath)
	$ITI.visible = true
	$IntroMessage.visible = true
	$Fractals.visible = false
	$ITI/RichTextLabel.visible = false
	$SubjectID.visible = false



