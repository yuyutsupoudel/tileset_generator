extends Control
onready var base=get_node("VBoxContainer/ScrollContainer/VBoxContainer")
onready var updatetemplate=preload("res://Scenes/Update.tscn")
onready var lineTemplate=preload("res://Scenes/Line.tscn")

var data=[{
		"note":"This version includes:",
		"version":"0.4",
		"name":"",
		"feature":["Wang export for godot has been added.","Custom inside Corner support has been implemented.","Tile edit window saving previous data has been fixed.","Better error message has been implemented."]},
		{
		"note":"This version includes:",
		"version":"0.3",
		"name":"",
		"feature":["Allows loading multiple tiles at the same time.","You can export to godot directly.","Bug fixes in tile editing window."]},
		{
		"note":"This version includes:",
		"version":"0.2",
		"name":"alpha",
		"feature":["Allows tile editing.","Supports tile layering.","Supports tile rotation.","Supports tile flip.","Supports cut off in all sides."]},
		{
		"note":"This version includes:",
		"version":"0.1",
		"name":"seed",
		"feature":["Wang tileset generation.","Blob tileset generation.","Export to PNG file.","Side scrolling tileset support,","Top Down tileset support."]},
	]

func _ready():
	for i in range(0,data.size()):
		var updateInstance=updatetemplate.instance()
		updateInstance.name=str(i)
		base.add_child(updateInstance)
		
		get_node("VBoxContainer/ScrollContainer/VBoxContainer/"+updateInstance.name+"/VBoxContainer/HBoxContainer/Label").text="V"+data[i].version

		get_node("VBoxContainer/ScrollContainer/VBoxContainer/"+updateInstance.name+"/VBoxContainer/HBoxContainer/Label2").text=data[i].name
		get_node("VBoxContainer/ScrollContainer/VBoxContainer/"+updateInstance.name+"/VBoxContainer/Label").text=data[i].note
		for j in range(0,data[i].feature.size()):
			var lineInstance=lineTemplate.instance()
			lineInstance.name=str(j)
			lineInstance.text="* "+data[i].feature[j]
			get_node("VBoxContainer/ScrollContainer/VBoxContainer/"+updateInstance.name+"/VBoxContainer/PanelContainer/VBoxContainer").add_child(lineInstance)

func _on_Youtube_pressed():
	OS.shell_open("https://www.youtube.com/channel/UCtzhClR1AdEctkf2lzptcvg")


func _on_Itchio_pressed():
	OS.shell_open("https://yusastudios.itch.io/")


func _on_Twitter_pressed():
	OS.shell_open("https://twitter.com/yusastudios")


func _on_Patreon_pressed():
	OS.shell_open("https://www.patreon.com/yusastudios")
