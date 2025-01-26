class_name Save extends Resource

@export var high_score: int = 0

const save_path: String = "user://high_score_table.tres"


func save() -> void:
	ResourceSaver.save(self, save_path)


static func load_or_create() -> Save:
	
	var res: Save
	if FileAccess.file_exists(save_path):
		res = load(save_path) as Save
	else:
		res = Save.new()
		
	return res
