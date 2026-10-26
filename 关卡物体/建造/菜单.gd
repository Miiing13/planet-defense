extends Control

var selected_tower: Node2D

@onready var upgrade_sprite: AnimatedSprite2D = $UpgradeButton/AnimatedSprite2D
@onready var delete_sprite: AnimatedSprite2D = $DeleteButton/AnimatedSprite2D2



func _ready():
	visible = false
	
	
	$UpgradeButton.z_index = 1
	$DeleteButton.z_index = 1
	$MenuPanel.z_index = 0

func show_menu(tower: Node2D,center_position:Vector2):
	if selected_tower == tower and visible:
		visible = false
		selected_tower = null
		return
	selected_tower = tower
	position = center_position - size/2
	visible = true
	
	upgrade_sprite.stop()
	delete_sprite.stop()

	upgrade_sprite.frame = 0
	delete_sprite.frame = 0

	upgrade_sprite.play("Upgrade")
	delete_sprite.play("Delete")

func _on_delete_button_pressed():
	if selected_tower != null and is_instance_valid(selected_tower):
		var builder = selected_tower.get_parent()

		builder.BuildableOrNot = true
		builder.get_node("NinePatchRect").visible = true
		builder.get_node("选单").visible = false

		selected_tower.queue_free()

	selected_tower = null
	visible = false
	
