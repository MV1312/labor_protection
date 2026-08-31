extends Button

func _on_about_button_pressed() -> void:
	$InfoDialog.popup_centered()  # Покажет окно по центру экрана
