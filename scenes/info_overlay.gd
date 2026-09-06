
extends CanvasLayer

@onready var info_button: Button = $InfoButton
@onready var info_window: PanelContainer = $InfoWindow
@onready var tap_to_close: Control = $TapToClose
@onready var dim_background: ColorRect = $DimBackground


func _ready() -> void:
	info_button.toggle_mode = true
	info_button.toggled.connect(_on_info_button_toggled)

	tap_to_close.gui_input.connect(_on_tap_to_close_gui_input)
	tap_to_close.mouse_filter = Control.MOUSE_FILTER_STOP

	_set_info_visible(false)


func _on_info_button_toggled(button_pressed: bool) -> void:
	_set_info_visible(button_pressed)


func _set_info_visible(visible_state: bool) -> void:
	info_window.visible = visible_state
	tap_to_close.visible = visible_state
	dim_background.visible = visible_state

	if visible_state:
		info_button.text = "Скрыть"
	else:
		info_button.text = "Инфо"


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
