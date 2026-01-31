extends Node2D

var enemy_amount = 3
var enemy_interval = 1.0

func _ready() -> void:
	while enemy_amount > 0:
		enemy_amount -= 1
		spawn_enemy()
		await get_tree().create_timer(1.0).timeout
	


func spawn_enemy() -> void:
	pass
