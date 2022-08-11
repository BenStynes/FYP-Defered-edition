extends Popup

onready var help =  $AnimationPlayer
onready var button = $Panel/GridContainer/Label
onready var button1 = $Panel/GridContainer/Label2
onready var button2 = $Panel/GridContainer/Label3
onready var button3 = $Panel/GridContainer/Label4
onready var button4 = $Panel/GridContainer/Label5

signal level(attribute)
var hell



func _ready():
	button.text = "             "
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	help.play("text")
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_PopupPanel_about_to_show():
	 get_tree().paused = true 
	 
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
	Input.warp_mouse_position( button.rect_global_position )


func _on_Label2_focus_entered():
	Input.warp_mouse_position( button1.rect_global_position )


func _on_Label3_focus_entered():
	Input.warp_mouse_position( button2.rect_global_position )


func _on_Label5_focus_entered():
	Input.warp_mouse_position( button4.rect_global_position )


func _on_Label4_focus_entered():
	Input.warp_mouse_position( button3.rect_global_position )

