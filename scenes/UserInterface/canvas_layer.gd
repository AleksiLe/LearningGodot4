extends CanvasLayer

@onready var laser_label: Label = $VBoxContainer/HBoxContainer/Bullets
@onready var grenade_label: Label = $VBoxContainer/HBoxContainer2/Grenades
@onready var health_bar: TextureProgressBar = $HBoxContainer/TextureProgressBar

func _ready():
	Globals.connect("health_change", update_health_text)
	Globals.connect("laser_ammo_change", update_laser_text)
	Globals.connect("grenade_ammo_change", update_grenade_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_ammo)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_ammo)
	
func update_health_text():
	health_bar.value = Globals.health
