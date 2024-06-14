extends Area2D
#signals are sent when collision is detected
signal pickup ##when we pick coin
signal hurt

@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity*speed*delta
	#add limit
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	#if running use the run animation
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	# if running to the left: flip sprite
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

#area here means the collision box
func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup() #the method defined in coin
		pickup.emit("coin") #send pickup signal
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()

func start():
	#calls the _process() function
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"

func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)
