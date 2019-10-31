extends Area2D

func _ready() -> void:
	$AnimatedSprite.play("idle")
	pass


func _on_Area2D_body_entered(body) -> void:
	body.crown_power_up()
	queue_free()
	pass # Replace with function body.
