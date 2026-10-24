extends CanvasLayer

# Сюда впишите ИМЕНА корневых узлов тех сцен, где кнопка должна быть видна.
# Например, если корневой узел вашего уровня называется "Level1", пишите "Level1".
var allowed_scenes: Array[String] = ["Control", "main", "SceneWithInfo"]

var last_scene_name: String = ""

@onready var button: Button = $Button if has_node("Button") else null

func _ready() -> void:
	if button == null:
		push_warning("Кнопка $Button не найдена в узле '%s'. Функционал будет отключен. " % name)
	

func _process(_delta):
	# Получаем текущую запущенную сцену
	var current_scene = get_tree().current_scene
	# Проверяем, сменилась ли сцена с прошлого кадра (чтобы не нагружать процессор)
	if current_scene != null:
		if current_scene.name != last_scene_name:
			last_scene_name = current_scene.name
			# Если имя текущей сцены есть в нашем списке - показываем кнопку
			if allowed_scenes.has(current_scene.name):
				$Button.visible = true
			else:
				$Button.visible = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
