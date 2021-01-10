# The about us page with an OS function to open web browesers.
extends Control

onready var transition = $SceneTransition
onready var backButton = $Elements/BackButton/TheBackButton
onready var sound_Click = GameAudio.get_node("Effect/Click")

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

func _on_WebsiteLinkButton_button_down():
	button_is_pushed("Elements/WebsiteSides", "res://Styles/ButtonsRound_Pushed.tres")

func _on_WebsiteLinkButton_button_up():
	sound_Click.play()
	button_is_pushed("Elements/WebsiteSides", "res://Styles/ButtonsRound.tres")
	var validate = OS.shell_open("https://kamyworldproductions.com")
	# It should give a on screen message that it is note able to visit
	if(validate != OK):
		print("System does not support OS Shell command")
