extends TextureProgress

signal On_Skill_Acitvated
export var Cooldown = 0.1
export var Charge_Max = 1
export var Restore_Per_Sec = 100
export var Mana_Per_Use = 1000
export var Normal_Color = Color()
export var Charged_Color = Color()
export var Activate_Input = ""
export var Activate_Key = ""
var CD = 0.0
var Mana = 0.0
var Usable = true
var Activating = false
func _ready():
	Mana = Charge_Max * 1000
	$ShortCut/Label.text = Activate_Key
func _physics_process(delta):
	#Mana regenation and effect
	Mana = min(1000 * Charge_Max, Mana + Restore_Per_Sec * delta)
	$Charged.visible = Charge_Max > 1
	$Charged/Label.text = str(floor(Mana / 1000))
	if Mana < 1000 * Charge_Max:
		value = Mana - floor(Mana / 1000)*1000
	else:
		value = 1000
	if Mana <= 1000:
		tint_under = Color("4c4c4c")
		if Usable: tint_progress = Normal_Color
		else: tint_progress = Color(Normal_Color.r,Normal_Color.g,Normal_Color.b,0.5)
	else:
		tint_under = Normal_Color
		tint_progress = Charged_Color
	#Skill usage
	if Mana < Mana_Per_Use: Usable = false
	if Mana >= 1000: Usable = true
	$ShortCut/CoolDown.value = (Cooldown - CD)/Cooldown*100
	CD = max(0, CD - delta)
	if Input.is_action_just_pressed(Activate_Input):Activating = true
	if Input.is_action_just_released(Activate_Input):Activating = false
	if Activating:
		if ((CD==0) and (Mana>=Mana_Per_Use) and Usable):
			Mana -= Mana_Per_Use
			CD = Cooldown
			emit_signal("On_Skill_Acitvated")

func _on_Ball_OnJumpRefill():
	Mana = min(1000 * Charge_Max, Mana + 250)

func _on_button_down():
	Activating = true

func _onn_button_up():
	Activating = false
