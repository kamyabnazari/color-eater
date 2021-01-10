# Shop System
extends Control

onready var transition = $SceneTransition
onready var backButton = $Elements/BackButton/TheBackButton

func _ready():
	backButton.connect("button_down", self, "_on_BackButton_button_down")
	backButton.connect("button_up", self, "_on_BackButton_button_up")

# The function that triggers the style change

func button_is_pushed(target, style):
	var button_style = get_node(target)
	var style_pushed = load(style)
	button_style.set('custom_styles/panel', style_pushed)

func _on_BackButton_button_down():
	button_is_pushed("Elements/BackButton", "res://Styles/ButtonsSquare_Pushed.tres")

func _on_BackButton_button_up():
	$Elements/BackButton.backAction()
	button_is_pushed("Elements/BackButton", "res://Styles/ButtonsSquare.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/Main.tscn")
