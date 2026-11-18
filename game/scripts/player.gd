extends CharacterBody2D

@export var move_speed: float = 260.0

const PLAYER_RADIUS := 14.0
const PLAYER_COLOR := Color("#8bd5ff")

var mobile_direction := Vector2.ZERO


func _ready() -> void:
	queue_redraw()


func set_mobile_direction(direction: Vector2) -> void:
	mobile_direction = direction.limit_length(1.0)


func _physics_process(_delta: float) -> void:
	var keyboard_direction := Input.get_vector(
		"ui_left", "ui_right", "ui_up", "ui_down"
	)
	var direction := mobile_direction if mobile_direction.length() > 0.0 else keyboard_direction
	velocity = direction.normalized() * move_speed
	move_and_slide()


func _draw() -> void:
	draw_circle(Vector2.ZERO, PLAYER_RADIUS, PLAYER_COLOR)
	draw_arc(Vector2.ZERO, PLAYER_RADIUS + 3.0, 0.0, TAU, 48, Color("#d9f2ff"), 2.0)
	draw_circle(Vector2(5.0, -4.0), 3.0, Color("#183047"))
