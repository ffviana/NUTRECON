extends Node2D

var ans: int	# Var to save Fractal Answer
var sub_id: String
var sub_dataPath: String
var sub_dataPath_incorrectChoices: String
var answers: Dictionary	# Var to save  Confirmed answers 
var wrongAnswers: Dictionary # # Var to save Mis-clicks

var Trial = 0	# Trial id
var ChoiceTimestamp: int

# Variables to creat file ID
var dateTime = OS.get_datetime()
var year = dateTime.year;
var month = dateTime.month;
var day = dateTime.day;
var hour = dateTime.hour;
var minute = dateTime.minute;


# Called when the node enters the scene tree for the first time.
func _ready():
	$SubjectID.visible = true
	answers = {'User': [],
				'Trial': [], 
				'Choice Timestamp': [], 
				'Confirmation Timestamp': [],
				'Fractal ID': []}
	wrongAnswers = {'User': [],
				'Trial': [], 
				'Wrong Choice Timestamp': [], 
				'Denial Timestamp': [],
				'Fractal ID': []}
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
		save(wrongAnswers, sub_dataPath_incorrectChoices)
		get_tree().quit()


func save(content, sub_id):
	var file = File.new()
	file.open( str(sub_id), File.WRITE) # Change NAME to somessing usefol
	file.store_line(to_json(content))
	file.close()

# Called whenever a Fractal is pressed
func _Fractal_pressed(which):
	ans = which.get_index() 				# Holds answer for confirmation
	ChoiceTimestamp = OS.get_unix_time()	# Hods click timestamp
	
	for i in $Fractals.get_children():	# Goes through Fractal Buttons
		if i != which:	
			i.get_child(0).set_frame(1) # Changes non-clicked Fractals to Grey View
	fractalDisable()
	popupConfirmation()

func popupConfirmation():
	$TEXT1.visible = false
	$ConfirmationQuestion.visible = true
	fractalDisable()

func _on_Yes_pressed():
	Trial += 1
	answers["User"].push_back(sub_id)
	answers["Trial"].push_back(Trial)
	answers["Choice Timestamp"].push_back(ChoiceTimestamp)
	answers["Confirmation Timestamp"].push_back(OS.get_unix_time())
	answers["Fractal ID"].push_back(ans)
	startITI()

func startITI():
	$Fractals.visible = false
	$ITI/RichTextLabel.visible = true
	$ITI.visible = true

func _on_No_pressed():
	wrongAnswers["User"].push_back(sub_id)
	wrongAnswers["Trial"].push_back(Trial)
	wrongAnswers["Wrong Choice Timestamp"].push_back(ChoiceTimestamp)
	wrongAnswers["Denial Timestamp"].push_back(OS.get_unix_time())
	wrongAnswers["Fractal ID"].push_back(ans)
	startTrial()

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

func _on_fixationButton_pressed():
	startTrial()

func _on_LineEdit_text_entered(new_text):
	sub_id = "ercffa_%03d" % int(new_text)
	sub_dataPath = "user://%s_%02d-%02d-%s_%02d-%02d.json" % [sub_id, day, month, year, hour, minute]
	sub_dataPath_incorrectChoices = "user://%s_%02d-%02d-%s_%02d-%02d_misClicks.json" % [sub_id, day, month, year, hour, minute]
	$ITI.visible = true
	$IntroMessage.visible = true
	$Fractals.visible = false
	$ITI/RichTextLabel.visible = false
	$SubjectID.visible = false



