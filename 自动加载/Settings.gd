extends Node

const SAVE_PATH := "user://settings.cfg"

var config := ConfigFile.new()

var music_volume := 1.0
var sfx_volume := 1.0


func _ready():
	_ensure_bus("Music")
	_ensure_bus("SFX")
	_load()
	_apply_volumes()
	_apply_fullscreen()


# 如果总线不存在就创建，并返回其索引
func _ensure_bus(bus_name: String) -> int:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		AudioServer.add_bus()
		idx = AudioServer.bus_count - 1
		AudioServer.set_bus_name(idx, bus_name)
		AudioServer.set_bus_send(idx, "Master")
	return idx


func get_music_volume() -> float:
	return music_volume


func get_sfx_volume() -> float:
	return sfx_volume


func set_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	_apply_volumes()
	_save()


func set_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)
	_apply_volumes()
	_save()


func _apply_volumes() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_volume))


func is_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN


func toggle_fullscreen() -> void:
	if is_fullscreen():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	_save()


func _apply_fullscreen() -> void:
	if config.get_value("display", "fullscreen", false):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _load() -> void:
	if config.load(SAVE_PATH) != OK:
		return
	music_volume = config.get_value("audio", "music_volume", 1.0)
	sfx_volume = config.get_value("audio", "sfx_volume", 1.0)


func _save() -> void:
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("display", "fullscreen", is_fullscreen())
	config.save(SAVE_PATH)
