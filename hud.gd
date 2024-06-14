extends CanvasLayer
signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()
	
	
func update_score(value):
	$MarginContainer/Score.text = str(value)

func update_timer(value):
	$MarginContainer/Time.text = str(value)
	
func update_level(value):
	$MarginContainer/Level.text = "Level " + str(value)

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()

func show_game_over():
	#shows game over message for 2 seconds
	show_message("Game Over")
	await $Timer.timeout
	$StartButton.show()
	$Message.text = "Coin Dash!"
	$Message.show()

	
