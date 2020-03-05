extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1
var damage

const shoot_type = {1: ["red_shoot", 1], 2: ["blue_shoot", 3]}
var current_shoot = shoot_type[1]

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play(current_shoot[0])
	pass

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	pass

func set_fireball_power(index):
	current_shoot = shoot_type[index]

func _on_Fireball_body_entered(body) -> void:
	if "Enemy" in body.name:
		body.dead(current_shoot[1])
	queue_free()
	pass # Replace with function body.
