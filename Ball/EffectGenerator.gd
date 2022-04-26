extends Node2D

export var EffectCooldown = 0.01
var CD = EffectCooldown
var Target
var Effect = preload("res://Ball/Effect.tscn")
func _ready():
	Target = get_parent().get_node("Ball")
func _physics_process(delta):
	CD -= delta
	if CD < 0:
		var Temp = Effect.instance()
		Temp.position = Target.position
		add_child(Temp)
		CD = EffectCooldown
