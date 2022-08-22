extends Node
var currentLevel =  "res://Level.tscn"
var level = 1
var Strength  =1
var Speed  =1
var Dexterity =1
var Skill=1
var Body = 1
var experience = 0 
var XPLimiit  = 1
var health = 3
var color = Color.white
var damage = 0
var position = Vector2(1440,110)
var screensize = 0
var musicVol = 0
var soundVol = 0
func setter(stg,sp,dex,skill,body,limit,xp,lvl):
	 level = lvl
	 Speed = sp
	 Strength = stg
	 Dexterity = dex
	 Body = body
	 experience = xp
	 Skill = skill
	 XPLimiit = limit
	
func set_color(colour):
	color = colour
func reset():
 currentLevel =  "res://Level.tscn"
 level = 1
 Strength  =1
 Speed  =1
 Dexterity =1
 Skill=1
 Body = 1
 experience = 0 
 XPLimiit  = 1
 health = 3 
 damage = 0
 position = Vector2(1440,110)
	
