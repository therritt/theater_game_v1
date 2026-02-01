extends PlayerState

func enter(prev_state: String, data := {}):
	super.enter(prev_state, data)

	player.velocity = Vector2.ZERO
	print("Player has died")
	#player.play_anim("death", false, false)

func on_animation_finished(anim_name: String):
	print("Player has died")
