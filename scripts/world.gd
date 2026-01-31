extends Node2D

var room
const FIRST_ROOM = preload("res://scenes/rooms/room_1.tscn")
const SECOND_ROOM = preload("res://scenes/rooms/room_2.tscn")

func _ready() -> void:
	room = FIRST_ROOM.instantiate()
	add_child(room)

func _on_lz_top_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room = next_room()
		(body as Player).position.y += 200
	

func next_room() -> Node2D:
	var next = SECOND_ROOM.instantiate()
	add_child(next)
	return next
