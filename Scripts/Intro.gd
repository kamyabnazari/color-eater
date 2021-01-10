extends Control

# Preparing Nodes to be used in the code
onready var transition = $SceneTransition

# After the end of Intro Video the finish singal -> changes to Main Scene
func _on_IntroVideoPlayer_finished():
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/Main.tscn")
