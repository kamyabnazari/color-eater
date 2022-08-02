# Author Kamyab Nazari - 2022

# Main menu page with all of the button to other pages
extends Control

# making nodes ready for referreence
onready var transition = $SceneTransition
onready var upgradeElements = $UpgradeElements
onready var liteElements = $LiteElements
onready var highScore = $NormalElements/HighScore
onready var coinCount = $NormalElements/CoinBar/Coins/CoinCount
onready var musicButton = $Settings/SettingsPanel/MusicSides/MusicButton
onready var soundButton = $Settings/SettingsPanel/SoundSides/SoundButton
onready var vibrationButton = $Settings/SettingsPanel/VibrationSides/VibrationButton
onready var heart1 = $LiteElements/LifeBar/Bar/Heart1
onready var heart2 = $LiteElements/LifeBar/Bar/Heart2
onready var heart3 = $LiteElements/LifeBar/Bar/Heart3
onready var immortalStar = $UpgradeElements/ImmortalStars/AnimationPlayer
onready var animationPlayer = $AnimationPlayer
onready var music = GameAudio.get_node("Music/MusicMainMenu")
onready var musicGame = GameAudio.get_node("Music/MusicGame")
onready var click = GameAudio.get_node("Effect/Click")
onready var switch = GameAudio.get_node("Effect/Switch")
onready var confirm = GameAudio.get_node("Effect/Confirm")

# loading images that are toggle able to another state
# Music Button Icons
var icon_music_note = preload("res://sprites/icon_music_note.png")
var icon_music_note_pressed = preload("res://sprites/icon_music_note_pressed.png")
var icon_music_off = preload("res://sprites/icon_music_off.png")
var icon_music_off_pressed = preload("res://sprites/icon_music_off_pressed.png")
# Volume Button Icons
var icon_volume_on = preload("res://sprites/icon_volume_on.png")
var icon_volume_on_pressed = preload("res://sprites/icon_volume_on_pressed.png")
var icon_volume_off = preload("res://sprites/icon_volume_off.png")
var icon_volume_off_pressed = preload("res://sprites/icon_volume_off_pressed.png")
# Vibration Button Textures
var icon_vibration_on = preload("res://sprites/icon_vibration_on.png")
var icon_vibration_on_pressed = preload("res://sprites/icon_vibration_on_pressed.png")
var icon_vibration_off = preload("res://sprites/icon_vibration_off.png")
var icon_vibration_off_pressed = preload("res://sprites/icon_vibration_off_pressed.png")

var icon_heart_on = preload("res://sprites/icon_heart_on.png")
var icon_heart_off = preload("res://sprites/icon_heart_off.png")

# Setting the changed global attributes after they have been toggled and saved
# inside of Globals Script.
func _ready():
	animationPlayer.play("background_animation")
	if(music.playing == false):
		musicGame.stop()
		music.play()
	
	# Setting the actual highscore and coins
	highScore.text = String(Globals.highscore)
	coinCount.text = String(Globals.coins)
	
	if(Globals.upgraded == true):
		upgradeElements.visible = true
		liteElements.visible = false
	
	if(Globals.musicOn == false):
		musicButton.set_normal_texture(icon_music_off)
		musicButton.set_hover_texture(icon_music_off_pressed)
		musicButton.set_pressed_texture(icon_music_off_pressed)
	if(Globals.soundOn == false):
		soundButton.set_normal_texture(icon_volume_off)
		soundButton.set_hover_texture(icon_volume_off_pressed)
		soundButton.set_pressed_texture(icon_volume_off_pressed)
	
	match Globals.lifes:
		0:
			heart1.set_texture(icon_heart_off)
			heart2.set_texture(icon_heart_off)
			heart3.set_texture(icon_heart_off)
		1:
			heart1.set_texture(icon_heart_on)
			heart2.set_texture(icon_heart_off)
			heart3.set_texture(icon_heart_off)
		2:
			heart1.set_texture(icon_heart_on)
			heart2.set_texture(icon_heart_on)
			heart3.set_texture(icon_heart_off)
		3:
			heart1.set_texture(icon_heart_on)
			heart2.set_texture(icon_heart_on)
			heart3.set_texture(icon_heart_on)

# The functions that triggers the style change

func button_is_pushed(target, style):
	var button_style = get_node(target)
	var style_pushed = load(style)
	button_style.set('custom_styles/panel', style_pushed)

# Button Functions to trigger Scene changes and other methods

func _on_CoinAddButton_pressed():
	confirm.play()
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://scenes/Shop.tscn")

func _on_CancelButton_pressed():
	click.play()
	$FadeCancel.visible = false
	get_node("Settings").move(Vector2(60, -500))

# Moving Buttons, where they switch styles, while being pushed down and up

func _on_TrophyButton_button_down():
	button_is_pushed("NormalElements/TrophySides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_TrophyButton_button_up():
	button_is_pushed("NormalElements/TrophySides", "res://styles/ButtonsSquare.tres")
	click.play()
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://scenes/Scoreboard.tscn")

func _on_ShopButton_button_down():
	button_is_pushed("NormalElements/ShopSides", "res://styles/Shop_Button_Pushed.tres")

func _on_ShopButton_button_up():
	click.play()
	button_is_pushed("NormalElements/ShopSides", "res://styles/Shop_Button.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://scenes/Shop.tscn")

func _on_SettingsButton_button_down():
	button_is_pushed("NormalElements/SettingsSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_SettingsButton_button_up():
	animationPlayer.play("fade_cancel")
	click.play()
	button_is_pushed("NormalElements/SettingsSides", "res://styles/ButtonsSquare.tres")
	$FadeCancel.visible = true
	get_node("Settings").move(Vector2(60, 250))

func _on_InfoButton_button_down():
	button_is_pushed("NormalElements/InfoSides", "res://styles/ButtonsRound_Pushed.tres")

func _on_InfoButton_button_up():
	click.play()
	button_is_pushed("NormalElements/InfoSides", "res://styles/ButtonsRound.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/AboutUs.tscn")

func _on_RefillButton_button_down():
	button_is_pushed("LiteElements/RefillSides", "res://styles/Refill_Button_Pushed.tres")

func _on_RefillButton_button_up():
	confirm.play()
	button_is_pushed("LiteElements/RefillSides", "res://styles/Refill_Button.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/Refill.tscn")

func _on_CoinAddButton_button_down():
	button_is_pushed("NormalElements/CoinAddSides", "res://styles/CoinAdd_Button_Pushed.tres")

func _on_CoinAddButton_button_up():
	confirm.play()
	button_is_pushed("NormalElements/CoinAddSides", "res://styles/CoinAdd_Button.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/CoinAdd.tscn")

func _on_UpgradeButton_button_down():
	button_is_pushed("LiteElements/UpgradeSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_UpgradeButton_button_up():
	confirm.play()
	button_is_pushed("LiteElements/UpgradeSides", "res://styles/ButtonsSquare.tres")
	upgradeElements.visible = true
	liteElements.visible = false
	# This Argument will get done thorugh the google play services (payment)
	Globals.upgraded = true

func _on_SoundButton_button_down():
	button_is_pushed("Settings/SettingsPanel/SoundSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_SoundButton_button_up():
	switch.play()
	button_is_pushed("Settings/SettingsPanel/SoundSides", "res://styles/ButtonsSquare.tres")
	if(AudioServer.is_bus_mute(2) == true):
		AudioServer.set_bus_mute(2, false)
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.soundOn = true
		soundButton.set_normal_texture(icon_volume_on)
		soundButton.set_pressed_texture(icon_volume_on_pressed)
	else:
		AudioServer.set_bus_mute(2, true)
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.soundOn = false
		soundButton.set_normal_texture(icon_volume_off)
		soundButton.set_pressed_texture(icon_volume_off_pressed)

func _on_MusicButton_button_down():
	button_is_pushed("Settings/SettingsPanel/MusicSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_MusicButton_button_up():
	switch.play()
	button_is_pushed("Settings/SettingsPanel/MusicSides", "res://styles/ButtonsSquare.tres")
	if(AudioServer.is_bus_mute(1) == true):
		AudioServer.set_bus_mute(1, false)
		music.play()
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.musicOn = true
		musicButton.set_normal_texture(icon_music_note)
		musicButton.set_pressed_texture(icon_music_note_pressed)
	else:
		music.stop()
		AudioServer.set_bus_mute(1, true)
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.musicOn = false
		musicButton.set_normal_texture(icon_music_off)
		musicButton.set_pressed_texture(icon_music_off_pressed)

func _on_VibrationButton_button_down():
	button_is_pushed("Settings/SettingsPanel/VibrationSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_VibrationButton_button_up():
	button_is_pushed("Settings/SettingsPanel/VibrationSides", "res://styles/ButtonsSquare.tres")
	if(Globals.vibrationOn == false):
		Input.vibrate_handheld(500)
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.vibrationOn = true
		vibrationButton.set_normal_texture(icon_vibration_on)
		vibrationButton.set_pressed_texture(icon_vibration_on_pressed)
	else:
		# Will have to be saved into a file save system and send to google play services (Save Games)
		Globals.vibrationOn = false
		vibrationButton.set_normal_texture(icon_vibration_off)
		vibrationButton.set_pressed_texture(icon_vibration_off_pressed)

func _on_PlayButton_button_down():
	button_is_pushed("NormalElements/PlaySides", "res://styles/Play_Button_Pushed.tres")

func _on_PlayButton_button_up():
	click.play()
	button_is_pushed("NormalElements/PlaySides", "res://styles/Play_Button.tres")
	if(Globals.playing == false):
		if(Globals.upgraded == false && Globals.lifes > 0):
			Globals.playing = $NormalElements/PlaySides/PlayButton.pressed
			var a_player = transition.fade_in()
			yield(a_player, "animation_finished")
			SceneManager.goto_scene("res://Scenes/Game.tscn")
		if(Globals.upgraded == true):
			Globals.playing = $NormalElements/PlaySides/PlayButton.pressed
			var a_player = transition.fade_in()
			yield(a_player, "animation_finished")
			SceneManager.goto_scene("res://scenes/Game.tscn")

func _on_CharactersButton_button_down():
	button_is_pushed("NormalElements/CharactersSides", "res://styles/ButtonsSquare_Pushed.tres")

func _on_CharactersButton_button_up():
	click.play()
	button_is_pushed("NormalElements/CharactersSides", "res://styles/ButtonsSquare.tres")
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://scenes/Characters.tscn")
