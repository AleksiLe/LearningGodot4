extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")
func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)
		
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	print(pos)
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	
func _on_player_grenade_throw(pos, dir) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)

func _on_player_laser_shot(pos, dir) -> void:
	create_laser(pos, dir)

func _on_scout_laser(pos, dir) -> void:
	create_laser(pos, dir)

func create_laser(pos, dir) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = dir.angle() + (PI/2)
	laser.direction = dir
	$Projectiles.add_child(laser)


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2)


func _on_house_player_left() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.4,0.4), 2)
