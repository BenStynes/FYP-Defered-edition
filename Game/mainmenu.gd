extends Popup

onready var help =  $AnimationPlayer
onready var button = $Button
onready var button1 = $Button2
onready var button2 = $Button3
onready var button3 = $Button4
onready var button4 = $Button5
onready var pop = $Button4/Popup
onready var sprite = $Button4/Popup/Sprite
onready var Music = $Music
onready var click = $Click
onready var select = $Select
onready var  audio = $Button3/Popup
onready var sounds = $Button3/Popup/Bsfx
onready var musics = $Button3/Popup/BMusic
onready var soundsl = $Button3/Popup/Bsfx/Label2
onready var musicsl = $Button3/Popup/BMusic/Label
onready var done = $Button3/Popup/Done
var volumeM = 0
var volumeS = 0
var offset = Vector2(20,20)
var increase = -15
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	volumeM = PlayerInformation.musicVol
	volumeS = PlayerInformation.soundVol
	popup_centered()
	
	Music.volume_db = volumeM
	Music.play()
	select.volume_db = volumeS
	click.volume_db = volumeS

	
func _process(delta):
	help.play("text")
	Music.volume_db = volumeM
	select.volume_db = volumeS
	click.volume_db = volumeS
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Button_focus_entered():
		get_viewport().warp_mouse(button.rect_global_position + offset) # Replace with function body.
		select.play()

func _on_Button2_focus_entered():
		get_viewport().warp_mouse(button1.rect_global_position + offset) # Replace with function body.
		select.play()

func _on_Button4_focus_entered():
		get_viewport().warp_mouse(button3.rect_global_position + offset) # Replace with function body.
		pop.popup()
		sprite.visible = true
		select.play()
func _on_Button3_focus_entered():
		get_viewport().warp_mouse(button2.rect_global_position + offset) # Replace with function body.
		select.play()

func _on_Button2_pressed():
	click.play()
	get_tree().root.get_node("Menu").queue_free()
	get_tree().change_scene(PlayerInformation.currentLevel)
	get_tree().paused = false


func _on_Button_pressed():
	click.play()
	PlayerInformation.reset()
	get_tree().root.get_node("Menu").queue_free()
	get_tree().change_scene("res://Level.tscn")
	get_tree().paused = false


func _on_Button4_pressed():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var color = Color(rng.randf_range(0,1),rng.randf_range(0,1),rng.randf_range(0,1))
	
	sprite.self_modulate = color
	PlayerInformation.set_color(color)
	click.play()

func _on_Button3_pressed():
	click.play()
	audio.popup_centered()




func _on_Menu_about_to_show():
	 get_tree().paused = true 
	 get_viewport().warp_mouse(button.rect_global_position) # Replace with function body.


func _on_Button4_focus_exited():
	pop.hide() # Replace with function body.
	sprite.visible =false


func _on_Button5_pressed():
		click.play()
		get_tree().quit() # Replace with function body.


func _on_BMusic_focus_entered():
	get_viewport().warp_mouse(musics.rect_global_position) # Replace with function body.
	select.play()
	 # Replace with function body.


func _on_Bsfx_focus_entered():
	get_viewport().warp_mouse(sounds.rect_global_position) # Replace with function body.
	select.play()
	

func _on_Done_focus_entered():
	get_viewport().warp_mouse(done.rect_global_position) # Replace with function body.
	select.play()


func _on_Done_pressed():
	click.play()	
	audio.hide()


func _on_Bsfx_pressed():
	click.play()
	
func _on_BMusic_pressed():
	click.play()

	PlayerInformation.musicVol = volumeM


func _on_Button5_focus_entered():
		get_viewport().warp_mouse(button4.rect_global_position) # Replace with function body.
		select.play()
		


func _on_BMusic_value_changed(value):
	volumeM = value # Replace with function body.
	PlayerInformation.musicVol = volumeM


func _on_Bsfx_value_changed(value):
	volumeS = value
	PlayerInformation.soundVol = volumeS
	
