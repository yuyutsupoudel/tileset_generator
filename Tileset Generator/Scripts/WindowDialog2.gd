extends WindowDialog
onready var rotation=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/Rotation")
onready var hflip=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/HBoxContainer2/HBoxContainer/CheckBox")
onready var vflip=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/HBoxContainer2/HBoxContainer2/CheckBox")
onready var cut_top=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/LineEdit")
onready var cut_right=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/LineEdit2")
onready var cut_bottom=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/LineEdit3")
onready var cut_left=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/LineEdit4")
onready var layer1=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button1")
onready var layer2=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button2")
onready var layer3=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button3")
onready var layer1Texture=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button1/CenterContainer/TextureRect")
onready var layer2Texture=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button2/CenterContainer/TextureRect")
onready var layer3Texture=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button3/CenterContainer/TextureRect")
onready var ErrorBox=get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/ErrorBox")
var emptyTexture=preload("res://Assets/Buttons/empty.png")
var is_first_present
var is_second_present
var is_third_present
var tempImage = Image.new()
var temp
var current_layer=0
var last_pressed=-1
var template={
	"type":"",
	"layer":[]
}

func unpress_all():
	layer1.pressed=false
	layer2.pressed=false
	layer3.pressed=false

func set_data(data:Dictionary):
	
	rotation.selected=data.rotation
	hflip.pressed=data.hflip
	vflip.pressed=data.vflip
	cut_top.text=String(data.cut_top)
	cut_right.text=String(data.cut_right)
	cut_bottom.text=String(data.cut_bottom)
	cut_left.text=String(data.cut_left)
	
func _on_WindowDialog2_about_to_show():
	var emptyData={
				"rotation":0,
				"hflip":false,
				"vflip":false,
				"cut_top":0,
				"cut_right":0,
				"cut_bottom":0,
				"cut_left":0,
				"image":null,
				"imageTexture":null
				}
	set_data(emptyData)
	unpress_all()
	var TypeName
	match get_parent().allTexture[get_parent().current_pressed].type:
		0:
			TypeName="Top Left"
		1:
			TypeName="Top Center"
		2:
			TypeName="Top Right"
		3:
			TypeName="Middle Left"
		4:
			TypeName="Middle Center"
		5:
			TypeName="Middle Right"
		6:
			TypeName="Bottom Left"
		7:
			TypeName="Bottom Center"
		8:
			TypeName="Bottom Right"
		9:
			TypeName="Inside Top Left"
		10:
			TypeName="Inside Top Right"
		11:
			TypeName="Inside Bottom Left"
		12:
			TypeName="Inside Bottom Right"
	get_node("HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer2/VBoxContainer/HBoxContainer/Values/Type").text=TypeName
	#apply texture in main area
	if get_parent().allTexture[get_parent().current_pressed].has("imageTexture"):
		get_node("HBoxContainer/MarginContainer/PanelContainer/MarginContainer/TextureRect").texture=get_parent().allTexture[get_parent().current_pressed].imageTexture
	else:
		get_node("HBoxContainer/MarginContainer/PanelContainer/MarginContainer/TextureRect").texture=emptyTexture
	#setting up subtype data
	if !get_parent().allTexture[get_parent().current_pressed].has("subtype"):
		get_parent().allTexture[get_parent().current_pressed].subtype=[]
		get_parent().allTexture[get_parent().current_pressed].subtype.resize(3)
		for i in range(0,3):
			get_parent().allTexture[get_parent().current_pressed].subtype[i]={
				"rotation":0,
				"hflip":false,
				"vflip":false,
				"cut_top":0,
				"cut_right":0,
				"cut_bottom":0,
				"cut_left":0,
				"image":null,
				"imageTexture":null
				}
	
	update_layer_images()

func _on_layer_pressed(layer):
	if last_pressed!=-1:
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].rotation=rotation.selected
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].hflip=hflip.pressed
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].vflip=vflip.pressed
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].cut_top=int(cut_top.text)
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].cut_right=int(cut_right.text)
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].cut_bottom=int(cut_bottom.text)
		get_parent().allTexture[get_parent().current_pressed].subtype[last_pressed].cut_left=int(cut_left.text)
	
	match layer:
		0:
			current_layer=layer
			unpress_all()
			layer1.pressed=true
			last_pressed=layer
			set_data(get_parent().allTexture[get_parent().current_pressed].subtype[0])
		1:
			current_layer=layer
			unpress_all()
			layer2.pressed=true
			last_pressed=layer
			set_data(get_parent().allTexture[get_parent().current_pressed].subtype[1])
		2:
			current_layer=layer
			unpress_all()
			layer3.pressed=true
			last_pressed=layer
			set_data(get_parent().allTexture[get_parent().current_pressed].subtype[2])

func _on_FileDialog_file_selected(path):
	tempImage.load(path)
	if tempImage.get_size()!=Vector2 (Global.new_file_property.size,Global.new_file_property.size):
		get_parent().set_text("ERROR: File size does not match with project size.")
		ErrorBox.text="ERROR: Look at main page for more detail."
		yield(get_tree().create_timer(0.2),"timeout")
		ErrorBox.text=""
		return
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].image=Image.new()
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].image.load(path)
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].imageTexture=ImageTexture.new()
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].imageTexture.create_from_image(get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].image)
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].imageTexture.flags=0
	update_layer_images()
	
func update_layer_images():
	for i in range(0,3):
		var layer="HBoxContainer/MarginContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Button"+str(i+1)+"/CenterContainer/TextureRect"
		if get_parent().allTexture[get_parent().current_pressed].subtype[i].imageTexture!=null:
			get_node(layer).texture=get_parent().allTexture[get_parent().current_pressed].subtype[i].imageTexture
		else:
			get_node(layer).texture=emptyTexture

func _on_Button_pressed():
	if last_pressed==-1:
		ErrorBox.text="ERROR: Look at main page for more detail."
		get_parent().set_text("ERROR: Please select a layer to load texture.")
		yield(get_tree().create_timer(2),"timeout")
		ErrorBox.text=""
		return
	get_node("../FileDialog3").popup()

func _on_Apply_pressed():
	_on_layer_pressed(last_pressed)
	temp=Image.new()
	temp.create(Global.new_file_property.size,Global.new_file_property.size,0,5)
	#checks if any of layer is loaded or not
	is_third_present=Generate_tile(get_parent().allTexture[get_parent().current_pressed].subtype[2],temp)
	is_second_present=Generate_tile(get_parent().allTexture[get_parent().current_pressed].subtype[1],temp)
	is_first_present=Generate_tile(get_parent().allTexture[get_parent().current_pressed].subtype[0],temp)
	
	if is_first_present==true or is_second_present==true or is_third_present==true:
		var testTexture=ImageTexture.new()
		testTexture.create_from_image(temp)
		testTexture.flags=0
		get_node("HBoxContainer/MarginContainer/PanelContainer/MarginContainer/TextureRect").texture=testTexture
		return
	if get_parent().allTexture[get_parent().current_pressed].subtype[0].image!=null or get_parent().allTexture[get_parent().current_pressed].subtype[1].image!=null or get_parent().allTexture[get_parent().current_pressed].subtype[2].image!=null:
		set_error("ERROR: Look at main panel for more details.")
	else:
		set_error("ERROR: Look at main panel for more details.")
		get_parent().set_text("")
		get_parent().set_text("ERROR: All layers are empty. Please make sure you have loaded at least one layer.")
		get_parent().set_text("WARNING: If you selected tiles from main panel, those are not editable.")
		get_parent().set_text("NOTE: If you want to edit them, you need to load tile once again in any of 3 layer.")
		get_parent().set_text("")
func Generate_tile(data:Dictionary,destination:Image):
	if data.image!=null:
		data.image.lock()
	else:
		return false
	var current_image=Image.new()
	current_image.create(Global.new_file_property.size,Global.new_file_property.size,false,5)
	current_image.lock()
	destination.lock()
	#rotation
	match data.rotation:
		0:#0 degree
			for i in range(0,Global.new_file_property.size):
				for j in range(0,Global.new_file_property.size):
					var pixel=data.image.get_pixel(i,j)
					if pixel!=Color(0,0,0,0):
						current_image.set_pixel(i,j,pixel)
		1:#90 degree
			for i in range(0,Global.new_file_property.size):
				for j in range(0,Global.new_file_property.size):
					var pixel=data.image.get_pixel(i,j)
					if pixel!=Color(0,0,0,0):
						current_image.set_pixel(Global.new_file_property.size-j-1,i,pixel)
			
		2:#180 degree
			for i in range(0,Global.new_file_property.size):
				for j in range(0,Global.new_file_property.size):
					var pixel=data.image.get_pixel(i,j)
					if pixel!=Color(0,0,0,0):
						current_image.set_pixel(Global.new_file_property.size-i-1,Global.new_file_property.size-1-j,pixel)
		3:#270 degree
			for i in range(0,Global.new_file_property.size):
				for j in range(0,Global.new_file_property.size):
					var pixel=data.image.get_pixel(i,j)
					if pixel!=Color(0,0,0,0):
						current_image.set_pixel(j,Global.new_file_property.size-1-i,pixel)
	#flip
	if data.hflip==true:
		current_image.flip_x()
	if data.vflip==true:
		current_image.flip_y()
		
	#Cut off
	#cut from top
	if data.cut_top>Global.new_file_property.size/2:
		get_parent().set_text("ERROR: Cut Top can not be more than :"+str(Global.new_file_property.size/2)+".")
		set_error("ERROR: Look at main page for more detail.")
		return false
	else:
		for i in range(0,int(data.cut_top)):
			for j in range(0,Global.new_file_property.size):
				current_image.set_pixel(j,i,Color(0,0,0,0))
	#cut from right
	if data.cut_right>Global.new_file_property.size/2:
		get_parent().set_text("ERROR: Cut right can not be more than :"+str(Global.new_file_property.size/2)+".")
		set_error("ERROR: Look at main page for more detail.")
		return false
	else:
		for i in range(0,int(data.cut_right)):
			for j in range(0,Global.new_file_property.size):
				current_image.set_pixel(Global.new_file_property.size-i-1,j,Color(0,0,0,0))
	#cut from bottom
	if data.cut_bottom>Global.new_file_property.size/2:
		get_parent().set_text("ERROR: Cut Bottom can not be more than :"+str(Global.new_file_property.size/2)+".")
		set_error("ERROR: Look at main page for more detail.")
		return false
	else:
		for i in range(0,int(data.cut_bottom)):
			for j in range(0,Global.new_file_property.size):
				current_image.set_pixel(j,Global.new_file_property.size-i-1,Color(0,0,0,0))
	#cut from left
	if data.cut_left>Global.new_file_property.size/2:
		get_parent().set_text("ERROR: Cut left can not be more than : "+str(Global.new_file_property.size/2)+".")
		set_error("ERROR: Look at main page for more detail.")
		return false
	else:
		for i in range(0,int(data.cut_left)):
			for j in range(0,Global.new_file_property.size):
				current_image.set_pixel(i,j,Color(0,0,0,0))

#copies generated image into actual destination
	for i in range(0,Global.new_file_property.size):
		for j in range(0,Global.new_file_property.size):
			var pixel=current_image.get_pixel(i,j)
			if pixel!=Color(0,0,0,0):
				destination.set_pixel(i,j,pixel)
	current_image.unlock()
	data.image.unlock()
	destination.unlock()
	return true

func _on_Save_pressed():
	_on_Apply_pressed()
	if is_first_present==false and is_second_present==false and is_third_present==false:
		get_parent().set_text("ERROR: Nothing to save.")
		self.hide()
		return
	get_parent().allTexture[get_parent().current_pressed].image=Image.new()
	get_parent().allTexture[get_parent().current_pressed].image.copy_from(temp)
	get_parent().allTexture[get_parent().current_pressed].imageTexture=ImageTexture.new()
	get_parent().allTexture[get_parent().current_pressed].imageTexture.create_from_image(temp)
	get_parent().allTexture[get_parent().current_pressed].imageTexture.flags=0
	#update tiles
	get_parent()._on_texture_pressed(get_parent().current_pressed)
	self.hide()
	
func _on_Clear_pressed():
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].image=null
	get_parent().allTexture[get_parent().current_pressed].subtype[current_layer].imageTexture=null
	_on_Apply_pressed()
	update_layer_images()

func set_error(message:String):
		ErrorBox.text=message
		yield(get_tree().create_timer(2),"timeout")
		ErrorBox.text=""
