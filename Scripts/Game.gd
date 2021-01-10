extends Node2D

onready var transition = $SceneTransition
onready var scoreShow = $GameElements/Score
onready var player = $GameElements/KinematicBody2D/Player
onready var touchButton = $TouchScreenButton
onready var musicMain = GameAudio.get_node("Music/MusicMainMenu")
onready var musicGame = GameAudio.get_node("Music/MusicGame")
onready var playerChar = load(String("res://Sprites/Player_") + String(Globals.curPlayer) + ".png")

func _ready():
	player.texture = playerChar
	player.texture = playerChar
	player.scale = Vector2(0.3, 0.3)
	Globals.messagesShowing = false
	# Stopping the Main Menu music and starting the GAME tracks
	musicMain.stop()
	musicGame.play()
	# Will have to be saved into a file save system and send to google play services (Save Games)
	Globals.lifes -= 1

var time = 0

func _process(_delta):
	time += 1
	if(Globals.score > int(scoreShow.text)):
		scoreShow.text = String(int(scoreShow.text) + 1)
	if(time > 150):
		player.visible = false
		$GameElements/EnemyBody/Enemy.visible = false
		$GameElements/Score.visible = false
		Globals.coins += Globals.score
		_on_loss()

func _on_loss():
	if(Globals.score > Globals.highscore):
		Globals.highscore = Globals.score
	Globals.score = 0
	Globals.playing = false
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/Main.tscn")

func _on_TouchScreenButton_pressed():
	time = 0
