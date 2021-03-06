extends KinematicBody2D

export(int) var SPEED = 60
export(int) var hp = 1
const GRAVITY = 10
const JUMP_FORCE = -250
const FLOOR = Vector2(0, -1)

const FIREBALL = preload("res://Nodes/Prefabs/Fireball.tscn")

var velocity = Vector2()
var snap_normal = Vector2.DOWN setget set_snap_normal
var on_ground = false
var is_attacking = false
var is_dead = false
var fireball_power = 1
var jump_count = 0

func set_snap_normal(new_snap_normal):
	snap_normal = new_snap_normal
	pass

func _ready() -> void:
	adjust_camera_limits()
	pass

func adjust_camera_limits() -> void:
	var tilemap_rect = get_parent().get_node("Environment/Ground").get_used_rect()
	var tilemap_cell_size = get_parent().get_node("Environment/Ground").cell_size
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell_size.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell_size.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
	pass

func _physics_process(delta: float) -> void:

	if !is_dead:
		if Input.is_action_pressed("ui_right"):
			if !is_attacking or !is_on_floor():
				velocity.x = SPEED
				if !is_attacking:
					$AnimatedSprite.flip_h = false
					$AnimatedSprite.play("run")
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if !is_attacking or !is_on_floor():
				velocity.x = -SPEED
				if !is_attacking:
					$AnimatedSprite.flip_h = true
					$AnimatedSprite.play("run")
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if on_ground == true and !is_attacking:
				$AnimatedSprite.play("idle")

		if Input.is_action_just_pressed("ui_up"):
#			velocity.y = JUMP_FORCE
#			on_ground = false
			jump_count += 1
			print("jump_count: %d" % jump_count)
			if jump_count <= 2:
				velocity.y = JUMP_FORCE
				on_ground = false

		if Input.is_action_just_pressed("ui_focus_next") and !is_attacking:
			if is_on_floor():
				velocity.x = 0
			is_attacking = true
			$AnimatedSprite.play("attack")
			var fireball = FIREBALL.instance()
			fireball.set_fireball_power(fireball_power)

			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position

		velocity.y += GRAVITY

		velocity.y = move_and_slide_with_snap(velocity, snap_normal * 2, FLOOR, true).y

		if is_on_floor():
			if !on_ground:
				on_ground = true
				is_attacking = false
				jump_count = 0
		else:
			if !is_attacking:
				if on_ground:
					on_ground = false
					jump_count = 1
				if velocity.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall")

		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()

	pass

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.set_deferred("disabled", true)
	#$CollisionShape2D2.set_deferred("disabled", true)
	$Timer.start()

func _on_AnimatedSprite_animation_finished() -> void:
	is_attacking = false
	pass # Replace with function body.


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://Nodes/Scenes/TitleScreen.tscn")
	pass # Replace with function body.

func crown_power_up() -> void:
	fireball_power = 2
	pass
