extends Control

onready var play_buttom = $MarginContainer/CenterContainer/VBoxContainer/TextureButton
onready var exit_buttom = $MarginContainer/CenterContainer/VBoxContainer/TextureButton2

func _ready() -> void:
	play_buttom.grab_focus()
	pass

func _physics_process(delta: float) -> void:
	if play_buttom.is_hovered():
		play_buttom.grab_focus()
	elif exit_buttom.is_hovered():
		exit_buttom.grab_focus()
	pass

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		play_buttom.grab_focus()
		change_game_state()
	pass

func _on_resume_pressed() -> void:
	change_game_state()
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	change_game_state()
	get_tree().change_scene("res://Nodes/Scenes/TitleScreen.tscn")
	pass

func change_game_state() -> void:
	get_tree().paused = not get_tree().paused
	visible = not visible