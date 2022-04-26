extends KinematicBody2D

signal OnJumpRefill
export var  MovementVector = Vector2(0,0)
export var Speed = 150
export var Dash = 50
#Object/skill effect cooldown 
var Floating = 0
var Falling = false
var Is_Touching_Floor =false
var Moving = 0.05
var Pulling = false

func _physics_process(delta):
	if (get_slide_count()>0) and (!Is_Touching_Floor):
		for i in range(get_slide_count()):
			#Wall detection -> refill jump skill one time
			if "Wall" in get_slide_collision(i).collider.name:
				Is_Touching_Floor = true
				emit_signal("OnJumpRefill")
			#Bounce platform detection -> bounce, x3 if falling
			if "Bounce" in get_slide_collision(i).collider.name:
				if Falling:
					Falling = false
					MovementVector.y = -Speed * 3
				else:MovementVector.y = -Speed
			#Pull area detection -> force a gravity
			if "Pull" in get_slide_collision(i).collider.name:
				MovementVector.y = min(MovementVector.y + Speed * 8 * delta, 10000)
	if get_slide_count()==0:Is_Touching_Floor = false
	#cooldown helper
	Floating = max(0, Floating - delta)
	Moving = max(0, Moving - delta)
	if MovementVector.y == 0:Falling = false
	#common movement
	if Moving == 0: MovementVector.x = 0
	#if Input.is_action_pressed("ui_left"):MovementVector.x = -Speed
	#elif Input.is_action_pressed("ui_right"):MovementVector.x = Speed
	#else:MovementVector.x = 0
	#gravity
	if Floating == 0:MovementVector.y = min(MovementVector.y + Speed * 2 * delta, 10000)
	#apply vector to object
	MovementVector = move_and_slide(MovementVector)

func _on_FailSkill_Acitvated():
	MovementVector.y = 5000
	Falling = true
	emit_signal("OnJumpRefill")

func _on_JumpSkill_Acitvated():
	MovementVector.y = -Speed * 1.6

func _on_FlySkill_Acitvated():
	MovementVector.y = -Speed

func _on_DashSkill_Acitvated():
	if MovementVector.y>25:position.y = min(position.y + Dash, 567)
	if MovementVector.y<-25:position.y = max(position.y - Dash, 14)
	if MovementVector.x>0:position.x = min(1285, position.x + Dash)
	if MovementVector.x<0:position.x = max(15, position.x - Dash)

func _on_FloatSkill_Acitvated():
	Floating = 0.1
	MovementVector.y = 0


func _on_TurnLeft():
	MovementVector.x = -Speed
	Moving = 0.05

func _on_TurnRight():
	MovementVector.x = Speed
	Moving = 0.05
