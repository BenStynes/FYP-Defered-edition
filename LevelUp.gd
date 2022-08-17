extends Popup

onready var help =  $AnimationPlayer
onready var button = $Panel/Button
onready var button1 = $Panel/Button2
onready var button2 = $Panel/Button3
onready var button3 = $Panel/Button4
onready var button4 = $Panel/Button5
var offset = Vector2(20,20)
signal level(attribute)
var hell



func _ready():
	button.text = "             "
	get_viewport().connect("size_changed",self,"resize")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func resize():
	button = get_child(1).get_child(0)
	button1 = get_child(1).get_child(1)
	button2 = get_child(1).get_child(2)
	button3 =  get_child(1).get_child(3)
	button4 = get_child(1).get_child(4)

func _process(delta):
	help.play("text")
	
	#if get_tree().paused == true:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


func _on_PopupPanel_about_to_show():
	 get_tree().paused = true 
	 Input.warp_mouse_position(button.rect_global_position)
func _on_Label4_pressed():
	emit_signal("level",4) 
	get_tree().paused = false


func _on_Label5_pressed():
	emit_signal("level",5)
	get_tree().paused = false


func _on_Label2_pressed():
	emit_signal("level",2) 
	get_tree().paused = false 


func _on_Label3_pressed():
	emit_signal("level",3) 
	get_tree().paused = false


func _on_Label_pressed():
	emit_signal("level",1)
	get_tree().paused = false



func _on_Label_focus_entered():
	get_viewport().warp_mouse(button.rect_global_position + offset)




func _on_Label2_focus_entered():
	get_viewport().warp_mouse(button1.rect_global_position + offset)
	


func _on_Label3_focus_entered():
	get_viewport().warp_mouse( button2.rect_global_position + offset)
	
	

func _on_Label5_focus_entered():
	get_viewport().warp_mouse( button4.rect_global_position + offset)
	
	

func _on_Label4_focus_entered():
	get_viewport().warp_mouse( button3.rect_global_position+ offset )
	
	
