extends Control

onready var confirm = GameAudio.get_node("Effect/Confirm")

func _process(_delta):
	match Globals.curPlayer:
		1:
			$LeftButton.visible = false
			$RightButton.visible = true
		13:
			$LeftButton.visible = true
			$RightButton.visible = false
		_:
			$LeftButton.visible = true
			$RightButton.visible = true

func _on_RightButton_pressed():
	if(Globals.curPlayer < 13 && $PlayersList/Players/move_tween.is_active() == false):
		confirm.play()
		get_node("PlayersList").move(Vector2($PlayersList.position.x - 613, $PlayersList.position.y))
		Globals.curPlayer += 1
		if(Globals.curPlayer == 13):
			$RightButton.visible = false

func _on_LeftButton_pressed():
	if(Globals.curPlayer >= 2 && $PlayersList/Players/move_tween.is_active() == false):
		confirm.play()
		get_node("PlayersList").move(Vector2($PlayersList.position.x + 613, $PlayersList.position.y))
		Globals.curPlayer -= 1
		if(Globals.curPlayer == 1):
			$LeftButton.visible = false
