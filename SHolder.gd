extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var Help =  get_child_count()
	for i in get_child_count():
		for j in Help:
			get_child(i).add_collision_exception_with(get_child(j))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
