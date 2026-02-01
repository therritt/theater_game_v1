extends Node2D

var room
var player
# preload all rooms manually
const PLAYER = preload("res://scenes/player.tscn")
const FIRST_ROOM = preload("res://scenes/rooms/room_1.tscn")
const SECOND_ROOM = preload("res://scenes/rooms/room_2.tscn")
const THIRD_ROOM = preload("res://scenes/rooms/room_3.tscn")
const FOURTH_ROOM = preload("res://scenes/rooms/room_4.tscn")
const FIFTH_ROOM = preload("res://scenes/rooms/room_5.tscn")
const GAME_OVER = preload("res://scenes/game_over.tscn")
# room array can be customized
var room_array = [[FIRST_ROOM, SECOND_ROOM, THIRD_ROOM, FOURTH_ROOM, FIFTH_ROOM]]
var ldy # dimensions of room_array. make sure sub-arrays are consistent with each other pls
var ldx
var room_position = [0,0]

func _ready() -> void:
	player = PLAYER.instantiate() as Player
	player.position.x += 150
	player.position.y += 100
	add_child(player)
	player.died.connect(game_over)
	ldy = room_array.size()
	ldx = room_array[0].size()
	room = room_array[room_position[0]][room_position[1]].instantiate()
	add_child(room)

func next_room() -> Node2D:
	var next = room_array[room_position[0]][room_position[1]].instantiate()
	add_child.call_deferred(next)
	return next

func game_over(dead_player: Character):
	if dead_player is Player:
		var game_over_screen = GAME_OVER.instantiate()
		add_child(game_over_screen)

func _on_lz_top_character_body_entered(body: Node2D) -> void:
	if body is Player:
		# unload current room
		remove_child(room)
		if room:
			room.queue_free()
		# change room position in direction of loading zone
		# loop rooms mod the size of the room array
		room_position[0] = (room_position[0] - 1 + ldy) % ldy
		# go to the next room
		room = next_room()
		(body as Player).position.y += 200


func _on_lz_bottom_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[0] = (room_position[0] + 1 + ldy) % ldy
		room = next_room()
		(body as Player).position.y -= 200


func _on_lz_left_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[1] = (room_position[1] - 1 + ldx) % ldx
		room = next_room()
		(body as Player).position.x += 330


func _on_lz_right_character_body_entered(body: Node2D) -> void:
	if body is Player:
		remove_child(room)
		if room:
			room.queue_free()
		room_position[1] = (room_position[1] + 1 + ldx) % ldx
		room = next_room()
		(body as Player).position.x -= 330
