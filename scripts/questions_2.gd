extends Control

var questions: Array = []

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var questions_container: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var answer_panel = $Panel
@onready var answer_label = $Panel/ScrollContainer2/Label

func _ready():
	scroll_container.follow_focus = false
	load_questions()
	create_question_buttons()
	_on_back_button_pressed()

func load_questions():
	var path = "res://data/questions.json"
	if not FileAccess.file_exists(path):
		print("Файл не найден: ", path)
		return
	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var err = json.parse(text)
	if err != OK:
		print("Ошибка JSON: ", json.get_error_message(), " строка ", json.get_error_line())
		return
	questions = json.data["questions"]
	print("Загружено вопросов: ", questions.size())

func create_question_buttons():
	for i in range(questions.size()):
		var button = Button.new()
		button.text = questions[i]["question"]
		button.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
		button.add_theme_font_size_override("font_size", 40)
		button.custom_minimum_size = Vector2(0, 70)
		button.mouse_filter = Control.MOUSE_FILTER_PASS
		button.focus_mode = Control.FOCUS_NONE
		button.pressed.connect(_on_question_button_pressed.bind(i))
		questions_container.add_child(button)
	questions_container.queue_sort()

func _on_question_button_pressed(index: int):
	answer_label.text = questions[index]["question"] + "\n\n" + questions[index]["answer"]
	answer_panel.show()
	get_viewport().gui_release_focus()

func _on_back_button_pressed():
	answer_panel.hide()
	get_viewport().gui_release_focus()
