extends CanvasLayer

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.connect("emit_speed", self._update_speed)

func _update_speed(speed: float) -> void:
	$Control/HBoxContainer/Value.text = str(abs(round(speed)))
