extends Popup

onready var help =  $AnimationPlayer
signal level(attribute)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	help.play("text")

func _on_Label_button_up():
	pass

func _on_Label2_button_up():
	pass

func _on_Label3_button_up():
	pass

func _on_Label4_button_up():

	pass

func _on_Label5_button_up():
	pass

func _on_PopupPanel_about_to_show():
	 get_tree().paused = true  # Replace with function body.


func _on_Label4_pressed():
	emit_signal("level",4) # Replace with function body.
	get_tree().paused = false # Replace with function body. # Replace with function body.


func _on_Label5_pressed():
	emit_signal("level",5) # Replace with function body.
	get_tree().paused = false


func _on_Label2_pressed():
	emit_signal("level",2) # Replace with function body.
	get_tree().paused = false # Replace with function body.


func _on_Label3_pressed():
	emit_signal("level",3) # Replace with function body.
	get_tree().paused = false


func _on_Label_pressed():
	emit_signal("level",1)#Replace with function body.
	get_tree().paused = false
