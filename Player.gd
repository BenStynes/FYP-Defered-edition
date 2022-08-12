extends KinematicBody2D

onready var animation = $ssSprite
onready var Collection =$Collect
onready var Leveling = $CanvasLayer/PopupPanel
onready var anime = $AnimationPlayer
signal takeDamage(health)
signal lockControls()
signal Reset()
var velocity = Vector2(0,0)
var moving = false

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
var moveSpeed = 50 * Speed-0.75
var jumpCount = Dexterity
var lock = false
signal Birth()

var JumpHeight : float = 50 + Strength * 20
var PeakTime: float = 0.5 - Skill/10
var FallTime: float = 0.4
var health  = 3 
var damage = 0
onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
onready var wall_gravity : float = (-2.0 * JumpHeight) / (3 * 3) * -1.0
	
func _physics_process(delta):
	
	axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_pressed("right") :
		velocity.x = moveSpeed
	if Input.is_action_pressed("left"):
		velocity.x = -moveSpeed
	
	
	velocity.y +=  get_gravity() * delta
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("Reset")
	if Input.is_action_just_pressed("jump") && (is_on_floor() || jumpCount > 0 ):
		jumpCount -= 1
		jump()
		
	
	if is_on_floor():
		jumpCount = Dexterity
		set_process_input(true)
		
	velocity = move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x,0,0.1)
	
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
		
	

func Collect():
	experience+=1
	
func levelUp(var x):
	
	var bod = false
	match x:
		1:
			 Strength += 1
		2:
			 Speed += 1
		3:
			 Dexterity += 1
		4:
			Skill += 1
		5:
			Body +=1
			emit_signal("Birth")
			health = health + 1
			
			
	experience = 0
	XPLimiit+= 1	
	moveSpeed = 50 * Speed
	JumpHeight  = 50 + Strength * 20
	PeakTime = 0.5 - Skill/10
	jump_velocity = (2.0* JumpHeight) / PeakTime * -1.0
	jump_gravity = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
	fall_gravity =   (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
	jumpCount =  Dexterity
	
	Leveling.hide()
	if(bod):
	
		bod = false
	
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
		if damage >= health:
			print("game over") #pass # Replace with function body.


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

