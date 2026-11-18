extends Control

const JOYSTICK_RADIUS := 76.0
const KNOB_RADIUS := 29.0
const DEAD_ZONE := 9.0

@onready var player: CharacterBody2D = get_node("../../Player")

var active := false
var touch_index := -1
var origin := Vector2.ZERO
var knob_position := Vector2.ZERO


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var local_position := _to_local_position(event.position)
		if event.pressed and not active:
			active = true
			touch_index = event.index
			origin = local_position
			knob_position = origin
			_update_direction()
			queue_redraw()
		elif not event.pressed and active and event.index == touch_index:
			_release_joystick()
	elif event is InputEventScreenDrag and active and event.index == touch_index:
		knob_position = _clamp_knob(_to_local_position(event.position))
		_update_direction()
		queue_redraw()


func _to_local_position(screen_position: Vector2) -> Vector2:
	return get_global_transform_with_canvas().affine_inverse() * screen_position


func _clamp_knob(position: Vector2) -> Vector2:
	var offset := position - origin
	if offset.length() > JOYSTICK_RADIUS:
		offset = offset.normalized() * JOYSTICK_RADIUS
	return origin + offset


func _update_direction() -> void:
	var offset := knob_position - origin
	if offset.length() < DEAD_ZONE:
		player.set_mobile_direction(Vector2.ZERO)
	else:
		player.set_mobile_direction(offset / JOYSTICK_RADIUS)


func _release_joystick() -> void:
	active = false
	touch_index = -1
	player.set_mobile_direction(Vector2.ZERO)
	queue_redraw()


func _draw() -> void:
	if not active:
		return
	draw_circle(origin, JOYSTICK_RADIUS, Color(0.08, 0.12, 0.11, 0.48))
	draw_arc(origin, JOYSTICK_RADIUS, 0.0, TAU, 64, Color(0.70, 0.82, 0.72, 0.72), 3.0, true)
	draw_circle(knob_position, KNOB_RADIUS, Color(0.72, 0.83, 0.74, 0.82))
	draw_arc(knob_position, KNOB_RADIUS, 0.0, TAU, 48, Color(0.92, 0.96, 0.88, 0.95), 3.0, true)
