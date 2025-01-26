extends Node

@onready var Score: int = 0
var RightEdge: float = 1280
@onready var playerIsDead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func RoomClean():
	for i in get_tree().get_nodes_in_group("Tile"):
		if i.IsClean == false:
			i.CleanTile()
	
	for i in get_tree().get_nodes_in_group("Obstacle"):
		i.Clean()
