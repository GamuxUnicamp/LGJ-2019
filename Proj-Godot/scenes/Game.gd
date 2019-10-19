extends Node2D

var ingredient1_scene

func _ready() ->void:
	randomize()
	ingredient1_scene = load("res://scenes/ingredients/BatWing.tscn")
	$Timer.connect("timeout",self,"spawn_ingredients")
	set_physics_process(true)

func spawn_ingredients() ->void:
	var ingredient = ingredient1_scene.instance()
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

