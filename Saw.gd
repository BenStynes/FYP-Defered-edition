extends KinematicBody2D
onready var body = $Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var JumpHeight : float = 50 
var PeakTime: float = 0.5 
var FallTime: float = 0.4
var l := Line2D.new()   

signal Hit()
onready var jump_velocity : float = (2.0* JumpHeight) / PeakTime * -1.0
onready var jump_gravity : float = (-2.0 * JumpHeight) / (PeakTime * PeakTime) *  -1.0
onready var fall_gravity : float = (-2.0 * JumpHeight) / (FallTime * FallTime) * -1.0
var moveSpeed = 100
export (NodePath) var patrolPath
onready var path = get_node(patrolPath)
var patrolPoints 
var patrolIndex = 0
var velocity = position 
var doOnce = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	if patrolPath: 
		patrolPoints = path.curve.get_baked_points()
		
		# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
				
		
	if!patrolPath:
		return

		
	var target = patrolPoints[patrolIndex]
	
	
	l.add_point(target ) 
	if position.distance_to(target) <1:
		patrolIndex = wrapi(patrolIndex + 1,0,patrolPoints.size())
		target = patrolPoints[patrolIndex]
	velocity = (target - position).normalized() * moveSpeed 
	velocity.y += fall_gravity * delta
	
	velocity = move_and_slide(velocity)
	





func _on_Hitbox_area_entered(area):
	if(area.is_in_group("Player")):
		emit_signal("Hit")
	

func _on_Hitbox_body_entered(body1):
	if(body1.is_in_group("Player")):
		emit_signal("Hit")

