extends CharacterBody2D

signal laser(pos, direction) 

var player_nearby: bool = false
var can_laser: bool = true
var variance: bool = true

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser == true:
			var marker_node = $LaserSpawnPosition.get_child(variance)
			variance = not variance
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			can_laser = false
			$LaserCooldown.start()
			$GPUParticles2D.emitting = true
			laser.emit(pos, direction)


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
