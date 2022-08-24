extends Node

var ColletecablesPosX =  []
var ColletecablesPosY = []
var coinCount = 0
onready var template =  $Template
signal Amount(num)
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count():
		ColletecablesPosX.append(get_child(i).get_position() ) 
		
		coinCount+=1
	
	emit_signal("Amount",coinCount-1)
func _reset():
	for i in get_child_count():
		get_child(i).queue_free()
	for i in coinCount:
		var scene = load("res://Collectable.tscn")
		var child = scene.instance()
		child.set_position(Vector2(ColletecablesPosX[i].x,ColletecablesPosX[i].y))
		add_child(child)
	emit_signal("Amount",coinCount-1)


func _on_Player_Reset():
	_reset() # Replace with function body.
