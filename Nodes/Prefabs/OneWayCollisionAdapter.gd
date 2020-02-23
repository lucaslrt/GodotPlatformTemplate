extends Node2D

onready var mainPhysicObject = get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func setOneWayCollision(one_way, physics_object):
	if one_way:
		mainPhysicObject.add_collision_exception_with(physics_object)
	else:
		yield(get_tree().create_timer(.2,true), "timeout")
		mainPhysicObject.remove_collision_exception_with(physics_object)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
