extends KinematicBody2D

var MovementVector = Vector2(0,0)
export var Speed = 150
export var Dash = 50
func _physics_process(delta):
	#common movement
	if Input.is_action_pressed("ui_left"):MovementVector.x = -Speed
	elif Input.is_action_pressed("ui_right"):MovementVector.x = Speed
	else:MovementVector.x = 0
	#gravity
	MovementVector.y = min(MovementVector.y + Speed * 2 * delta, 5000)
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
