extends Node

func CreateBullet(BulletCreateCoord,BulletTarget,BulletType):
	var BulletTypeInstance=BulletType.instance()
	SceneScheduling.CurrentLevel.add_child(BulletTypeInstance)
	BulletTypeInstance.position=BulletCreateCoord
	var BulletDirection=BulletTarget-BulletCreateCoord
	BulletTypeInstance.rotate(Vector2(0,1).angle_to(BulletDirection))
	


