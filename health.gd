extends Panel

onready var container = $GridContainer
var  xSize = 39
var health
var HP
var pos = 2
var levelUp = false
onready var healthy : Texture = load("res://Items/Fruits/Healthy.png")
onready var unhealthy : Texture = load("res://Items/Fruits/unhealthy.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	rect_scale = Vector2(2,2) # Replace with function body.
	health  = container.get_child_count()
	HP = PlayerInformation.health
	NextHP()
func TheMiracleOfBirth():
	
		rect_size += Vector2(xSize,0)
		container.rect_size +=Vector2(xSize,0)
		var newLife =   TextureRect.new()
	
		newLife.texture  = healthy
		container.add_child(newLife)
		

func _on_Player_Birth():
	levelUp
	TheMiracleOfBirth() # Replace with function body.
	
func _process(delta):
	health  = container.get_child_count()
	


func _on_Enemy_Hit():
	pass
	


func _on_Player_takeDamage(t_health):
	for n in t_health:
		var text = container.get_child(n)
		if text.texture == healthy:
			text.texture = unhealthy
			break 
	
func NextHP():
	for n in health:
		var text = container.get_child(n)
		text.queue_free()

	for n in HP:
		rect_size += Vector2(xSize,0)
		container.rect_size +=Vector2(xSize,0)
		var newLife =   TextureRect.new()
	
		newLife.texture  = healthy
		container.add_child(newLife)

func _on_GameOver_reset():
	for n in health:
		var text = container.get_child(n)
		if text.texture == unhealthy:
			text.texture = healthy
			
		if n > 2:
			text.queue_free()
	
