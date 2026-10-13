extends Control

@onready var 音乐滑条: HSlider = $"音乐音量滑条"
@onready var 音效滑条: HSlider = $"音效音量滑条"
@onready var 全屏按钮: Button = $"全屏按钮"


func _ready():
	音乐滑条.value = Settings.get_music_volume() * 100.0
	音效滑条.value = Settings.get_sfx_volume() * 100.0
	refresh_fullscreen_button()


func _on_music_slider_value_changed(value: float) -> void:
	Settings.set_music_volume(value / 100.0)


func _on_sfx_slider_value_changed(value: float) -> void:
	Settings.set_sfx_volume(value / 100.0)


func _on_fullscreen_pressed() -> void:
	Settings.toggle_fullscreen()
	refresh_fullscreen_button()


func refresh_fullscreen_button() -> void:
	全屏按钮.text = "退出全屏" if Settings.is_fullscreen() else "全屏"


func _on_back_pressed() -> void:
	SceneScheduling.sceneswich("res://游戏界面/开始界面.tscn")
