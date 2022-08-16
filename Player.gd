extends KinematicBody2D

onready var animation = $ssSprite
onready var Collection =$Collect
onready var Leveling = $CanvasLayer/PopupPanel
onready var GO = $CanvasLayer/GameOver
onready var anime = $AnimationPlayer
signal takeDamage(health)
signal lockControls()
signal Reset()
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
var StartPosition = Vector2(1385,112)
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
	StartPosition = position
	totalCoins = get_parent().get_child(1).get_child_count() -1
func _physics_process(delta):
	
	axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	if Input.is_action_pressed("right") :
		velocity.x = lerp(velocity.x,moveSpeed,weight)
		
	if Input.is_action_pressed("left"):
		velocity.x = lerp(velocity.x,-moveSpeed,weight)
		
	
	
	velocity.y +=  get_gravity() * delta

	if Input.is_action_just_pressed("jump") && (is_on_floor() || jumpCount > 0 ):
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
		Leveling.popup_centered()
		
	if damage >= health:
			GO.popup_centered()

func Collect(num):
	experience+=1
	emit_signal("Display2", totalCoins)
	totalCoins-=1
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
	damage = 0
	level = 1
	Strength = 1
	Speed = 1
	Skill = 1
	Dexterity = 1
	Body = 1
	health = 3
	position = StartPosition
	emit_signal("Display",level)
	totalCoins = 26
	emit_signal("Display2", totalCoins)
	moveSpeed = 50 * Speed
	PeakTime = 0.5 - Skill/10
	JumpHeight = 50 + Strength * 20
	experience = 0
	XPLimiit = 1	
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	velocity = Vector2(0,0)
	
	
	anime.stop(true)
	GO.hide()
