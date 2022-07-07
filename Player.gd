extends KinematicBody2D

onready var animation = $ssSprite
var velocity = Vector2(0,0)
var moving = false
onready var wall = $WallJump
var Strength = 1
var Speed  = 2
var Dexterity =1
var Skill  = 1
var Body = 1
var falling = false
var onWall = false
var axisX
	
var moveSpeed = 50 * Speed-0.75
var jumpCount =  1



var JumpHeight : float = 50 + Strength * 20
var PeakTime: float = 0.5 - Skill/10
var FallTime: float = 0.4

onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
onready var wall_gravity : float = (-2.0 * JumpHeight) / (3 * 3) * -1.0
	
func _physics_process(delta):
	
	axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_pressed("right") and not is_on_wall():
		velocity.x = moveSpeed
	if Input.is_action_pressed("left") and not  is_on_wall():
		velocity.x = -moveSpeed
	
	
	velocity.y +=  get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and( is_on_floor() or is_on_wall() or jumpCount > 0):
		 
		jump()
		
		
	if is_on_floor():
		if(Dexterity > 1):
			jumpCount = Dexterity/2
		else:
			jumpCount = 1 
		
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
	
	
	if velocity.y < 0.0 or not is_on_wall():
		falling = false
		return jump_gravity 
	else:
		falling = true
		return fall_gravity
func jump():
	if  is_on_wall():
		if animation.flip_h == true:
			velocity.x = moveSpeed * 3
		elif animation.flip_h == false:
			velocity.x = -moveSpeed * 3
			print("wall jump")
			velocity.y = jump_velocity  * 0.5	
	else:
		velocity.y = jump_velocity 
	if(jumpCount > 0):
		jumpCount -= 1
		
