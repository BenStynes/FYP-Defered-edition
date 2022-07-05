extends KinematicBody2D

onready var animation = $ssSprite
var velocity = Vector2(0,0)
var moving = false

var Strength = 1
var Speed  = 1
var Dexterity =2
var Skill  = 1
var Body = 1
var falling = false

	
	
var moveSpeed = 50 * Speed-0.75
var jumpCount =  1



var JumpHeight : float = 100 + Strength * 20
var PeakTime: float = 0.5 - Skill/10
var FallTime: float = 0.4 

onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0

	
func _physics_process(delta):
	
	var axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_pressed("right"):
		velocity.x = moveSpeed
	if Input.is_action_pressed("left"):
		velocity.x = -moveSpeed
	
	velocity.y +=  get_gravity() * delta
	if Input.is_action_just_pressed("jump") and(is_on_floor() or jumpCount > 0):
		
		jump()
		
		
	if is_on_floor():
		jumpCount = Dexterity/2
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
	

	


func levelUp(var x):
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
			
func get_gravity():
	
	
	if velocity.y < 0.0:
		falling = false
		return jump_gravity 
	else:
		falling = true
		return fall_gravity
func jump():
	velocity.y = jump_velocity
	if(jumpCount > 0):
		jumpCount -= 1
		
