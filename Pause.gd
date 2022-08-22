extends Popup

onready var help =  $AnimationPlayer
onready var button = $Panel/Button
onready var button1 = $Panel/Button2
onready var button2 = $Panel/Button3
onready var button3 = $Panel/CheckBox
onready var label = $Panel/Button2/Label
onready var click = $Click
onready var select = $Select
var offset = Vector2(20,20)
var a = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


	
func _ready():
	label.text = "Size: 1024 x 600"
	a = PlayerInformation.screensize

	select.volume_db = PlayerInformation.soundVol
	click.volume_db =  PlayerInformation.soundVol
func _process(delta):
	

	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if OS.window_fullscreen == true:
		button1.disabled = true
		button3.pressed = true
	else:
		button1.disabled = false
		button3.pressed = false
	match a:
		0: OS.set_window_size(Vector2(1024,600)) 
		1: OS.set_window_size(Vector2(1536,900)) 
		2: OS.set_window_size(Vector2(2048,1200)) 
		3: OS.set_window_size(Vector2(2560,1500)) 
	match a:
		0: label.text = "Size: 1024 x 600"
		1: label.text = "Size: 1536 x 900"
		2: label.text = "Size: 2048 x 1200"
		3: label.text = "Size: 2560 x 1500"

func _on_Button_focus_entered():
		get_viewport().warp_mouse(button.rect_global_position + offset) # Replace with function body.
		select.play()

func _on_Button2_focus_entered():
		get_viewport().warp_mouse(button1.rect_global_position + offset) # Replace with function body.
		select.play()



func _on_Button3_focus_entered():
		get_viewport().warp_mouse(button2.rect_global_position + offset) # Replace with function body.
		select.play()

func _on_Button2_pressed():
	click.play()
	a +=1
	if(a > 3):
		a = 0



func _on_Button_pressed():
	
	hide()	
	click.play()
func _on_Button3_pressed():
	click.play()
	PlayerInformation.screensize = a
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://mainmenu.tscn")



func _on_CheckBox_focus_entered():
			get_viewport().warp_mouse(button3.rect_global_position + offset) # Replace with function body.
			select.play()

func _on_CheckBox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Popup_popup_hide():
	get_tree().paused = false
	
	 # Replace with function body.
