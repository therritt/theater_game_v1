extends Area2D

const ENEMY_SPAWNER = preload("res://scenes/enemy_spawner.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_parent().get_parent().add_child.call_deferred(ENEMY_SPAWNER.instantiate())
		queue_free()
