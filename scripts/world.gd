extends Node2D

var room
var player
const PLAYER = preload("res://scenes/player.tscn")
const FIRST_ROOM = preload("res://scenes/rooms/room_1.tscn")
const SECOND_ROOM = preload("res://scenes/rooms/room_2.tscn")
const THIRD_ROOM = preload("res://scenes/rooms/room_3.tscn")
const FOURTH_ROOM = preload("res://scenes/rooms/room_4.tscn")
const FIFTH_ROOM = preload("res://scenes/rooms/room_2.tscn")
var room_array = [[FIRST_ROOM, SECOND_ROOM], [THIRD_ROOM,FOURTH_ROOM]]
var room_position = [0,0]

func _ready() -> void:
	player = PLAYER.instantiate() as Player
	player.position.x += 150
	player.position.y += 100
	add_child(player)
	room = room_array[room_position[0]][room_position[1]].instantiate()
	add_child(room)

func next_room() -> Node2D:
	var next = room_array[room_position[0]][room_position[1]].instantiate()
	add_child(next)
	return next

func _on_lz_top_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[0] = (room_position[0] - 1 + 2) % 2
		room = next_room()
		(body as Player).position.y += 200


func _on_lz_bottom_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[0] = (room_position[0] + 1 + 2) % 2
		room = next_room()
		(body as Player).position.y -= 200


func _on_lz_left_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[1] = (room_position[1] - 1 + 2) % 2
		room = next_room()
		(body as Player).position.x += 330


func _on_lz_right_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[1] = (room_position[1] + 1 + 2) % 2
		room = next_room()
		(body as Player).position.x -= 330
