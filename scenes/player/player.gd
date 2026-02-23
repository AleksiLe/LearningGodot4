extends CharacterBody2D

signal laser_shot(pos, direction)
signal grenade_throw(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 400
	move_and_slide()
	Globals.player_pos = global_position
	
	# Rotate
	look_at(get_global_mouse_position())
	
	# Laser shootin imput
	var player_aim_dir = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary action") and can_laser == true and Globals.laser_ammo > 0:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		Globals.laser_ammo -= 1
		can_laser = false
		$Timer.start()
		$GPUParticles2D.emitting = true
		laser_shot.emit(selected_laser.global_position, player_aim_dir)
		
	if Input.is_action_just_pressed("secondary action") and can_grenade == true and Globals.grenade_ammo > 0:
		var grenade_marker = $GrenadeStartPosition/Marker2D
		Globals.grenade_ammo -= 1
		can_grenade = false
		$Timer2.start()
		grenade_throw.emit(grenade_marker.global_position, player_aim_dir) 
		


func _on_timer_timeout() -> void:
	can_laser = true


func _on_timer_2_timeout() -> void:
	can_grenade = true
	
func add_item(type: String) -> void:
	if type == 'laser':
		Globals.laser_ammo += 5
	elif type == 'grenade':
		Globals.grenade_ammo += 1
	elif type == 'health':
		if Globals.health > 50:
			Globals.health = 100
		else:
			Globals.health += 50
