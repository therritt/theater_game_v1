class_name CharacterState
extends State

var character: CharacterBody2D

func enter(previous_state_path: String, data := {}) -> void:
	character = owner as CharacterBody2D
	assert(character != null, "CharacterState must be used on a CharacterBody2D")
