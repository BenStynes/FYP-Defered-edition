extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var chain = load("res://Traps/Saw/Chain.png")

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
		pass




func _draw():
	
	for p in curve.get_baked_points():
		draw_texture(chain,p)
