class_name Card
extends Node2D

@onready var number: int
@onready var is_revealed: bool = 0

signal flip(id: int)

func set_card(num:int, texture:CompressedTexture2D) -> void:
	number = num
	$BackSide/FrontSide.texture = texture

func animated_flip() -> void:
	if !is_revealed:
		$AnimationPlayer.play("flip")
	else:
		$AnimationPlayer.play_backwards("flip")
	is_revealed = !is_revealed

func flip_card() -> void:
	if $Timer.time_left > 0 or $SelectComponent.is_selected:
		return
	
	animated_flip()
	$Timer.start()
	
	#print("Node: %s, pressed" % get_instance_id())
	$SelectComponent.is_selected = !$SelectComponent.is_selected
	emit_signal("flip", get_instance_id())


func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("lmb") and !$SelectComponent.is_open:
		flip_card()

func get_response(is_gussed: bool) -> void:
	$SelectComponent.is_selected = false
	get_tree().create_timer(0.4).timeout.connect(ass.bind(is_gussed))


func ass(is_gussed: bool) -> void:
	#print(is_gussed)
	if is_gussed:
		$SelectComponent.is_open = true
		$SelectComponent/AnimationPlayer.play("check")
	else:
		animated_flip()
