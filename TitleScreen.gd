extends Node2D

onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/TextureButton
onready var exit_button = $MarginContainer/VBoxContainer/VBoxContainer/TextureButton2

func _ready() -> void:
	start_button.grab_focus()
	pass

func _physics_process(delta: float) -> void:
	if start_button.is_hovered():
		start_button.grab_focus()

	if exit_button.is_hovered():
		exit_button.grab_focus()
	pass

func _on_start_pressed() -> void:
	print("clicked!")
	get_tree().change_scene("res://Nodes/Scenes/Stage1.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
