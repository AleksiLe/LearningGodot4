extends Area2D

signal player_entered
signal player_left

func _on_player_entered(_body: Node2D) -> void:
	player_entered.emit()


func _on_player_exited(_body: Node2D) -> void:
	player_left.emit()
