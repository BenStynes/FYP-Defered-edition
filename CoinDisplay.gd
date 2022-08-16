extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var number = 26

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	

func _process(delta):

	set_text("Coin " + str(number)) # Replace with function body.




func _on_Player_Display2(coin):
	number = coin
