# The SceneManager is an Autoloaded Singletone that initiates propare 
# Scene changes through out the application.
extends Node

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# Goto Scene function waits for the current scene to finish first and
# then calls for _deffered_goto_scene to start the changing process
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	
	current_scene.free()
	
	var new_scene = ResourceLoader.load(path)
	
	current_scene = new_scene.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
