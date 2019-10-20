extends Node2D

enum Ingredients {COGUMELO, DRAGAO, GATO, MORCEGO, SAPO}

onready var ingredient0_scene = load("res://scenes/ingredients/BatWing.tscn")
onready var ingredient1_scene = load("res://scenes/ingredients/FrogLeg.tscn")
onready var ingredient2_scene = load("res://scenes/ingredients/Mushroom.tscn")
onready var ingredient3_scene = load("res://scenes/ingredients/DragonEye.tscn")
onready var ingredient4_scene = load("res://scenes/ingredients/CatEar.tscn")
onready var tween = $Tween
onready var caldron_position = get_node("CauldronPosition").get_global_position()

var mission = [[0,0],[0,0]]

func _ready():
	choose_mission()
	$Timer.connect("timeout",self,"spawn_ingredient")
	set_physics_process(true)

func spawn_ingredient():
	var ingredient
	var ingredient_type =  randi()%5
	if ingredient_type == Ingredients.COGUMELO:
		ingredient = ingredient0_scene.instance()
	elif ingredient_type == Ingredients.DRAGAO:
		ingredient = ingredient1_scene.instance()
	elif ingredient_type == Ingredients.GATO:
		ingredient = ingredient2_scene.instance()
	elif ingredient_type == Ingredients.MORCEGO:
		ingredient = ingredient3_scene.instance()
	elif ingredient_type == Ingredients.SAPO:
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

func go_to_caldron(body):
	tween.interpolate_method(body, "set_global_position", body.global_position, caldron_position, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()

func ingredient_clicked(body):
	go_to_caldron(body)
	if "BatWing".is_subsequence_of(body.name):
		print("BAT WING!")
		for i in range(2):
			if mission[i][0] == Ingredients.MORCEGO and mission[i][1] > 0:
				mission[i][1] -= 1
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(mission[i][1]))
				else:
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(mission[i][1]))
				
	elif "FrogLeg".is_subsequence_of(body.name):
		print("FROG_LEG!")
		for i in range(2):
			if mission[i][0] == Ingredients.SAPO and mission[i][1] > 0:
				mission[i][1] -= 1
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(mission[i][1]))
				else:
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(mission[i][1]))
		
	elif "Mushroom".is_subsequence_of(body.name):
		print("MUSHROOM!")
		for i in range(2):
			if mission[i][0] == Ingredients.COGUMELO and mission[i][1] > 0:
				mission[i][1] -= 1
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(mission[i][1]))
				else:
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(mission[i][1]))
	
	elif "DragonEye".is_subsequence_of(body.name):
		print("DRAGON EYE!")
		for i in range(2):
			if mission[i][0] == Ingredients.DRAGAO and mission[i][1] > 0:
				mission[i][1] -= 1
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(mission[i][1]))
				else:
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(mission[i][1]))
	
	elif "CatEar".is_subsequence_of(body.name):
		print("CAT EAR!")
		for i in range(2):
			if mission[i][0] == Ingredients.GATO and mission[i][1] > 0:
				mission[i][1] -= 1
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(mission[i][1]))
				else:
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(mission[i][1]))
	
	if mission[0][1] <= 0 and mission[1][1] <= 0:
		completed()

func completed():
	var completed = $Completed
	var tween = $Completed/Tween
	tween.interpolate_method(completed, "set_position", completed.rect_global_position, Vector2(0,620), 2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
	
	$Timer.stop()

func choose_mission():
	var random_ingredient = -1
	for i in range(2):
		randomize()
		var random = int(rand_range(0,5))
		while random == random_ingredient:
			random = int(rand_range(0,5))
		
		random_ingredient = random
		mission[i][0] = random_ingredient
		
		randomize()
		var quantity = int(rand_range(5,15))
		mission[i][1] = quantity
		
		match random_ingredient:
			Ingredients.COGUMELO:
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Item.set_texture(load("res://images/cogumelo.png"))
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(quantity))
				else:
					$GUI/Container/Background/Container/Item_2/Item.set_texture(load("res://images/cogumelo.png"))
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(quantity))
			Ingredients.DRAGAO:
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Item.set_texture(load("res://images/dragao.png"))
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(quantity))
				else:
					$GUI/Container/Background/Container/Item_2/Item.set_texture(load("res://images/dragao.png"))
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(quantity))
			Ingredients.GATO:
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Item.set_texture(load("res://images/gato.png"))
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(quantity))
				else:
					$GUI/Container/Background/Container/Item_2/Item.set_texture(load("res://images/gato.png"))
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(quantity))
			Ingredients.MORCEGO:
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Item.set_texture(load("res://images/morcego.png"))
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(quantity))
				else:
					$GUI/Container/Background/Container/Item_2/Item.set_texture(load("res://images/morcego.png"))
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(quantity))
			Ingredients.SAPO:
				if i == 0:
					$GUI/Container/Background/Container/Item_1/Item.set_texture(load("res://images/sapo.png"))
					$GUI/Container/Background/Container/Item_1/Number.set_text(str(quantity))
				else:
					$GUI/Container/Background/Container/Item_2/Item.set_texture(load("res://images/sapo.png"))
					$GUI/Container/Background/Container/Item_2/Number.set_text(str(quantity))


func _on_Tween_completed(object, key):
	object.queue_free()

func _on_PlayAgain_pressed():
	get_tree().reload_current_scene()
