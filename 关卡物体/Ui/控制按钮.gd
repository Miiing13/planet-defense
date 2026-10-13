extends Control

@onready var 暂停按钮: Button = $"按钮栏/暂停"
@onready var 继续按钮: Button = $"按钮栏/继续"


func _ready() -> void:
	暂停按钮.show()
	继续按钮.hide()


func _on_pause_pressed() -> void:
	get_tree().paused = true
	暂停按钮.hide()
	继续按钮.show()


func _on_继续_pressed() -> void:
	get_tree().paused = false
	继续按钮.hide()
	暂停按钮.show()


func _on_back_pressed() -> void:
	get_tree().paused = false
	SceneScheduling.sceneswich("res://游戏界面/开始界面.tscn")


func _on_continue_pressed() -> void:
	pass # Replace with function body.
