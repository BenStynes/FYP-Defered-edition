extends Popup

onready var yes = $Panel/Yes
onready var no = $Panel/No
signal reset()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Music = $Music
onready var click = $Click
onready var select = $Select
# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
	Music.volume_db = PlayerInformation.musicVol


func _process(delta):
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Yes_pressed():
	click.play()
	get_tree().reload_current_scene()
	emit_signal("reset") # Replace with function body.
	
	
	
func _on_No_pressed():
	click.play()
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://mainmenu.tscn")


func _on_GameOver_about_to_show():
	 Music.play()
	 get_tree().paused = true 
	

func _on_Yes_focus_entered():
		 select.play()
		 get_viewport().warp_mouse(yes.rect_global_position)


func _on_No_focus_entered():
		 get_viewport().warp_mouse(no.rect_global_position)
		 select.play()


func _on_GameOver_popup_hide():
		 Music.stop()
