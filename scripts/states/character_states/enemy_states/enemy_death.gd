extends EnemyState

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	enemy.play_anim("death", false, false)

func on_animation_finished(anim_name: String) -> void:
	if anim_name.ends_with("death"):
		queue_free()
