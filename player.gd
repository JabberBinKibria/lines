extends StaticBody2D
var last_point = Vector2(180,900)
var mouse = get_global_mouse_position()
onready var line = $Line2D
var black = Color(255, 255, 255)
onready var coll = $CollisionShape2D
var length = 50
var baal = preload("res://scene/baal.tscn")

func _draw():
	draw_line(last_point, get_global_mouse_position(), black, 1)
	


func _physics_process(delta):
	update()
	if Input.is_action_just_pressed("LMB"):
		$AudioStreamPlayer.play()
		var new_point = get_global_mouse_position()
		var b = baal.instance()
		b.position = new_point
		owner.add_child(b)
		
		#adding new line and collision
		line.add_point(new_point)
		var new_coll = coll.duplicate()
		var new_shape = coll.shape.duplicate()
		new_coll.shape = new_shape
		new_coll.shape.a = last_point
		new_coll.shape.b = new_point
		add_child(new_coll)
		last_point = new_point
		
		
		#to remove shapes
		var points = line.get_point_count()
		if points > length:
			line.remove_point(0)
