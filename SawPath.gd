extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var chain = load("res://Traps/Saw/Chain.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var l := Line2D.new()   
	l.default_color = Color(Color.white)  
	l.width = 20  
	for point in curve.get_baked_points():  
		l.add_point(point + position) 
	
func _physics_process(delta):
		pass




func _draw():
	
	for p in curve.get_baked_points():
		draw_texture(chain,p)
