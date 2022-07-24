extends Node2D

var ans: int	# Var to save Fractal Answer
var sub_id: String
var sub_dataPath: String
var sub_dataPath_incorrectChoices: String
var answers: Dictionary	# Var to save  Confirmed answers 
var wrongAnswers: Dictionary # # Var to save Mis-clicks
var demo = true

var Trial = -1 	# Trial id
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
	$IntroMessage.visible = false
	$ITI.visible = false
	$StartMenu.visible = false
	$ConfirmationQuestion.visible = false
	$SubjectID.visible = true
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
	elif Input.is_action_pressed("ui_home"): 
		save(answers, sub_dataPath)
		save(wrongAnswers, sub_dataPath_incorrectChoices)
		start_json()
		$StartMenu.visible = true

func start_json():
	# Variables to creat file ID
	dateTime = OS.get_datetime()
	year = dateTime.year;
	month = dateTime.month;
	day = dateTime.day;
	hour = dateTime.hour;
	minute = dateTime.minute;
	sub_dataPath = "user://%s_%02d-%02d-%s_%02d-%02d.json" % [sub_id, day, month, year, hour, minute]
	sub_dataPath_incorrectChoices = "user://%s_%02d-%02d-%s_%02d-%02d_misClicks.json" % [sub_id, day, month, year, hour, minute]
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

func save(content, sub_id):
	var file = File.new()
	file.open( str(sub_id), File.WRITE) # Change NAME to somessing useful
	file.store_line(to_json(content))
	file.close()

# Called whenever a Fractal is pressed
func _Fractal_pressed(which):
	ans = which.get_index() 				# Holds answer for confirmation
	ChoiceTimestamp = OS.get_unix_time()	# Hods click timestamp
	which.get_child(0).set_frame(2)
	for i in $Fractals.get_children():	# Goes through Fractal Buttons
		if i != which:	
			i.get_child(0).set_frame(1) # Changes non-clicked Fractals to Grey View
	fractalDisable()
	popupConfirmation()

func popupConfirmation():
	$TEXT1.visible = false
	$ConfirmationQuestion.visible = true

func _on_Yes_pressed():
	if demo:
		$StartMenu.visible = true
	else:
		answers["User"].push_back(sub_id)
		answers["Trial"].push_back(Trial)
		answers["Choice Timestamp"].push_back(ChoiceTimestamp)
		answers["Confirmation Timestamp"].push_back(OS.get_unix_time())
		answers["Fractal ID"].push_back(ans)
		Trial += 1
		startITI()

func startITI():
	print(Trial)
	print(demo)
	$ITI.visible = true
	if demo:
		$ITI/RichTextLabel.visible = false
		$IntroMessage.visible = true
		demo = false

func _on_No_pressed():
	if demo:
		startTrial()
	else:
		wrongAnswers["User"].push_back(sub_id)
		wrongAnswers["Trial"].push_back(Trial)
		wrongAnswers["Wrong Choice Timestamp"].push_back(ChoiceTimestamp)
		wrongAnswers["Denial Timestamp"].push_back(OS.get_unix_time())
		wrongAnswers["Fractal ID"].push_back(ans)
		startTrial()
		

func startTrial():
	if Trial == 0:
		$IntroMessage.visible = false
		$ITI/RichTextLabel.visible = true
	makeFractalVisible()
	fractalEnable()
	$ITI.visible = false
	$ConfirmationQuestion.visible = false

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
	start_json()
	#sub_dataPath = "user://%s_%02d-%02d-%s_%02d-%02d.json" % [sub_id, day, month, year, hour, minute]
	#sub_dataPath_incorrectChoices = "user://%s_%02d-%02d-%s_%02d-%02d_misClicks.json" % [sub_id, day, month, year, hour, minute]
	$StartMenu.visible = true
	$SubjectID.visible = false

func makeFractalVisible():
	$Fractals.visible = true
	$TEXT1.visible = true
	$Background.visible = true

func _on_Demo_pressed():
	$StartMenu.visible = false
	$ITI.visible = false
	startTrial()

func _on_Game_pressed():
	Trial = 0
	$StartMenu.visible = false
	startITI()
