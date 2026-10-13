extends Node

signal EXPChange
signal HPChange

var HP=20
var EXP=100
var AliveMonster = 0
# 本关规定的怪物总数
var TotalMonster = 0

# 已经孵化的怪物数量
var SpawnedMonster = 0

# 是否已经完成本关全部怪物的孵化
var SpawnFinished = false

# 防止重复触发胜利判定
var VictoryChecking = false

func AlterHP(value):
	HP+=value
	if HP<=0:
		SceneScheduling.sceneswich("res://游戏界面/游戏结束.tscn")
	HPChange.emit(HP)
	
func AlterEXP(value):
	EXP+=value
	EXPChange.emit(EXP)
	
func _ready():
	HPChange.emit(HP)
	EXPChange.emit(EXP)

func ResetGame():
	HP=20
	EXP=100
	SceneScheduling.sceneswich("res://游戏界面/开始界面.tscn")

func ResetStats():
	HP=20
	EXP=100
	AliveMonster = 0
	TotalMonster = 0
	SpawnedMonster = 0
	SpawnFinished = false
	VictoryChecking = false
	HPChange.emit(HP)
	EXPChange.emit(EXP)
	# 开始新的一关时调用
func StartLevel(total: int):
	HP = 20
	EXP = 100
	TotalMonster = total
	SpawnedMonster = 0
	AliveMonster = 0
	SpawnFinished = false
	VictoryChecking = false
	HPChange.emit(HP)
	EXPChange.emit(EXP)


# 每成功孵化一只怪物时调用
func MonsterSpawned():
	SpawnedMonster += 1
	AliveMonster += 1


# 所有规定的怪物都已经孵化完时调用
func FinishSpawning():
	SpawnFinished = true
	CheckVictory()


# 每当一只怪物离开场景时调用
func MonsterRemoved():
	AliveMonster = max(0, AliveMonster - 1)
	CheckVictory()


# 检查是否胜利
func CheckVictory():
	if HP <= 0:
		return

	if not SpawnFinished:
		return

	if SpawnedMonster < TotalMonster:
		return

	if AliveMonster > 0:
		return

	if VictoryChecking:
		return

	VictoryChecking = true
	WaitForVictory()


# 等待一秒后切换胜利页面
func WaitForVictory() -> void:
	await get_tree().create_timer(1.0).timeout

	# 等待期间如果据点被摧毁，就不再进入胜利页面
	if HP > 0 and SpawnFinished and SpawnedMonster >= TotalMonster and AliveMonster == 0:
		SceneScheduling.sceneswich("res://游戏界面/胜利界面.tscn")
	else:
		VictoryChecking = false
	
