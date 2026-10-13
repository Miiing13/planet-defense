extends Control


func _on_重玩_pressed() -> void:
	GodOfGame.ResetStats()
	SceneScheduling.sceneswich("res://游戏关卡/Level1.tscn")


func _on_回到选关_pressed() -> void:
	SceneScheduling.sceneswich("res://游戏界面/关卡选择.tscn")
