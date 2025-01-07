extends Node2D

@onready var CardTextures: Array[CompressedTexture2D] = []
@onready var card_template: PackedScene = load("res://scenes/card.tscn")
@export var volume: int = 100

@onready var selected_cards: Array[int] = []

func get_card_textures(assetpath: String):
	var import_pattern = RegEx.new()
	import_pattern.compile(".import")

	var dir := DirAccess.open(assetpath)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				#print("Found file: " + file_name)
				if !import_pattern.search(file_name):
					CardTextures.append(load(assetpath + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	#print(CardTextures)


@export var h_separation: int = 10
@export var v_separation: int = 10 
func generate_grid() -> void:
	var n := len(CardTextures)
	var elements = []
	for i in range(n):
		for j in range(4):
			var card := card_template.instantiate()
			card.set_card(i, CardTextures[i])
			card.connect("flip", flip)
			elements.append(card)
	elements.shuffle()
	
	var columns: int = ceil(sqrt(len(elements)))
	var h_shift: int = CardTextures[0].get_width() + h_separation
	var v_shift: int = CardTextures[0].get_height() + v_separation
	for i in range(len(elements)):
		elements[i].position = Vector2i((i%columns)*h_shift, int(i/columns)*v_shift)
		$CardLayer.add_child(elements[i])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.volume_db -= (25.0 - volume/4.0)
	get_card_textures("res://assets/sprites/front")
	generate_grid()

func flip(id:int)->void:
	selected_cards.append(id)
	if len(selected_cards) == 2:
		var first: Node2D = instance_from_id(selected_cards[0])
		var second: Node2D = instance_from_id(selected_cards[1])
		#print(first.number, second.number)
		first.get_response(first.number == second.number)
		second.get_response(first.number == second.number)
		selected_cards.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
