class_name Card
extends Node2D

@onready var number: int = -1
@onready var is_revealed: bool = 0

func set_card(num:int, texture:CompressedTexture2D) -> void:
	number = num
	$BackSide/FrontSide.texture = texture

func flip_card() -> void:
	if !is_revealed:
		$AnimationPlayer.play("flip")
	else:
		$AnimationPlayer.play_backwards("flip")
	is_revealed = !is_revealed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("lmb"):
		flip_card()
