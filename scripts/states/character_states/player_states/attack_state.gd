extends PlayerState

var attack_dir

func enter(prev_state: String, data = {}):
	super.enter(prev_state, data)
	#player.velocity = Vector2.ZERO
	attack_dir = (player.attack_target_pos - player.global_position).normalized()
	var attack = player.perform_attack(player.attack_target_pos)
	attack.done.connect(_on_animation_finished)

func physics_update(delta: float) -> void:
	#player.velocity = attack_dir * player.speed * 0.3
	#player.move_and_slide()
	pass

func _on_animation_finished():
	if player.is_moving():
		finished.emit(MOVING)
	else:
		finished.emit(IDLE)

func on_animation_finished(anim_name: String) -> void:
	if anim_name.ends_with("attack"):
		_on_animation_finished()
