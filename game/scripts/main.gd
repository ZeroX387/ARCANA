extends Node2D

const GRID_SIZE := 48
const ARENA_SIZE := Vector2(2400, 1600)


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, ARENA_SIZE), Color("#17251f"), true)

	for x in range(0, int(ARENA_SIZE.x) + 1, GRID_SIZE):
		draw_line(
			Vector2(x, 0),
			Vector2(x, ARENA_SIZE.y),
			Color(0.30, 0.40, 0.32, 0.18),
			1.0
		)

	for y in range(0, int(ARENA_SIZE.y) + 1, GRID_SIZE):
		draw_line(
			Vector2(0, y),
			Vector2(ARENA_SIZE.x, y),
			Color(0.30, 0.40, 0.32, 0.18),
			1.0
		)

	draw_rect(Rect2(Vector2.ZERO, ARENA_SIZE), Color("#78916f"), false, 5.0)
