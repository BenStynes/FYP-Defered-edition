extends KinematicBody2D


onready var animation = $ssSprite
onready var Collection =$Collect
onready var Leveling = $CanvasLayer/PopupPanel
onready var GO = $CanvasLayer/GameOver
onready var pause = $CanvasLayer/pause
onready var anime = $AnimationPlayer
onready var anime2 = $AnimationPlayer2
onready var Music = $Music
onready var jump = $Jump
onready var hurt = $Hurt
onready var sound = $CoinSound
onready var LUS = $LSound
onready var LevelNotif = $Label
onready var la = $AnimationPlayer3
onready var time = $Label2
onready var timer = $Label2/Timer
signal takeDamage(health)
signal lockControls()
signal Reset()
signal Open()
var currentLevel 
var velocity = Vector2(0,0)
var moving = false
var level = 1
var Strength = 1
var Speed  = 1
var Dexterity =1
var Skill  = 1
var Body = 1
var falling = false
var onWall = false
var axisX
var experience = 0
var XPLimiit = 1
var moveSpeed = 125 * Speed
var jumpCount = Dexterity
var lock = false
var totalCoins 
var StartPosition = Vector2(651,234)
var weight = 0.05
signal Birth()
signal Display(level)
signal Display2(coin)
var startTimer = false
var musicpos 
var JumpHeight : float = 100 + Strength * 20
var PeakTime: float = 0.5
var FallTime: float = 0.4
var health  = 3 
var damage = 0
var pitchy = 1
var fix = false
onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
onready var wall_gravity : float = (-2.0 * JumpHeight) / (3 * 3) * -1.0

func _ready():
	
	LevelNotif.visible = false
	position = StartPosition
	totalCoins = get_parent().get_child(1).get_child_count() -1
	level = PlayerInformation.level		
	Strength = PlayerInformation.Strength
	JumpHeight = 100 + Strength * 20
	Body = PlayerInformation.Body
	Speed = PlayerInformation.Speed
	Dexterity = PlayerInformation.Dexterity
	Skill = PlayerInformation.Skill
	XPLimiit = PlayerInformation.XPLimiit
	experience = PlayerInformation.experience
	health = PlayerInformation.health
	currentLevel = 	PlayerInformation.currentLevel
	if currentLevel == "res://Level3.tscn":
		time.visible = true
		startTimer = true
	else:
		startTimer = false
		time.visible = false
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	moveSpeed = 125 * Speed
	jumpCount =  Dexterity/2
	pitchy = PlayerInformation.pitch
	animation.self_modulate = PlayerInformation.color
	Music.volume_db = PlayerInformation.musicVol
	hurt.volume_db = PlayerInformation.soundVol
	jump.volume_db =  PlayerInformation.soundVol
	LUS.volume_db =  PlayerInformation.soundVol
	#usic.pitch
	Music.play()
	emit_signal("Display2", totalCoins)
	emit_signal("Display",level)
	get_tree().paused = false
	if currentLevel != "res://Level3.tscn":
		anime2.play("Clouds")
	else:
		anime2.stop()
	sound.volume_db = PlayerInformation.soundVol
	if startTimer == true:
		timer.start(45)

	
func _physics_process(delta):
	
	axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	if Input.is_action_pressed("right") :
		velocity.x = lerp(velocity.x,moveSpeed,0.5)
		
	if Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x,-moveSpeed,0.5)
	if timer.time_left >= 0:
		time.text = "Time left for door " + str(timer.time_left)
	
	
	
	velocity.y +=  get_gravity() * delta
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true
		pause.popup()
	if Input.is_action_just_pressed("jump") && (is_on_floor() || jumpCount > 0 ):
		jump.play()
		jumpCount -= 1
		jump()
		
	
	if is_on_floor():
		jumpCount = Dexterity/2
		set_process_input(true)
		
	velocity = move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x,0,0.5)
	if axisX  > 0:
		animation.flip_h = false
		
		
	elif axisX < 0 :  
		animation.flip_h = true
		
		
		
	if axisX  > 0 and is_on_floor():
		animation.animation = "Running"	
		
	
	elif axisX  < 0 and is_on_floor():
		animation.animation = "Running"	
	elif is_on_floor():
		animation.animation = "Idle"
	if  !is_on_floor() and falling == false:
		animation.animation = "Jump"
	elif  !is_on_floor() and falling == true:
		animation.animation = "Fall"
	
	
	if experience == XPLimiit and fix == false:
		
		experience = experience - XPLimiit
		XPLimiit+= 1	
		musicpos = Music.get_playback_position()
		Music.stop()
		la.play("Up")
		LevelNotif.visible = true
		
		
		fix = true
		
	if damage >= health:
		Music.stop()
		GO.popup()

func Collect(num):
	sound.play()

func levelUp(var x):
	level += 1
	
	match x:
		1:
			 Strength += 1
			 JumpHeight = 100 + Strength * 20
		2:
			 Speed += 1
			 moveSpeed = 125 * Speed
			
			
		3:
			 Dexterity += 1
			 jumpCount =  Dexterity/2
		4:
			Skill += 1

		5:
			Body +=1
			emit_signal("Birth")
			health = health + 1
			
			
	
	LevelNotif.visible = false
	
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	
	la.stop()
	Leveling.hide()
	fix = false
	Music.play(musicpos)
	emit_signal("Display",level)
	
func get_gravity():
	
	
	if velocity.y < 0.0 or not is_on_wall():
		falling = false
		return jump_gravity 
	else:
		falling = true
		return fall_gravity
func jump():
		if  is_on_wall():
			emit_signal("lockControls")
			if animation.flip_h == true:
				velocity.x = moveSpeed * Skill
				velocity.y = jump_velocity
			elif animation.flip_h == false:
				velocity.x = -moveSpeed * Skill
				print("wall jump")
				velocity.y = jump_velocity
		else:
			velocity.y = jump_velocity 
	
		





func _on_PopupPanel_level(attribute):
	levelUp(attribute)





func _on_Enemy_Hit():
	if anime.is_playing() == false:
		emit_signal("takeDamage",health)
		anime.play("Damage")
		hurt.play()
		damage= damage + 1
		if animation.flip_h == true:
				velocity.x =500
				velocity.y = jump_velocity
		elif animation.flip_h == false:
				velocity.x =-500
				velocity.y = jump_velocity
		pass # Replace with function body.


func _on_Player_lockControls():
	lock =true# Replace with function body.





func _on_Saw_Hit():
	if anime.is_playing() == false:
		emit_signal("takeDamage",health)
		anime.play("Damage")
		hurt.play()
		damage= damage + 1
		if animation.flip_h == true:
				velocity.x =500
				velocity.y = jump_velocity
		elif animation.flip_h == false:
				velocity.x =-500
				velocity.y = jump_velocity
		if damage >= health:
			print("game over") #pass # Replace with function body.



func _on_CHolder_Amount(num):
	totalCoins = num-1 # Replace with function body.


func _on_GameOver_reset():
	emit_signal("Reset")
	position = StartPosition
	emit_signal("Display",level)
	totalCoins = 26
	emit_signal("Display2", totalCoins)
	

	velocity = Vector2(0,0)
	anime.stop(true)
	GO.hide()
	Music.play()
	get_tree().change_scene(currentLevel)

func passStatus():
	PlayerInformation.level	= level 	
	PlayerInformation.Strength = Strength
	PlayerInformation.Body = Body
	PlayerInformation.Speed = Speed 
	PlayerInformation.Dexterity = Dexterity
	PlayerInformation.Skill = Skill
	PlayerInformation.XPLimiit = XPLimiit
	PlayerInformation.experience = experience
	PlayerInformation.health = health
	damage = 0
	Music.stop()
func saveStats():
	PlayerInformation.level	= level 	
	PlayerInformation.Strength = Strength
	PlayerInformation.Body = Body
	PlayerInformation.Speed = Speed 
	PlayerInformation.Dexterity = Dexterity
	PlayerInformation.Skill = Skill
	PlayerInformation.XPLimiit = XPLimiit
	PlayerInformation.experience = experience
	PlayerInformation.health = health
	
func _on_END_win():
	passStatus()
	PlayerInformation.currentLevel = "res://Level2.tscn"
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://Level2.tscn")

func _on_END2_win():
	passStatus()
	PlayerInformation.currentLevel = "res://Level3.tscn"
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://Level3.tscn")
	


func _on_END3_win():
	PlayerInformation.reset()
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://mainmenu.tscn") # Replace with function body.


func _on_CoinSound_finished():
	experience+=1
	emit_signal("Display2", totalCoins)
	totalCoins-=1


func _on_LSound_finished():
			Leveling.popup_centered() # Replace with function body.


func _on_AnimationPlayer3_animation_finished(anim_name):
	LUS.play()


func _on_Timer_timeout():
	
	time.text = "The Door is Open go left" # Replace with function body.
	timer.stop()
