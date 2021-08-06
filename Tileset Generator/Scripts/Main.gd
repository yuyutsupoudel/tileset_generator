extends Control

onready var HomeButton=get_node("Panel/HBoxContainer/LeftPanel/MarginContainer/VBoxContainer/HomeButton")
onready var TileButton=get_node("Panel/HBoxContainer/LeftPanel/MarginContainer/VBoxContainer/TileButton")
onready var HomePanel = get_node("Panel/HBoxContainer/VBoxContainer/HomePanel")
onready var TilePanel=get_node("Panel/HBoxContainer/VBoxContainer/TilePanel")

func _ready():
	_on_HomeButton_pressed()
	get_node("Panel/HBoxContainer/VBoxContainer/TilePanel/VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea").visible=false
	get_node("Panel/HBoxContainer/VBoxContainer/TilePanel/VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty").visible=false
	get_node("Panel/HBoxContainer/VBoxContainer/TilePanel/VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/Load").visible=false

func enable_all():
	HomeButton.pressed=false
	TileButton.pressed=false

func hide_all():
	HomePanel.visible=false
	TilePanel.visible=false
	
func _on_HomeButton_pressed():
	enable_all()
	hide_all()
	HomeButton.pressed=true
	HomePanel.visible=true


func _on_TileButton_pressed():
	enable_all()
	hide_all()
	TileButton.pressed=true
	TilePanel.visible=true



func _on_Button2_pressed():
	get_tree().reload_current_scene()
