extends CanvasLayer

# Сюда впишите ИМЕНА корневых узлов тех сцен, где кнопка должна быть видна.
# Например, если корневой узел вашего уровня называется "Level1", пишите "Level1".
var allowed_scenes = ["Control", "main"]

var last_scene_name = ""

func _process(_delta):
	# Получаем текущую запущенную сцену
	var current_scene = get_tree().current_scene
	
	if current_scene != null:
		# Проверяем, сменилась ли сцена с прошлого кадра (чтобы не нагружать процессор)
		if current_scene.name != last_scene_name:
			last_scene_name = current_scene.name
			
			# Если имя текущей сцены есть в нашем списке - показываем кнопку
			if allowed_scenes.has(current_scene.name):
				$Button.visible = true
			else:
				$Button.visible = false
