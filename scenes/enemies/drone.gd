extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	velocity = Vector2(1,0) * SPEED
	move_and_slide()

func hit():
	print("Dmg")
