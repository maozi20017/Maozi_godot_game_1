extends Node

# 定義類別名稱
class_name GameManager

# 輸出變數，可在編輯器中設定
@export var begin_dialogue: DialogueResource
@export var transitioner: Transitioner

# 定義一個信號，用於暫停/恢復遊戲
signal toggle_game_paused(is_paused: bool)

# 當前級別
var current_level = 1

# 遊戲是否暫停
var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)
		 
func _ready() -> void:
	# 在場景準備好後顯示對話框
	DialogueManager.show_dialogue_balloon(begin_dialogue)
	# 連接全域信號
	Global.connect("next_level_signal", set_next_level)
	
func _input(event: InputEvent) -> void:
	# 當按下取消鍵時切換遊戲暫停狀態
	if event.is_action_pressed("ui_cancel"):
		game_paused = !game_paused
	
func set_next_level():
	# 播放過場動畫
	var animation_player = transitioner.get_node("AnimationPlayer")
	animation_player.play("Fade_Out")
	await animation_player.animation_finished
	
	# 釋放上一個場景
	var node_name = "Level" + str(current_level)
	var node = get_node(node_name)
	node.queue_free()
	
	# 加載並實例化下一個場景
	current_level += 1
	var scene_path = "res://scenes/levels/level" + str(current_level) + "/level_" + str(current_level) + ".tscn"
	var scene_resource = load(scene_path)

	if scene_resource != null:
		var new_scene = scene_resource.instantiate()
		add_child(new_scene)
	else:
		# 如果場景檔案不存在，等待一段時間後退出遊戲
		await get_tree().create_timer(1.0).timeout
		get_tree().quit()
	
	# 播放過場動畫
	animation_player.play("Fade_In")
