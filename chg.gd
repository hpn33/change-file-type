extends Button

onready var from = $'../from'
onready var to = $'../to'


func _on_chg_pressed() -> void:
	var t = from.text
	from.text = to.text
	to.text = t
