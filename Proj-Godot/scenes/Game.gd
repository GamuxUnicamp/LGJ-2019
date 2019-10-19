extends Node2D

onready var ingredient0_scene = load("res://scenes/ingredients/BatWing.tscn")
onready var ingredient1_scene = load("res://scenes/ingredients/FrogLeg.tscn")
onready var ingredient2_scene = load("res://scenes/ingredients/Mushroom.tscn")
onready var ingredient3_scene = load("res://scenes/ingredients/DragonEye.tscn")
onready var ingredient4_scene = load("res://scenes/ingredients/CatEar.tscn")


func _ready():
	randomize()
	$Timer.connect("timeout",self,"spawn_ingredient")
	set_physics_process(true)

func spawn_ingredient():
	var ingredient
	var ingredient_type =  randi()%5
	if ingredient_type == 0:
		ingredient = ingredient0_scene.instance()
	elif ingredient_type == 1:
		ingredient = ingredient1_scene.instance()
	elif ingredient_type == 2:
		ingredient = ingredient2_scene.instance()
	elif ingredient_type == 3:
		ingredient = ingredient3_scene.instance()
	elif ingredient_type == 4:
		ingredient = ingredient4_scene.instance()
	var spawn_point = randi()%2
	var impulse_direction = randf()*11+1
	ingredient.connect("clicked",self,"ingredient_clicked")
	if spawn_point == 0:
		$SpawnPoint1.add_child(ingredient)
		ingredient.impulse_from_right()
	else:
		$SpawnPoint2.add_child(ingredient)
		ingredient.impulse_from_left()

func _physics_process(delta):
	#remove non-visible ingredients from screen
	for ingredient in $SpawnPoint1.get_children():
		var y = ingredient.global_position.y
		if y >2000:
			ingredient.queue_free()

func ingredient_clicked(name):
	print("ingredient clicked")
	if "BatWing".is_subsequence_of(name):
		print("BAT WING!")
	elif "FrogLeg".is_subsequence_of(name):
		print("FROG_LEG!")
	elif "Mushroom".is_subsequence_of(name):
		print("MUSHROOM!")
	elif "DragonEye".is_subsequence_of(name):
		print("DRAGON EYE!")
	elif "CatEar".is_subsequence_of(name):
		print("CAT EAR!")

