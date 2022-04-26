extends StaticBody2D

var Obj = null
func _physics_process(delta):
	if Obj != null:
		Obj.MovementVector.y = min(Obj.MovementVector.y + Obj.Speed * 2 * delta, 10000)
func _on_body_entered(body):
	if body.name == "Ball":
		Obj = body
func _on_body_exited(body):
	if body.name == "Ball":
		Obj = null
