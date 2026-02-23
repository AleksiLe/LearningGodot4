extends Area2D

var rotation_speed: int = 4
var type_list = ['health', 'laser', 'grenade']
var type = type_list[randi()%len(type_list)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.105, 0.361, 0.501, 1.0)
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.559, 0.4, 0.0, 1.0)
	elif type == 'health':
		$Sprite2D.modulate = Color(0.146, 0.581, 0.0, 1.0)
	
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))

func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.add_item(type)
	queue_free()
