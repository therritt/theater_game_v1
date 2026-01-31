extends Node2D

var room
var player
const PLAYER = preload("res://scenes/player.tscn")
const FIRST_ROOM = preload("res://scenes/rooms/room_1.tscn")
const SECOND_ROOM = preload("res://scenes/rooms/room_2.tscn")

func _ready() -> void:
	player = PLAYER.instantiate() as Player
	player.position.x += 150
	player.position.y += 100
	add_child(player)
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


func _on_lz_bottom_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room = next_room()
		(body as Player).position.y -= 200


func _on_lz_left_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room = next_room()
		(body as Player).position.x += 350


func _on_lz_right_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room = next_room()
		(body as Player).position.x -= 350
