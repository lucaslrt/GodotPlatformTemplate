extends Node2D

var current_shake_priority = 0

func _ready() -> void:
	pass

func move_camera(vector):
	get_parent().get_node("Player").get_node("Camera2D").offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y, vector.y))
	pass

func screen_shake(shake_length, shake_power, shake_priority):
	if shake_priority > current_shake_priority:
		current_shake_priority = shake_priority
		#search for "move_camera" func and pass and then use this function using
		$Tween.interpolate_method(self, "move_camera", Vector2(shake_power,shake_power), Vector2(0,0), shake_length, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
		$Tween.start()
	pass

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	current_shake_priority = 0
	pass # Replace with function body.
