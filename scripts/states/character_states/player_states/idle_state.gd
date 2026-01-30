extends PlayerState

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	player.play_anim("idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		finished.emit("Attack")
		
func physics_update(delta: float) -> void:
	if player.is_moving():
		finished.emit(MOVING)
