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
signal takeDamage(health)
signal lockControls()
signal Reset()
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
var moveSpeed = 75 * Speed
var jumpCount = Dexterity
var lock = false
var totalCoins 
var StartPosition = Vector2(1440,110)
var weight = 0.05
signal Birth()
signal Display(level)
signal Display2(coin)

var JumpHeight : float = 50 + Strength * 20
var PeakTime: float = 0.5
var FallTime: float = 0.4
var health  = 3 
var damage = 0
onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
onready var wall_gravity : float = (-2.0 * JumpHeight) / (3 * 3) * -1.0

func _ready():
	position = StartPosition
	totalCoins = get_parent().get_child(1).get_child_count() -1
	level = PlayerInformation.level		
	Strength = PlayerInformation.Strength
	JumpHeight = 50 + Strength * 20
	Body = PlayerInformation.Body
	Speed = PlayerInformation.Speed
	Dexterity = PlayerInformation.Dexterity
	Skill = PlayerInformation.Skill
	XPLimiit = PlayerInformation.XPLimiit
	experience = PlayerInformation.experience
	health = PlayerInformation.health
	currentLevel = 	PlayerInformation.currentLevel
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	moveSpeed = 75 * Speed
	jumpCount =  Dexterity/2
	weight = Skill/100 + 0.05
	weight = min(weight,1)
	animation.self_modulate = PlayerInformation.color
	Music.volume_db = PlayerInformation.musicVol
	hurt.volume_db = PlayerInformation.soundVol
	jump.volume_db =  PlayerInformation.soundVol
	Music.play()
	emit_signal("Display2", totalCoins)
	emit_signal("Display",level)
	get_tree().paused = false
	if currentLevel != "res://Level3.tscn":
		anime2.play("Clouds")
	else:
		anime2.stop()
	sound.volume_db = PlayerInformation.soundVol
func _physics_process(delta):
	
	axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	if Input.is_action_pressed("right") :
		velocity.x = lerp(velocity.x,moveSpeed,weight)
		
	if Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x,-moveSpeed,weight)
		
	
	
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

	velocity.x = lerp(velocity.x,0,weight)
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
	
	
	if experience == XPLimiit:
		Music.stop()
		Leveling.popup_centered()
		
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
			 JumpHeight = 50 + Strength * 20
		2:
			 Speed += 1
			 moveSpeed = 75 * Speed
			
			
		3:
			 Dexterity += 1
			 jumpCount =  Dexterity/2
		4:
			Skill += 1
			weight = Skill/100 + 0.05
			weight = min(weight +0.1,1)
		5:
			Body +=1
			emit_signal("Birth")
			health = health + 1
			
			
	experience = 0
	XPLimiit+= 1	
	
	
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	
	
	Leveling.hide()
	Music.play()
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
				velocity.x = moveSpeed * 3
				velocity.y = jump_velocity
			elif animation.flip_h == false:
				velocity.x = -moveSpeed * 3
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
	passStatus()
	get_tree().root.get_node("Level").queue_free()
	get_tree().change_scene("res://Node2D.tscn") # Replace with function body.


func _on_CoinSound_finished():
	experience+=1
	emit_signal("Display2", totalCoins)
	totalCoins-=1
