extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.align = 2
	$MessageLabel.show()

func show_start_button(text):
	$StartButton.text = text
	$StartButton.show()

func show_game_over(winner):
	show_message('Game over! ' + winner + ' has won!')
	show_start_button('Restart')
	
func update_health(player, health):
	if player == 1:
		$P1HealthLabel.text = str(health)
	else:
		$P2HealthLabel.text = str(health)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")