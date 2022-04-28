extends Area2D

var Target
func _ready():
	Target = get_parent().get_parent().get_node("Skill")
func _on_JumpBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("JumpSkill")
		var Choose = randi() % 3
		if Choose == 0:Temp.Cooldown = Temp.Cooldown * 9 / 10
		if Choose == 1:Temp.Charge_Max += 1
		if Choose == 2:Temp.Restore_Per_Sec += 25
		queue_free()


func _on_FallBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("FallSkill")
		var Choose = randi() % 2
		if Choose == 0:Temp.Cooldown = Temp.Cooldown * 9.5 / 10
		if Choose == 1:Temp.Restore_Per_Sec += 50
		queue_free()
func _on_FlyBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("FlySkill")
		var Choose = randi() % 2
		if Choose == 0:Temp.Restore_Per_Sec += 50
		if Choose == 1:Temp.Mana_Per_Use * 9.5 /10
		queue_free()


func _on_DashBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("JumpSkill")
		var Choose = randi() % 3
		if Choose == 0:Temp.Cooldown = Temp.Cooldown * 9.5 / 10
		if Choose == 1:Temp.Charge_Max += 1
		if Choose == 2:Temp.Restore_Per_Sec += 25
		queue_free()


func _on_FloatBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("FloatSkill")
		var Choose = randi() % 2
		if Choose == 0:Temp.Mana_Per_Use *= 0.95
		if Choose == 1:Temp.Restore_Per_Sec += 10
		queue_free()


func _on_TimeBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("Time")
		Temp.Value += 10
		if Temp.Value > Temp.MaxValue:
			Temp.MaxValue = Temp.Value
		queue_free()


func _on_HealthBuff(body):
	if "Ball" == body.name:
		var Temp = Target.get_node("Health")
		Temp.Value += 2
		if Temp.Value > Temp.MaxValue:
			Temp.MaxValue = Temp.Value
		queue_free()
