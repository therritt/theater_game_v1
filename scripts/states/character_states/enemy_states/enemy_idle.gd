extends EnemyState

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	enemy.play_anim("idle", false, false)

func physics_update(delta: float) -> void:
	var soft_push = enemy.soft_collision.get_push_vector()
	enemy.velocity += soft_push
	if enemy.target == null:
		return
	enemy.move_and_slide()

	var dist = enemy.global_position.distance_to(enemy.target.global_position)
	if dist <= enemy.chase_range:
		finished.emit("Chase")
