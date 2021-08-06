extends Control


onready var optionButton = get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Editarea/OptionButton3")
onready var textArea=get_node("VBoxContainer/CentrePanel3/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TextEdit")

var current_pressed=-1
var topLeft:Dictionary
var topCenter:Dictionary
var topRight:Dictionary
var middleLeft:Dictionary
var middleCenter:Dictionary
var middleRight:Dictionary
var bottomLeft:Dictionary
var bottomCenter:Dictionary
var bottomRight:Dictionary
var insideTopLeft:Dictionary
var insideTopRight:Dictionary
var insideBottomLeft:Dictionary
var insideBottomRight:Dictionary

var tempImage = Image.new()
var tempImage2 = Image.new()
var tempImageTexture= ImageTexture.new()
var wangTilesetTexture=ImageTexture.new()
var blobTilesetTexture=ImageTexture.new()
#var wangTileset

var current_line = 0

var allTexture =[topLeft,topCenter,topRight,middleLeft,middleCenter,middleRight,bottomLeft,bottomCenter,bottomRight,insideTopLeft,insideTopRight,insideBottomLeft,insideBottomRight]

func _ready():
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/Load").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/LoadFolder").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/Edit").visible=false
	get_node("FileDialog").add_filter("*.png;PNG Files")
	get_node("FileDialog3").add_filter("*.png;PNG Files")
	get_node("FileDialog4").add_filter("*.png;PNG Files")
	set_text("HINT: Create new project file first.")
	for i in range(0,13):
		allTexture[i].type=i

func set_text(text:String):
	textArea.set_line(current_line,text+"\n")
	current_line=current_line+1
	textArea.update()
	
func unpress_all():
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/0").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/1").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/2").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/3").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/4").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/5").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/6").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/7").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/8").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/9").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/10").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/11").pressed=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/12").pressed=false
func _on_New_pressed():
	var new_type=get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/CreateNew/VBoxContainer3/OptionButton")
	Global.new_file_property.size=get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/CreateNew/VBoxContainer3/OptionButton2").get_selected_id()
	Global.new_file_property.type=new_type.get_item_text(new_type.selected)
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/CreateNew").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/New").visible=false
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea").visible=true
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty").visible=true
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/Load").visible=true
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/LoadFolder").visible=true
	get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonAreaLeft/Edit").visible=true
	set_text("HINT: Click on tiles and press  Load to load texture.")
	if Global.new_file_property.type!="Isomatric":
		get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Editarea/OptionButton3").visible=false
		get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Comma/Label").visible=false
		get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Name/Layer").visible=false

func set_data(data:Dictionary,index:int):
	var file = get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Editarea/file")
	if Global.new_file_property.type=="Isomatric":
		if data.has("layer"):
			optionButton.selected=data.layer
		else:
			optionButton.selected=0
	
	if data.has("file"):
		file.text=data.file
	else:
		file.text="null"
	
	if data.has("image"):
		if index<9:
			var grid=get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer")
			var TextureReact="VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer/"+grid.get_child(index).name+"/CenterContainer/TextureRect"
			get_node(TextureReact).texture=data.imageTexture
		else:
			var grid=get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer")
			var TextureReact="VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/"+grid.get_child(index-9).name+"/CenterContainer/TextureRect"
			get_node(TextureReact).texture=data.imageTexture

func _on_texture_pressed(index):
	
	if Global.new_file_property.type=="Isomatric":
		var layerOption=get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TextureProperty/Editarea/OptionButton3")
		if current_pressed!=-1:
			if layerOption.selected!=0:
				for i in range(0,13):
					if allTexture[i].type==current_pressed:
						allTexture[i].layer=layerOption.selected
						break
	unpress_all()
	current_pressed=index
	for i in range(0,13):
		if allTexture[i].type==current_pressed:
			set_data(allTexture[i],index)
			break
	var gridContainer="VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/CenterContainer/GridContainer"
	match index:
		0:
			get_node(gridContainer+"/0").pressed=true
		
		1:
			get_node(gridContainer+"/1").pressed=true

		2:
			get_node(gridContainer+"/2").pressed=true

		3:
			get_node(gridContainer+"/3").pressed=true

		4:
			get_node(gridContainer+"/4").pressed=true

		5:
			get_node(gridContainer+"/5").pressed=true

		6:
			get_node(gridContainer+"/6").pressed=true

		7:
			get_node(gridContainer+"/7").pressed=true

		8:
			get_node(gridContainer+"/8").pressed=true
		9:
			get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/9").pressed=true
		10:
			get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/10").pressed=true
		11:
			get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/11").pressed=true
		12:
			get_node("VBoxContainer/HBoxContainer/CentrePanel2/VBoxContainer/SliceArea/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/12").pressed=true

func _on_Load_pressed():
	
	if current_pressed==-1:
		set_text("ERROR: Select a tile first.")
		return
	get_node("FileDialog").popup_centered()

func _on_FileDialog_file_selected(path):
	tempImage2.load(path)
	if tempImage2.get_size()!=Vector2 (Global.new_file_property.size,Global.new_file_property.size):
		set_text("ERROR: File size does not match with project size. File name: "+path.split("/")[-1])
		return
	for i in range(0,13):
		if current_pressed==allTexture[i].type:
			allTexture[i].file=path
			allTexture[i].image=Image.new()
			allTexture[i].image.load(path)
			allTexture[i].imageTexture=ImageTexture.new()
			allTexture[i].imageTexture.create_from_image(allTexture[i].image)
			allTexture[i].imageTexture.flags=0
			allTexture[i].image.lock()
			set_data(allTexture[i],current_pressed)
			break

func _on_ToWang_pressed():
	#checking if base tile is loaded or not
	for i in range(0,13):
		if allTexture[i].type==4 and allTexture[i].has("image"):
			break
		if i==8:
			set_text("ERROR: No central tile avaiable. Please select first.")
			return
		 
	#saves layer data of last selected tile for isomatric tiles
	if Global.new_file_property.type=="Isomatric":
		if current_pressed!=-1 and optionButton.selected!=0 :
			for i in range(0,13):
				if allTexture[i].type==current_pressed:
					allTexture[i].layer=optionButton.selected
					break
					
	#if mode is not isomatric, sets layer automatically
	if Global.new_file_property.type!="Isomatric":
		for i in range(0,13):
			if allTexture[i].has("image"):
				allTexture[i].layer=str(i+1)
			
	#checks if layer for all selected tiles has been added or not
	for i in range(0,13):
		if allTexture[i].has("image") and !allTexture[i].has("layer"):
			set_text("ERROR: You must select a layer for each tile.")
			set_text("       Select layer for tile no: "+ str(allTexture[i].type+1)+".")
			return
	
	#sorting texture based upon layer
	for i in range(0,allTexture.size()-1):
		for j in range(0,allTexture.size()-i-1):
			if allTexture[j].has("layer")==false:
				var temp=allTexture[j]
				allTexture[j]=allTexture[j+1]
				allTexture[j+1]=temp
				
			elif allTexture[j+1].has("layer")==false:
				continue
			elif allTexture[j].layer<allTexture[j+1].layer:
				var temp=allTexture[j]
				allTexture[j]=allTexture[j+1]
				allTexture[j+1]=temp
			elif allTexture[j].layer==allTexture[j+1].layer:
				set_text("ERROR: Layers are same for two tiles: "+str(allTexture[j].type+1)+" and "+str(allTexture[j+1].type+1))
				return
	#generating tiles
	var wangSize_x=Global.new_file_property.size*5
	var wangSize_y=Global.new_file_property.size*3
	Global.wangTileset=Image.new()
	Global.wangTileset.create(wangSize_x,wangSize_y,false,5)
	Global.wangTileset.lock()
	
	if Global.new_file_property.type!="Isomatric":
		#draws the base layer first
		for i in range(0,13):
			match allTexture[i].type:
				4:
					if allTexture[i].has("image"):
						copy_tile([1,1],[7,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[9,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[3,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[5,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[7,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[3,5],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[5,5],allTexture[i].image,Global.wangTileset)
						copy_tile([1,1],[7,5],allTexture[i].image,Global.wangTileset)
						
						copy_tile([2,1],[8,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[10,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[2,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[4,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[10,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[2,5],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[4,5],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[10,5],allTexture[i].image,Global.wangTileset)
						
						copy_tile([1,2],[3,2],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[5,2],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[7,2],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[3,4],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[5,4],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[7,4],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[9,4],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[9,6],allTexture[i].image,Global.wangTileset)
						
						copy_tile([2,2],[2,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[4,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[10,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[2,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[4,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[8,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[10,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[8,6],allTexture[i].image,Global.wangTileset)
						
					else:
						break
		#draws all others
		for i in range(0,13):
			match allTexture[i].type:
				0:
					if allTexture[i].has("image"):
						copy_tile([1,1],[1,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[2,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[1,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[2,2],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([2,1],[8,5],allTexture[i].image,false,false)
						copy_trangle([1,2],[7,6],allTexture[i].image,false,false)
						
					else:
						break
				1:
					if allTexture[i].has("image"):
						copy_tile([1,1],[3,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[4,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[3,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[4,2],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([1,1],[9,3],allTexture[i].image,true,false)
						copy_trangle([2,1],[8,3],allTexture[i].image,false,false)
					else:
						break
				2:
					if allTexture[i].has("image"):
						copy_tile([1,1],[5,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[6,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[5,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[6,2],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([1,1],[9,5],allTexture[i].image,true,false)
						copy_trangle([2,2],[10,6],allTexture[i].image,true,false)
						
					else:
						break
				3:
					if allTexture[i].has("image"):
						copy_tile([1,1],[1,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[2,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[1,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[2,4],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([1,1],[9,2],allTexture[i].image,false,false)
						copy_trangle([1,2],[9,3],allTexture[i].image,true,true)
						
					else:
						break
					
				5:
					if allTexture[i].has("image"):
						copy_tile([1,1],[5,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[6,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[5,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[6,4],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([2,1],[8,3],allTexture[i].image,false,true)
						copy_trangle([2,2],[8,2],allTexture[i].image,true,false)
					else:
						break
				6:
					if allTexture[i].has("image"):
						copy_tile([1,1],[1,5],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[2,5],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[1,6],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[2,6],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([1,1],[9,5],allTexture[i].image,true,true)
						copy_trangle([2,2],[10,6],allTexture[i].image,true,true)
					else:
						break
				7:
					if allTexture[i].has("image"):
						copy_tile([1,1],[3,5],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[4,5],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[3,6],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[4,6],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([2,2],[8,2],allTexture[i].image,true,true)
						copy_trangle([1,2],[9,2],allTexture[i].image,false,true)
						
					else:
						break
				8:
					if allTexture[i].has("image"):
						copy_tile([1,1],[5,5],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[6,5],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[5,6],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[6,6],allTexture[i].image,Global.wangTileset)
						
						copy_trangle([2,1],[8,5],allTexture[i].image,false,true)
						copy_trangle([1,2],[7,6],allTexture[i].image,false,true)
					else:
						break
		for i in range(0,13):
			match allTexture[i].type:
				9:
					if allTexture[i].has("image"):
						copy_tile([1,1],[07,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[08,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[07,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[08,2],allTexture[i].image,Global.wangTileset)
					else:
						break
				10:
					if allTexture[i].has("image"):
						copy_tile([1,1],[09,1],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[10,1],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[09,2],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[10,2],allTexture[i].image,Global.wangTileset)
					else:
						break
				11:
					if allTexture[i].has("image"):
						copy_tile([1,1],[07,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[08,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[07,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[08,4],allTexture[i].image,Global.wangTileset)
						
						copy_tile([2,1],[08,5],allTexture[i].image,Global.wangTileset)
					else:
						break
				12:
					if allTexture[i].has("image"):
						copy_tile([1,1],[09,3],allTexture[i].image,Global.wangTileset)
						copy_tile([2,1],[10,3],allTexture[i].image,Global.wangTileset)
						copy_tile([1,2],[09,4],allTexture[i].image,Global.wangTileset)
						copy_tile([2,2],[10,4],allTexture[i].image,Global.wangTileset)
						
						copy_tile([1,1],[09,5],allTexture[i].image,Global.wangTileset)
					else:
						break
	if Global.new_file_property.type=="Isomatric":
			pass
	
	wangTilesetTexture.create_from_image(Global.wangTileset)
	wangTilesetTexture.flags=0
	get_node("VBoxContainer/CentrePanel3/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TextureRect").texture=wangTilesetTexture
	Global.wangTileset.unlock()
	Global.current="wang"
	
func copy_tile(from:Array,to:Array,source:Image,destination:Image):
	source.lock()
	var half_size=Global.new_file_property.size/2
	var from_pixel_x=(from[0]-1)*half_size
	var from_pixel_y=(from[1]-1)*half_size
	
	var to_pixel_x=(to[0]-1)*half_size
	var to_pixel_y=(to[1]-1)*half_size
	for i in range(0,half_size):
		for j in range(0,half_size):
			var pixel=source.get_pixel(i+from_pixel_x,j+from_pixel_y)
			if pixel!=Color(0,0,0,0):
				destination.set_pixel(i+to_pixel_x,j+to_pixel_y,pixel)
	source.unlock()
	
func copy_trangle(from:Array,to:Array,source:Image,from_left:bool,is_upper:bool):
	source.lock()
	var half_size=Global.new_file_property.size/2
	var from_pixel_x=(from[0]-1)*half_size
	var from_pixel_y=(from[1]-1)*half_size
	
	var to_pixel_x=(to[0]-1)*half_size
	var to_pixel_y=(to[1]-1)*half_size
	
	if from_left and is_upper:
		for i in range(1,half_size):
			for j in range(1,i+1):
				var pixel=source.get_pixel(i+from_pixel_x,j+from_pixel_y-1)
				if pixel!=Color(0,0,0,0):
					Global.wangTileset.set_pixel(i+to_pixel_x,j+to_pixel_y-1,pixel)
		
	
	
	elif from_left and !is_upper:
		for i in range(0,half_size):
			for j in range(0,i+1):
				var pixel=source.get_pixel(j+from_pixel_x,i+from_pixel_y)
				if pixel!=Color(0,0,0,0):
					Global.wangTileset.set_pixel(j+to_pixel_x,i+to_pixel_y,pixel)
	
	
	elif !from_left and is_upper:
		for i in range(0,half_size+1):
			for j in range(0,i):
				var pixel=source.get_pixel(half_size-i+from_pixel_x,j+from_pixel_y)
				if pixel!=Color(0,0,0,0):
					Global.wangTileset.set_pixel(half_size-i+to_pixel_x,j+to_pixel_y,pixel)
		
	
	elif !from_left and !is_upper:
		for i in range(0,half_size):
			for j in range(1,i+1):
				var pixel=source.get_pixel(half_size-j+from_pixel_x,i+from_pixel_y)
				if pixel!=Color(0,0,0,0):
					Global.wangTileset.set_pixel(half_size-j+to_pixel_x,i+to_pixel_y,pixel)
		
	source.unlock()
		
func _on_Blob_pressed():
	if Global.wangTileset==null:
		set_text("ERROR: Create wang tileset first.")
		return
	var BlobSize_x=Global.new_file_property.size*12
	var BlobSize_y=Global.new_file_property.size*4
	Global.blobTileset=Image.new()
	Global.blobTileset.create(BlobSize_x,BlobSize_y,false,5)
	Global.blobTileset.lock()
	
	if Global.new_file_property.type!="Isomatric":
		#first row
		copy_tile([1,1],[01,1],Global.wangTileset,Global.blobTileset)
		copy_tile([6,1],[02,1],Global.wangTileset,Global.blobTileset)
		copy_tile([1,2],[01,2],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[02,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,1],[03,1],Global.wangTileset,Global.blobTileset)
		copy_tile([2,1],[04,1],Global.wangTileset,Global.blobTileset)
		copy_tile([1,2],[03,2],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[04,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,1],[05,1],Global.wangTileset,Global.blobTileset)
		copy_tile([4,1],[06,1],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[05,2],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[06,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([5,1],[07,1],Global.wangTileset,Global.blobTileset)
		copy_tile([6,1],[08,1],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[07,2],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[08,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([7,3],[09,1],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[10,1],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[09,2],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[10,2],Global.wangTileset,Global.blobTileset)

		copy_tile([3,1],[11,1],Global.wangTileset,Global.blobTileset)
		copy_tile([3,1],[12,1],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[11,2],Global.wangTileset,Global.blobTileset)
		copy_tile([10,1],[12,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,1],[13,1],Global.wangTileset,Global.blobTileset)
		copy_tile([3,1],[14,1],Global.wangTileset,Global.blobTileset)
		copy_tile([7,1],[13,2],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[14,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[15,1],Global.wangTileset,Global.blobTileset)
		copy_tile([10,3],[16,1],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[15,2],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[16,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,1],[17,1],Global.wangTileset,Global.blobTileset)
		copy_tile([2,1],[18,1],Global.wangTileset,Global.blobTileset)
		copy_tile([1,2],[17,2],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[18,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[19,1],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[20,1],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[19,2],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[20,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,1],[21,1],Global.wangTileset,Global.blobTileset)
		copy_tile([3,1],[22,1],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[21,2],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[22,2],Global.wangTileset,Global.blobTileset)
		
		copy_tile([5,1],[23,1],Global.wangTileset,Global.blobTileset)
		copy_tile([6,1],[24,1],Global.wangTileset,Global.blobTileset)
		copy_tile([5,2],[23,2],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[24,2],Global.wangTileset,Global.blobTileset)
		
		#second row
		copy_tile([1,3],[01,3],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[02,3],Global.wangTileset,Global.blobTileset)
		copy_tile([1,3],[01,4],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[02,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,3],[03,3],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[04,3],Global.wangTileset,Global.blobTileset)
		copy_tile([1,4],[03,4],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[04,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[05,3],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[06,3],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[05,4],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[06,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[07,3],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[08,3],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[07,4],Global.wangTileset,Global.blobTileset)
		copy_tile([6,4],[08,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,3],[09,3],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[10,3],Global.wangTileset,Global.blobTileset)
		copy_tile([1,3],[09,4],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[10,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[11,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[12,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[11,4],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[12,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([2,2],[13,3],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[14,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[13,4],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[14,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[15,3],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[16,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[15,4],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[16,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,3],[17,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[18,3],Global.wangTileset,Global.blobTileset)
		copy_tile([1,3],[17,4],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[18,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[19,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[20,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[19,4],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[20,4],Global.wangTileset,Global.blobTileset)
		
		copy_tile([2,2],[23,3],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[24,3],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[23,4],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[24,4],Global.wangTileset,Global.blobTileset)
		
		#3rd row
		copy_tile([1,3],[01,5],Global.wangTileset,Global.blobTileset)
		copy_tile([6,3],[02,5],Global.wangTileset,Global.blobTileset)
		copy_tile([1,6],[01,6],Global.wangTileset,Global.blobTileset)
		copy_tile([6,6],[02,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,5],[03,5],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[04,5],Global.wangTileset,Global.blobTileset)
		copy_tile([1,6],[03,6],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[04,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[05,5],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[06,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,6],[05,6],Global.wangTileset,Global.blobTileset)
		copy_tile([4,6],[06,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[07,5],Global.wangTileset,Global.blobTileset)
		copy_tile([6,5],[08,5],Global.wangTileset,Global.blobTileset)
		copy_tile([5,6],[07,6],Global.wangTileset,Global.blobTileset)
		copy_tile([6,6],[08,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,2],[09,5],Global.wangTileset,Global.blobTileset)
		copy_tile([2,2],[10,5],Global.wangTileset,Global.blobTileset)
		copy_tile([1,2],[09,6],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[10,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[11,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[12,5],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[11,6],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[12,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[13,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[14,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[13,6],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[14,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[15,5],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[16,5],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[15,6],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[16,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[17,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[18,5],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[17,6],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[18,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[19,5],Global.wangTileset,Global.blobTileset)
		copy_tile([4,3],[20,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,4],[19,6],Global.wangTileset,Global.blobTileset)
		copy_tile([4,4],[20,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[21,5],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[22,5],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[21,6],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[22,6],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[23,5],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[24,5],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[23,6],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[24,6],Global.wangTileset,Global.blobTileset)
		
		#4th row
		copy_tile([1,1],[01,7],Global.wangTileset,Global.blobTileset)
		copy_tile([6,1],[02,7],Global.wangTileset,Global.blobTileset)
		copy_tile([1,6],[01,8],Global.wangTileset,Global.blobTileset)
		copy_tile([6,6],[02,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,1],[03,7],Global.wangTileset,Global.blobTileset)
		copy_tile([2,1],[04,7],Global.wangTileset,Global.blobTileset)
		copy_tile([1,6],[03,8],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[04,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,1],[05,7],Global.wangTileset,Global.blobTileset)
		copy_tile([4,1],[06,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,6],[05,8],Global.wangTileset,Global.blobTileset)
		copy_tile([4,6],[06,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([5,1],[07,7],Global.wangTileset,Global.blobTileset)
		copy_tile([6,1],[08,7],Global.wangTileset,Global.blobTileset)
		copy_tile([5,6],[07,8],Global.wangTileset,Global.blobTileset)
		copy_tile([6,6],[08,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[09,7],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[10,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[09,8],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[10,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[11,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[12,7],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[11,8],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[12,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[13,7],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[14,7],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[13,8],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[14,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([9,3],[15,7],Global.wangTileset,Global.blobTileset)
		copy_tile([8,3],[16,7],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[15,8],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[16,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([1,2],[17,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[18,7],Global.wangTileset,Global.blobTileset)
		copy_tile([1,6],[17,8],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[18,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[19,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[20,7],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[19,8],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[20,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[21,7],Global.wangTileset,Global.blobTileset)
		copy_tile([3,3],[22,7],Global.wangTileset,Global.blobTileset)
		copy_tile([9,2],[21,8],Global.wangTileset,Global.blobTileset)
		copy_tile([8,2],[22,8],Global.wangTileset,Global.blobTileset)
		
		copy_tile([3,3],[23,7],Global.wangTileset,Global.blobTileset)
		copy_tile([6,2],[24,7],Global.wangTileset,Global.blobTileset)
		copy_tile([2,6],[23,8],Global.wangTileset,Global.blobTileset)
		copy_tile([6,6],[24,8],Global.wangTileset,Global.blobTileset)
		
		blobTilesetTexture.create_from_image(Global.blobTileset)
		blobTilesetTexture.flags=0
		get_node("VBoxContainer/CentrePanel3/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TextureRect").texture=blobTilesetTexture
		Global.current="blob"

func _on_Export_pressed():
	if Global.wangTileset==null and Global.blobTileset==null:
		set_text("ERROR: No tileset avaiable.")
		return
	get_node("WindowDialog").popup_centered()

func _on_Edit_pressed():
	if current_pressed==-1:
		set_text("ERROR: Select a tile first.")
		return
	get_node("WindowDialog2").popup()

func _on_LoadFolder_pressed():
	get_node("FileDialog4").popup()
	set_text("")
	set_text("HINT: Select any number of one texture.")
	set_text("NOTE: Make sure each file name has only one digit number from 1-13.")
	set_text("NOTE: All texture must be in same folder.")
	set_text("NOTE: All texture must have same name followed by different numbers.")
func _on_FileDialog4_files_selected(paths):
	var data
	set_text("")
	if paths.size()>13:
		set_text("ERROR: You can not select more than 13 files.")
		return
	for i in range(0,paths.size()):
		data=paths[i].split("/")[-1]
		print(data)
		match int(data):
			1:
				current_pressed=0
				_on_FileDialog_file_selected(paths[i])
			2:
				current_pressed=1
				_on_FileDialog_file_selected(paths[i])
			3:
				current_pressed=2
				_on_FileDialog_file_selected(paths[i])
			4:
				current_pressed=3
				_on_FileDialog_file_selected(paths[i])
			5:
				current_pressed=4
				_on_FileDialog_file_selected(paths[i])
			6:
				current_pressed=5
				_on_FileDialog_file_selected(paths[i])
			7:
				current_pressed=6
				_on_FileDialog_file_selected(paths[i])
			8:
				current_pressed=7
				_on_FileDialog_file_selected(paths[i])
			9:
				current_pressed=8
				_on_FileDialog_file_selected(paths[i])
			10:
				current_pressed=9
				_on_FileDialog_file_selected(paths[i])
			11:
				current_pressed=10
				_on_FileDialog_file_selected(paths[i])
			12:
				current_pressed=11
				_on_FileDialog_file_selected(paths[i])
			13:
				current_pressed=12
				_on_FileDialog_file_selected(paths[i])
			_:
				set_text("ERROR: Can not load the file. File name: "+data)
				set_text("    File has "+str(int(data))+" as number." )
				set_text("    make sure file name has number between 1 and 13.")
				set_text("")
	
