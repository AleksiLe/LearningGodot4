extends LevelParent

func _on_gate_player_entered_gate() -> void:
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
