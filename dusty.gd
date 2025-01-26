extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Game Over!")
		body.TakeHit()
		
	pass # Replace with function body.

func Clean():
	var newBubble = preload("res://bubble.tscn").instantiate()
	newBubble.position = Vector2(position)
	get_parent().add_child(newBubble)
	queue_free()
	pass
