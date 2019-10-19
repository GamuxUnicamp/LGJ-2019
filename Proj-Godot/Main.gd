extends Control

func _ready() ->void:
	$ButtonPlay.connect("button_down",self,"play_button_down")
	$ButtonQuit.connect("button_down",self,"quit_button_down")
	pass

func play_button_down() ->void:
	get_tree().change_scene("res://scenes/Game.tscn")
	pass

func quit_button_down() ->void:
	get_tree().quit()