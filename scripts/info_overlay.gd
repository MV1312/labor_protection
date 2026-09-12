extends CanvasLayer

@onready var info_button: Button = $InfoButton
@onready var info_window: PanelContainer = $InfoWindow
@onready var tap_to_close: Control = $TapToClose
@onready var dim_background: ColorRect = $DimBackground
@onready var info_text: RichTextLabel = $InfoWindow/ScrollContainer/InfoText # $InfoWindow/MarginContainer/ScrollContainer/InfoText

# Можно хранить текст в ресурсе или файле
var info_content: String = """
[center][b]О ПРИЛОЖЕНИИ [/b][/center]
[center][color=yellow][b]«Тест-драйв знаний» — простые вопросы с ответами. »[/b][/color][/center]

[color=green]Как пользоваться:[/color]
	На экране — список квалификационных груп, при нажатии на одну из груп 
	появляются вопросы в виде кнопок. 
	Нажмите на любой вопрос — моментально увидите правильный ответ. 
	Листайте вниз для новых вопросов.
	
[color=green]Для кого: [/color] 
    Для тех, кто хочет проверить себя по теме:
		 охрана труда при выполнении работ на высоте
	
[color=red]Важно!!![/color]
✔ Приложение работает полностью офлайн.
✔ Никаких персональных данных не собирает.
✔ Не требует доступа к контактам, камере или звонкам.
✔ Создано физическим лицом — гражданином Республики Беларусь.

[i] Отдельная благодарность, при создании приложения, семье Астапова Д.Э.[/i]

[color=gray]Версия 1.0.0[/color]
"""

func _ready() -> void:
	info_button.toggle_mode = true
	info_button.toggled.connect(_on_info_button_toggled)

	tap_to_close.gui_input.connect(_on_tap_to_close_gui_input)
	tap_to_close.mouse_filter = Control.MOUSE_FILTER_STOP

	# Загрузка контента (можно из отдельного файла)
	_load_info_content()
	
	_set_info_visible(false)


func _on_info_button_toggled(button_pressed: bool) -> void:
	_set_info_visible(button_pressed)



func _on_tap_to_close_gui_input(event: InputEvent) -> void:
	if _is_touch_or_click(event):
		get_viewport().set_input_as_handled()
		close_info()


func _is_touch_or_click(event: InputEvent) -> bool:
	if event is InputEventScreenTouch:
		return event.pressed

	if event is InputEventMouseButton:
		return event.pressed and event.button_index == MOUSE_BUTTON_LEFT

	return false


func close_info() -> void:
	info_button.set_pressed_no_signal(false)
	_set_info_visible(false)


func _load_info_content() -> void:
	# Вариант 1: Прямой текст
	info_text.text = info_content
	
	# Вариант 2: Из JSON файла (будущее масштабирование)
	# var data = load_info_from_json("res://data/info.json")
	# info_text.text = data["content"]
	
func _set_info_visible(visible_state: bool) -> void:
	info_window.visible = visible_state
	tap_to_close.visible = visible_state
	dim_background.visible = visible_state
	
	# Сброс скролла при открытии
	if visible_state:
		var scroll = info_window.get_node("ScrollContainer") #MarginContainer/ScrollContainer")
		scroll.scroll_vertical = 0
		info_button.text = "Скрыть"
	else:
		info_button.text = "Инфо"
		
		
