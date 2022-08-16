extends Area2D

onready var Animation = $Coin/AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var total

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Animation.play("Move")





func _on_Collectable_body_entered(body):
	queue_free() # Replace with function body.
	if(body.has_method("levelUp")):
		body.Collect(total)
	

func _on_CHolder_Amount(num):
	total = num # Replace with function body.
