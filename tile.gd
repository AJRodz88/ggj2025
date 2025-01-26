extends Node2D
#This is basically just a sprite that changes to another sprite when the player cleans

@onready var IsClean: bool = false
var DirtyTileTexture = load("res://Sprites/Tile.png")
var CleanTileTexture = load("res://Sprites/CleanTile.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ResetTile():
	position = Vector2(GameManager.RightEdge, position.y)
	
	if IsClean == true:
		IsClean = false
		$Sprite2D.texture = DirtyTileTexture
	

func CleanTile():
	$Sprite2D.texture = CleanTileTexture
	IsClean = true
	GameManager.Score += 1
	#print("Score: ", GameManager.Score)
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		CleanTile()
	pass # Replace with function body.
