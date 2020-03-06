extends Control

onready var file = $FileDialog

onready var dir = $HBoxContainer/VBoxContainer/HBoxContainer/dir

onready var from = $HBoxContainer/VBoxContainer/HBoxContainer2/from
onready var to = $HBoxContainer/VBoxContainer/HBoxContainer2/to

#var path := ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_FileDialog_dir_selected(_dir: String) -> void:
#	path = _dir
	dir.text = _dir


func _on_select_pressed() -> void:
	file.popup_centered()



func change_file_type():
	var file_list = get_file_list()
	
	if file_list == null:
		return
	
	if file_list.size() != 0:
		print(' ')
		print('from\tto')
		print(from.text + '\t' + to.text)
		change_type(file_list)
	else:
		print('not match any file.')


func get_file_list():
	var d := Directory.new()
	var regex := RegEx.new()
	
	var file_list := []
	
	print(' ')
	print('path:: ' + dir.text)
	
	if d.open(dir.text) == OK:
		print('exist.')
		d.list_dir_begin()
		var file_name = d.get_next()
		while file_name != "":
			if not d.current_is_dir():
				regex.compile('[*.](' + from.text + ')$')
				
				var result = regex.search(file_name)
				
				if result:
					file_list.append(dir.text + '/' + file_name)
			file_name = d.get_next()
	else:
		print("An error occurred when trying to access the path.")
		return null
	
	return file_list
	

func change_type(file_list: Array):
	var d := Directory.new()
	
	for file_path in file_list:
		if d.file_exists(file_path):
#			var file_name = file_path.get_basename()
#			var file_name = file_path.get_extension()
#			print(file_name)
#			print(file_name.find('.'))
			
			var ft = file_path.replace(from.text, to.text)
#			print()
#			print(file_path)
#			print(ft)
			d.rename(file_path, ft)
			
			
#			d.rename('icon.'+ from.text, 'icon.' + to.text)
			
	

	
	pass
