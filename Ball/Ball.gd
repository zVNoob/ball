extends KinematicBody2D

signal OnJumpRefill
var MovementVector = Vector2(0,0)
export var Speed = 150
export var Dash = 50
var Floating = 0
var Is_Touching_Floor =false
func _physics_process(delta):
	#refill jump skill one time if collided with floor or celling
	if (get_slide_count()>0) and (!Is_Touching_Floor):
		for i in range(get_slide_count()):
			if "Wall" in get_slide_collision(i).collider.name:
				Is_Touching_Floor = true
				emit_signal("OnJumpRefill")
				break
	if get_slide_count()==0:Is_Touching_Floor = false
	#float skill helper
	Floating = max(0, Floating - delta)
	#common movement
	if Input.is_action_pressed("ui_left"):MovementVector.x = -Speed
	elif Input.is_action_pressed("ui_right"):MovementVector.x = Speed
	else:MovementVector.x = 0
	#gravity
	if Floating == 0:MovementVector.y = min(MovementVector.y + Speed * 2 * delta, 5000)
	#apply vector to object
	MovementVector = move_and_slide(MovementVector)

func _on_FailSkill_Acitvated():
	MovementVector.y = 5000

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
