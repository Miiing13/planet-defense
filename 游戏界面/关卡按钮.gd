extends Control

var level
func changename(name):
	level=name
	$"名称".text=name


func _on_NinePatchRect_gui_input(event):
	if Input.is_action_just_pressed("左键"):
		SceneScheduling.sceneswich("res://游戏关卡/"+level+".tscn")
