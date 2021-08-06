extends WindowDialog
var export_details={}

onready var image=get_node("MarginContainer/HSplitContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Image")
onready var godot=get_node("MarginContainer/HSplitContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Godot")
onready var notification=get_node("MarginContainer/HSplitContainer/MarginContainer3/PanelContainer3/MarginContainer/VBoxContainer/Label")
onready var nameField=get_node("MarginContainer/HSplitContainer/MarginContainer3/PanelContainer3/MarginContainer/VBoxContainer/SaveArea/VBoxContainer/LineEdit")
func _ready():
	pass
	
func unpressed_all():
	image.pressed=false
	godot.pressed=false

func _on_Godot_pressed():
	unpressed_all()
	godot.pressed=true
	export_details.type="Godot"

func _on_Image_pressed():
	unpressed_all()

	image.pressed=true
	export_details.type="Image"

func _on_FileDialog_dir_selected(dir):
	export_details.dir=dir
	get_node("MarginContainer/HSplitContainer/MarginContainer3/PanelContainer3/MarginContainer/VBoxContainer/SaveArea/VBoxContainer2/Label2").text=dir

func set_error(message:String):
	notification.text=message
	yield(get_tree().create_timer(2),"timeout")
	notification.text=""

func _on_Path_pressed():
	get_node("../FileDialog2").popup()

func _on_Save_pressed():
	export_details.name=nameField.text
	if export_details.name=="":
		nameField.placeholder_text="NAME FIELD EMPTY"
		get_parent().set_text("ERROR: Please give your file a name.")
		set_error("ERROR: Please give your file a name.")
		return
	if !export_details.has("dir"):
		get_node("MarginContainer/HSplitContainer/MarginContainer3/PanelContainer3/MarginContainer/VBoxContainer/SaveArea/VBoxContainer2/Label2").text="SELECT DIRECTORY TO SAVE"
		get_parent().set_text("ERROR: Please select directory for files to be saved.")
		set_error("ERROR: Please select directory for files to be saved.")
		return
	if !export_details.has("type"):
		get_parent().set_text("ERROR: Please select export type from left side")
		set_error("ERROR: Please select export type from left side")
		return
	elif export_details.type=="Godot":
		var path=export_details.dir+"/"+"TG_"+export_details.name
		var dir = Directory.new()
		if dir.open(path)==OK:
			get_parent().set_text("ERROR: Allready present. Please select different directory or different file name.")
			set_error("ERROR: Allready present. Please select different directory or different file name.")
			return
		dir.make_dir(path)
		export_png(path)
		
		
		var import_data="""[remap]

importer="texture"
type="StreamTexture"
path="res://.import/TG_"""+export_details.name+""".png-.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://TG_"""+export_details.name+"""/TG_"""+export_details.name+""".png"
dest_files=[ "res://.import/TG_"""+export_details.name+""".png-.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0"""
		var import = File.new()
		import.open(path+"/"+"TG_"+export_details.name+".png.import",import.WRITE)
		import.store_string(import_data)
		import.close()
		
		
		if Global.current=="blob":
			var blobdata:String=("""[gd_resource type="TileSet" load_steps=50 format=2]

[ext_resource path="res://TG_"""+export_details.name+"""/TG_"""+export_details.name+""".png" type="Texture" id=1]

""")
			for i in range(1,49):
				blobdata=blobdata+"""[sub_resource type="ConvexPolygonShape2D" id="""+str(i)+"""]
points = PoolVector2Array( 0, 0, """+str(Global.new_file_property.size)+""", 0, """+str(Global.new_file_property.size)+""", """+str(Global.new_file_property.size)+""", 0, """+str(Global.new_file_property.size)+""" )

"""
			blobdata=blobdata+"""[resource]
0/name = "TG_"""+export_details.name+""".png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, """+str(Global.new_file_property.size*12)+""", """+str(Global.new_file_property.size*4)+""" )
0/tile_mode = 1
0/autotile/bitmask_mode = 1
0/autotile/bitmask_flags = [ Vector2( 0, 0 ), 144, Vector2( 0, 1 ), 146, Vector2( 0, 2 ), 18, Vector2( 0, 3 ), 16, Vector2( 1, 0 ), 176, Vector2( 1, 1 ), 178, Vector2( 1, 2 ), 50, Vector2( 1, 3 ), 48, Vector2( 2, 0 ), 184, Vector2( 2, 1 ), 186, Vector2( 2, 2 ), 58, Vector2( 2, 3 ), 56, Vector2( 3, 0 ), 152, Vector2( 3, 1 ), 154, Vector2( 3, 2 ), 26, Vector2( 3, 3 ), 24, Vector2( 4, 0 ), 187, Vector2( 4, 1 ), 434, Vector2( 4, 2 ), 182, Vector2( 4, 3 ), 250, Vector2( 5, 0 ), 440, Vector2( 5, 1 ), 510, Vector2( 5, 2 ), 447, Vector2( 5, 3 ), 62, Vector2( 6, 0 ), 248, Vector2( 6, 1 ), 507, Vector2( 6, 2 ), 255, Vector2( 6, 3 ), 59, Vector2( 7, 0 ), 190, Vector2( 7, 1 ), 218, Vector2( 7, 2 ), 155, Vector2( 7, 3 ), 442, Vector2( 8, 0 ), 432, Vector2( 8, 1 ), 438, Vector2( 8, 2 ), 446, Vector2( 8, 3 ), 54, Vector2( 9, 0 ), 506, Vector2( 9, 1 ), 254, Vector2( 9, 2 ), 511, Vector2( 9, 3 ), 63, Vector2( 10, 0 ), 504, Vector2( 10, 2 ), 443, Vector2( 10, 3 ), 191, Vector2( 11, 0 ), 216, Vector2( 11, 1 ), 251, Vector2( 11, 2 ), 219, Vector2( 11, 3 ), 27 ]
0/autotile/icon_coordinate = Vector2( 0, 3 )
0/autotile/tile_size = Vector2( """+str(Global.new_file_property.size)+""", """+str(Global.new_file_property.size)+""" )
0/autotile/spacing = 0
0/autotile/occluder_map = [  ]
0/autotile/navpoly_map = [  ]
0/autotile/priority_map = [  ]
0/autotile/z_index_map = [  ]
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape = SubResource( 1 )
0/shape_one_way = false
0/shape_one_way_margin = 1.0
0/shapes = [ {
"autotile_coord": Vector2( 0, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 1 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 2 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 3 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 4 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 5 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 5, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 6 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 6, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 7 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 7, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 8 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 8, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 9 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 9, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 10 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 10, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 11 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 11, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 12 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 11, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 13 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 9, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 14 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 8, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 15 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 7, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 16 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 6, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 17 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 5, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 18 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 11, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 19 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 10, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 20 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 10, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 21 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 11, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 22 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 9, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 23 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 9, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 24 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 8, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 25 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 8, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 26 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 7, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 27 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 7, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 28 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 6, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 29 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 6, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 30 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 5, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 31 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 5, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 32 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 33 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 34 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 35 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 36 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 37 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 38 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 0, 3 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 39 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 0, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 40 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 0, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 41 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 42 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 43 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 44 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 45 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 46 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 47 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 48 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
} ]
0/z_index = 0"""
			var resourcedata = File.new()
			resourcedata.open(path+"/"+"TG_"+export_details.name+".tres",resourcedata.WRITE)
			resourcedata.store_string(blobdata)
			resourcedata.close()
			get_parent().set_text("NOTE: Files saved in "+export_details.dir +".")
			set_error("Files saved in "+export_details.dir +".")
		
		
		else:
				var wangdata:String=("""[gd_resource type="TileSet" load_steps=50 format=2]
[ext_resource path="res://TG_"""+export_details.name+"""/TG_"""+export_details.name+""".png" type="Texture" id=1]

""")
				for i in range(1,16):
						wangdata=wangdata+"""[sub_resource type="ConvexPolygonShape2D" id="""+str(i)+"""]
points = PoolVector2Array( 0, 0, """+str(Global.new_file_property.size)+""", 0, """+str(Global.new_file_property.size)+""", """+str(Global.new_file_property.size)+""", 0, """+str(Global.new_file_property.size)+""" )

"""
				wangdata=wangdata+"""[resource]
0/name = "TG_"""+export_details.name+""".png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, """+str(Global.new_file_property.size*5)+""", """+str(Global.new_file_property.size*3)+""" )
0/tile_mode = 1
0/autotile/bitmask_mode = 1
0/autotile/bitmask_flags = [ Vector2( 0, 0 ), 432, Vector2( 0, 1 ), 438, Vector2( 0, 2 ), 54, Vector2( 1, 0 ), 504, Vector2( 1, 1 ), 511, Vector2( 1, 2 ), 63, Vector2( 2, 0 ), 216, Vector2( 2, 1 ), 219, Vector2( 2, 2 ), 27, Vector2( 3, 0 ), 255, Vector2( 3, 1 ), 507, Vector2( 3, 2 ), 443, Vector2( 4, 0 ), 447, Vector2( 4, 1 ), 510, Vector2( 4, 2 ), 254 ]
0/autotile/icon_coordinate = Vector2( 1, 1 )
0/autotile/tile_size = Vector2( """+str(Global.new_file_property.size)+""", """+str(Global.new_file_property.size)+""" )
0/autotile/spacing = 0
0/autotile/occluder_map = [  ]
0/autotile/navpoly_map = [  ]
0/autotile/priority_map = [  ]
0/autotile/z_index_map = [  ]
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape = SubResource( 1 )
0/shape_one_way = false
0/shape_one_way_margin = 1.0
0/shapes = [ {
"autotile_coord": Vector2( 0, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 1 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 2 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 3 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 4 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 5 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 0, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 6 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 7 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 8 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 9 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 1 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 10 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 0, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 11 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 1, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 12 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 2, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 13 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 3, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 14 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
}, {
"autotile_coord": Vector2( 4, 2 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 15 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
} ]
0/z_index = 0"""
				var resourcedata = File.new()
				resourcedata.open(path+"/"+"TG_"+export_details.name+".tres",resourcedata.WRITE)
				resourcedata.store_string(wangdata)
				resourcedata.close()
				get_parent().set_text("NOTE: Files saved in "+export_details.dir +".")
				set_error("Files saved in "+export_details.dir +".")
		
	elif export_details.type=="Image":
		export_png(export_details.dir)
		get_parent().set_text("NOTE: Image saved in "+export_details.dir +" as "+export_details.name+".")
		set_error("Image saved in "+export_details.dir +" as "+export_details.name+".")
	self.hide()
	nameField.text=""


func export_png(path):
	if Global.current=="blob":
		Global.blobTileset.save_png(path+"/"+"TG_"+export_details.name+".png")
	else:
		Global.wangTileset.save_png(path+"/"+"TG_"+export_details.name+".png")
