extends Popup

signal reset()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Yes_pressed():
	emit_signal("reset") # Replace with function body.
	get_tree().paused = false 	
	
	
func _on_No_pressed():
	 get_tree().quit()


func _on_GameOver_about_to_show():
	 get_tree().paused = true 
