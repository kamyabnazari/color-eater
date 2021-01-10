extends Node2D

func move(target):
	var move_tween = get_node("SettingsPanel/move_tween")
	move_tween.interpolate_property(self, "position", position, target, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()
