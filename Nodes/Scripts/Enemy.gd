extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

export(int) var hp = 1
export(Vector2) var size = Vector2(1,1)
var velocity = Vector2()

var direction = 1 #1 = right side

var is_dead = false

func _ready() -> void:
	scale =  size
	pass

func _physics_process(delta: float) -> void:
	if !is_dead:
		velocity.x = SPEED * direction

		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true

		$AnimatedSprite.play("walk")

		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)

		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1

		if !$RayCast2D.is_colliding():
			direction *= -1
			$RayCast2D.position.x *= -1

		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead() #Essa função está no script de Player

func dead(damage) -> void:
	hp -= damage
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.set_deferred("disabled",true)
		$Timer.start()
		if scale > Vector2(1,1):
			get_parent().get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)


func _on_Timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
