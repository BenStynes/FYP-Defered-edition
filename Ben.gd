extends KinematicBody2D

onready var animation = $ssSprite
var velocity = Vector2(0,0)
var moving = false

var Strength = 1
var Speed  = 1
var Dexterity =1
var Luck  = 1
var Body = 1


	
	
var moveSpeed = 30 * Speed-0.75

func _physics_process(delta):
	var axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	if Input.is_action_pressed("right"):
		velocity.x = moveSpeed
	if Input.is_action_pressed("left"):
		velocity.x = -moveSpeed
		
	move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x,0,0.1)
	if axisX  > 0:
		animation.animation = "Running"	
		animation.flip_h = false
	elif axisX  < 0:
		animation.animation = "Running"	
		animation.flip_h = true
	else:
		animation.animation = "Idle"	







func levelUp(var x):
	match x:
		1:
			 Strength += 1
		2:
			 Speed += 1
		3:
			 Dexterity += 1
		4:
			Luck += 1
		5:
			Body +=1
