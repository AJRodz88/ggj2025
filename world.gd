extends Node2D

@onready var BackgroundWidth: int = 48
@onready var BackgroundHeight: int = 16

var bubbleTimer: float = 1.5
var platformTimer: float = 1.2
var resetTimer: float = 1.5
var scrollSpeed: float = 400
const levelGroupNames = [preload("res://level_group_1.tscn"), preload("res://level_group_2.tscn"), preload("res://level_group_3.tscn"), preload("res://level_group_4.tscn"), preload("res://level_group_5.tscn")]

var currentLevel
enum LevelGroups{
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().content_scale_size = Vector2i(GameManager.RightEdge-32, 640)
	resetTimer = 1.5
	GameManager.playerIsDead = false
	
	for i in BackgroundWidth:
		for j in BackgroundHeight:
			var newTile = preload("res://tile.tscn").instantiate()
			newTile.position = Vector2(i * 32, j * 32)
			newTile.top_level = true
			add_child(newTile)
	pass # Replace with function body.
	
	
	var startGroup = randi_range(0, LevelGroups.size()-1)
	currentLevel = LevelGroups.values()[startGroup]
	var levelGroup2 = levelGroupNames[startGroup].instantiate()
	levelGroup2.position = Vector2(GameManager.RightEdge,0)
	add_child(levelGroup2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Score.text = "Score: " + str(GameManager.HighScore)
	if GameManager.playerIsDead == true:
		resetTimer -= delta
		
		if resetTimer <= 0:
			GameManager.HighScore = 0
			#GameManager.Save()
			get_tree().reload_current_scene()
		
		return
	
	
	var stillScrolling = false
	for t in get_tree().get_nodes_in_group("Tile"):
		if t.position.x < GameManager.RightEdge:
			stillScrolling = true
	
	bubbleTimer += delta
	
	for s in get_tree().get_nodes_in_group("Scrolling"):
		s.position = Vector2(s.position.x - scrollSpeed * delta, s.position.y)
		if s.position.x < - 32 and s.is_in_group("Tile"):
			s.ResetTile()

	for l in get_tree().get_nodes_in_group("LevelGroup"):
		if l.position.x < -1 * GameManager.RightEdge:
			l.queue_free()
		
		if l.position.x > -1 * GameManager.RightEdge and l.position.x < 600 and get_tree().get_nodes_in_group("LevelGroup").size() <= 1:
			var r = randi_range(0,LevelGroups.size()-1)
			if r == currentLevel:
				if r == LevelGroups.size()-1:
					r == LevelGroups.ONE
				else:
					r += 1
					
			currentLevel = LevelGroups.values()[r]
			var levelGroup = levelGroupNames[r].instantiate()
			levelGroup.position = Vector2(GameManager.RightEdge + 600,0)
			add_child(levelGroup)

			
	
func MakePlatforms():
	var newPlat = preload("res://platform.tscn").instantiate()
	newPlat.position = Vector2(randi_range(GameManager.RightEdge, GameManager.RightEdge + 10), randi_range(300,400))
	add_child(newPlat)	
	
	
func MakeTiles():
	for i in BackgroundWidth:
		for j in BackgroundHeight:
			var newTile = preload("res://tile.tscn").instantiate()
			newTile.position = Vector2(i * 32 + GameManager.RightEdge, j * 32)
			newTile.top_level = true
			add_child(newTile)
