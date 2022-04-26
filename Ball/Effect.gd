extends Sprite

export var CoolDown = 0.2
var CD = CoolDown
func _physics_process(delta):
	CD -= delta
	self_modulate.a = CD / CoolDown
	if CD < 0:queue_free()
	
