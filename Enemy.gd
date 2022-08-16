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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
		# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	 pass
		
	





func _on_Hitbox_area_entered(area):
	if(area.is_in_group("Player")):
		emit_signal("Hit")
	

func _on_Hitbox_body_entered(body1):
	if(body1.is_in_group("Player")):
		emit_signal("Hit")
	

