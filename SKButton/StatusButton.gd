extends TextureProgress

export var Activate_Input = ""
export var Activate_Key = ""
export var MaxValue = 1.0
export var Value = 0.0
export var Cooldown = 0.1
export var Restore_Per_Sec = 100
export var Mana_Per_Use = 1000
export var BlankCooldown = 0.25
export var SKColor = Color(1,0,1,1)
export var TimeMode = false
var Mana = 0.0
var CD = 0.0
var Activating = false
var Usable = true
var BlankCD = 0.25
var BlankFadeOut = true
signal On_Skill_Activated

func _ready():
	$Skill.tint_progress = SKColor
	if Activate_Input == "":
		$ShortCut.visible = false
	$ShortCut/Label.text = Activate_Key
func _physics_process(delta):
	#status handler
	value = Value / MaxValue * 1000
	#Time effect (it is hard bruh)
	if TimeMode:
		Value = max(0, Value - delta)
		if value>750:
			tint_progress = Color(0,(1000 - value)/250,1,1)
		elif value>500:
			tint_progress = Color(0,1,(value - 500)/250,1)
		elif value>250:
			tint_progress = Color((500 - value)/250,1,0,1)
		else:
			tint_progress = Color(1,value / 250,0,1)
	else:
		tint_progress.b = Value / MaxValue
	$Value.text = str(int(Value))
	if value <= 100:
		if BlankFadeOut:
			BlankCD = max(0,BlankCD - delta)
			if BlankCD == 0:BlankFadeOut = false
		else:
			BlankCD = min(BlankCD + delta,BlankCooldown)
			if BlankCD == BlankCooldown:BlankFadeOut = true
	tint_progress.a = BlankCD / BlankCooldown
	#skill handler
	Mana = min(1000 ,Mana + delta * Restore_Per_Sec)
	if Mana < Mana_Per_Use:Usable = false
	if Mana == 1000:Usable = true
	if Usable:
		$Skill.tint_progress = Color($Skill.tint_progress.r,$Skill.tint_progress.g,$Skill.tint_progress.b,1)
	else:
		$Skill.tint_progress = Color($Skill.tint_progress.r,$Skill.tint_progress.g,$Skill.tint_progress.b,0.5)
	$Skill.value = Mana
	$ShortCut.value = (Cooldown - CD) / Cooldown * 100
	CD = max(0,CD - delta)
	if Input.is_action_just_pressed(Activate_Input):Activating = true
	if Input.is_action_just_released(Activate_Input):Activating = false
	if Activating:
		if ((CD==0) and (Mana>=Mana_Per_Use) and Usable):
			Mana -= Mana_Per_Use
			CD = Cooldown
			emit_signal("On_Skill_Acitvated")


func _on_button_down():
	Activating = true

func _on_button_up():
	Activating = false
