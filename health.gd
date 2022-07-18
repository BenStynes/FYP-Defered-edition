extends Panel

onready var container = $GridContainer
var  xSize = 39
onready var healthy : Texture = load("res://Items/Fruits/Healthy.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func TheMiracleOfBirth():
	rect_size += Vector2(xSize,0)
	container.rect_size +=Vector2(xSize,0)
	var newLife =   TextureRect.new()
	
	newLife.texture  = healthy
	container.add_child(newLife)
	

func _on_Player_Birth():
	TheMiracleOfBirth() # Replace with function body.
