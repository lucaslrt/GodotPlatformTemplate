extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")
	pass

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	pass

func _on_Fireball_body_entered(body) -> void:
	if "Enemy" in body.name:
		body.dead(1)
	queue_free()
	pass # Replace with function body.
