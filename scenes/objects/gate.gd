extends StaticBody2D

signal player_entered_gate

func _on_area_2d_body_entered(_body) -> void:
	player_entered_gate.emit()
