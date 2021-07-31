extends Node2D

class_name Tower

enum TOWER_TYPE {
	MACHINE_GUN,
	MISSILE_LAUNCHER
}

enum UPGRADE_TYPE {
	BULLET_DAMAGE,
	RELOAD_SPEED,
	RADIUS
}

enum TARGETING_MODES {
	CLOSEST,
	FIRST,
	LAST,
	STRONGEST,
	WEAKEST
}

enum STATE {
	IDLE,
	ACTIVE,
	DEAD
}

signal selected
signal deselected

#export(Resource) onready var settingsData 
var settingsData
export(String) var settingsDataPath
export(String) var upgradeInfoPath
export(PackedScene) onready var ammoScene
export(Resource) onready var damageResource
export(TARGETING_MODES) var targetingMode setget setTargetingMode
export var rotationSpeed: float
export var fireRate: float setget setFireRate
export var shootingAngle: float
export var recoil: float = 40
export var recoilRecover: float = 5
export var radius: float setget setRadius

onready var searchArea = get_node("SearchArea")
onready var shootTimer = get_node("ShootTimer")
onready var idleTimer = get_node("IdleTimer")
onready var base = get_node("Base")
onready var gun = get_node("Gun")
onready var animationPlayer = get_node("AnimationPlayer")

var state setget setState
var canShoot = true
var target = null setget setTarget
var targetRotationVector = Vector2.ZERO
var lookVector = Vector2.ZERO
var currentRecoil = 0
var canPickRandomRotation = true
var idleWait = [2,4]

var selected = false setget setSelected
var justEntered = true
var justLeft = false

func setFireRate(value):
	fireRate = value
	
	if not shootTimer:
		return
	shootTimer.wait_time = value

func setRadius(value):
	radius = value

	if not searchArea:
		return
	searchArea.setRadius(radius)

func setSelected(value):
	selected = value

func setState(value):
	state = value

func setTarget(value):
	target = value
	
	if target == null:
		return
	self.state = STATE.ACTIVE

func setTargetingMode(value):
	targetingMode = value

func _ready():
	#settingsData = settingsData.duplicate(true)
	settingsData = load(settingsDataPath).duplicate()
	settingsData.upgradeInfo = load(upgradeInfoPath).duplicate()
		
	base.use_parent_material = false
	gun.use_parent_material = false
	
	self.state = STATE.IDLE
	
	shootTimer.connect("timeout", self, "shootTimerTimeout")
	idleTimer.connect("timeout", self, "idleTimerTimeout")
	
	shootTimer.wait_time = fireRate
	
	gun.rotation = rand_range(0, 2*PI)
	
	self.radius = radius

func handleEvents(event):
	if state == STATE.DEAD:
		return
	if event is InputEventMouseMotion:
		if mouseOverBase():
			useOutline()
			justEntered = false
			justLeft = true
		elif !selected:
			useOutline(false)
			justEntered = true
			justLeft = false

	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if mouseOverBase():
				if !event.pressed:
					select()
				else:
					animationPlayer.play("select")
			else:
				if !event.pressed:
					justLeft = true
					deselect()

func select():
	if selected:
		return
	self.selected = true
	useOutline()
	animationPlayer.play("select")
	emit_signal("selected", self)

func deselect():
	if !selected:
		return
	self.selected = false
	useOutline(false)
	emit_signal("deselected", self)

func mouseOverBase():
	var mouse_over_rect = Rect2(Vector2() - base.texture.get_size() / 2, base.texture.get_size())
	if mouse_over_rect.has_point(base.get_local_mouse_position()):
		return true
	return false

func _process(delta):
	match state:
		STATE.IDLE:
			searchTarget()
			if target:
				self.state = STATE.ACTIVE
				return
			if canPickRandomRotation:
				setRandomTargetVector()
			lookAtTarget(delta)
			applyRecoil(delta)
			
		STATE.ACTIVE:
			if target == null:
				searchTarget()
			if target != null:
				setTargetVector()
				#if canShoot:
				lookAtTarget(delta)
				attemptAttack()
			else:
				self.state = STATE.IDLE
			applyRecoil(delta)
	
func searchTarget():
	searchArea.search()
	
func setRandomTargetVector():
	canPickRandomRotation = false
	
	targetRotationVector = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
	idleTimer.start(rand_range(idleWait[0], idleWait[1]))
	
func idleTimerTimeout():
	canPickRandomRotation = true
	
func applyRecoil(delta):
	if currentRecoil == 0:
		gun.position = Vector2()
	else:
		gun.position = -1 * lookVector * currentRecoil
		currentRecoil = lerp(currentRecoil, 0, recoilRecover * delta)
		
		if currentRecoil < .01:
			currentRecoil = 0

func setTargetVector():
	targetRotationVector = (target.global_position - global_position).normalized()

func lookAtTarget(delta):
	if lookVector != targetRotationVector:
		var targetRotation = atan2(targetRotationVector.y, targetRotationVector.x)
		
		gun.rotation = lerp_angle(gun.rotation, targetRotation, deg2rad(rotationSpeed * delta))
		
		lookVector = Vector2(cos(gun.rotation), sin(gun.rotation)).normalized()
		
func attemptAttack():
	if canShoot and lookVector.dot(targetRotationVector) >= shootingAngle:
		shoot()
		searchTarget()

func shoot():
	pass
	
func setRecoil():
	currentRecoil = recoil

func shootTimerTimeout():
	canShoot = true

func useOutline(use: bool = true):
#	base.use_parent_material = use
#	gun.use_parent_material = use
	if use and justEntered:
		animationPlayer.play("show")
	elif !use and justLeft:
		animationPlayer.play("hide")

func destroy():
	emit_signal("deselected", self)
	self.state = STATE.DEAD
	animationPlayer.play("dead")

func increaseSellPrice(ammount):
	settingsData.sellPrice += ammount

func upgrade(type, increase):
	match type:
		UPGRADE_TYPE.BULLET_DAMAGE:
			damageResource.damage += increase
		UPGRADE_TYPE.RADIUS:
			self.radius += increase
		UPGRADE_TYPE.RELOAD_SPEED:
			self.fireRate += increase
