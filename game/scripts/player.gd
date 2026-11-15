extends CharacterBody2D

@export var move_speed: float = 260.0

const PLAYER_RADIUS := 14.0
const PLAYER_COLOR := Color("#8bd5ff")


func _ready() -> void:
	queue_redraw()


func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.y += 1.0

	velocity = direction.normalized() * move_speed
	move_and_slide()


func _draw() -> void:
	draw_circle(Vector2.ZERO, PLAYER_RADIUS, PLAYER_COLOR)
	draw_arc(Vector2.ZERO, PLAYER_RADIUS + 3.0, 0.0, TAU, 48, Color("#d9f2ff"), 2.0)
	draw_circle(Vector2(5.0, -4.0), 3.0, Color("#183047"))
