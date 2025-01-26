extends Node

@onready var HighScore: int = 0
var RightEdge: float = 1280
@onready var playerIsDead: bool = false
var save_data: Save

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#save_data = Save.load_or_create()
	#HighScore = save_data.high_score
	HighScore = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AddScore(point: int) -> void:
	HighScore += point

func RoomClean():
	for i in get_tree().get_nodes_in_group("Tile"):
		if i.IsClean == false:
			i.CleanTile()
	
	for i in get_tree().get_nodes_in_group("Obstacle"):
		i.Clean()

func Save() -> void:
	save_data.high_score = HighScore
	save_data.save()
