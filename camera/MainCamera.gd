extends Camera2D

# 定義震動的強度
@export var randomStrength:float=10.0
# 定義震動淡出的速度
@export var shakeFade:float=100.0

# 產生隨機數用的物件
var rng=RandomNumberGenerator.new()

# 震動的強度
var shake_strength:float=0.0

# 設定震動的強度為 randomStrength
func apply_shake():
	shake_strength=randomStrength

# 產生一個隨機的位移向量
func randomOffset()->Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _ready() -> void:
	Global.connect("died",apply_shake)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 如果還有震動的強度
	if shake_strength>0:
		# 逐漸減少震動的強度，使震動漸漸停止
		shake_strength=lerpf(shake_strength,0,shakeFade*delta)
		# 計算新的位移向量
		offset=randomOffset()
