extends Node2D

@onready var CardTextures: Array[CompressedTexture2D] = []
@onready var card_template: PackedScene = load("res://scenes/card.tscn")

func get_card_textures(assetpath: String):
	var import_pattern = RegEx.new()
	import_pattern.compile(".import")

	var dir := DirAccess.open(assetpath)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				if !import_pattern.search(file_name):
					CardTextures.append(load(assetpath + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	print(CardTextures)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_card_textures("res://assets/sprites/front")
	var card := card_template.instantiate()
	card.set_card(0, CardTextures[0])
	add_child(card)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
