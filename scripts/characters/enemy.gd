extends Character
class_name Enemy

@export var damage := 1
@export var damage_interval := 1
@export var chase_range := 200
@export var stop_range := 16

var target: Player = null

func _ready() -> void:
	var root_scene = get_tree().get_current_scene()
	target = root_scene.get_node_or_null("Player")
