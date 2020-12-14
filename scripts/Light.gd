extends Light2D

export var col = "blue"
var weights = 0

func set_active():
	enabled = weights > 0
	
func add_weight():
	weights += 1
	set_active()

func remove_weight():
	weights -= 1
	set_active()

func _ready():
	add_to_group(col)
	add_to_group("light")
