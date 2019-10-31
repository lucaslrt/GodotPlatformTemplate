extends Area2D



func _on_DeathCollider_body_entered(body) -> void:
	if "Player" in body.name:
		get_tree().reload_current_scene()
	else:
		body.queue_free()
	pass # Replace with function body.
