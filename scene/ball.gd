extends RigidBody2D
var impulse_power = 100

onready var wall = preload("res://scene/wall.tscn")
onready var particles = preload("res://scene/deathparticles.tscn")
onready var text = preload("res://scene/reload_text.tscn")
var score = false
var score_2 = 0


func _integrate_forces(state):
	for i in state.get_contact_count():
		score = true
		var collision_normal = state.get_contact_local_normal(i)
		apply_central_impulse(collision_normal * impulse_power)
		
func reset_wall():
	var wall_instance = wall.instance()
	wall_instance.position = Vector2(0, global_position.y)
	get_parent().call_deferred('add_child', wall_instance)

func _on_Area2D_body_entered(body):
	if body.name == 'walls':
		body.queue_free()
		reset_wall()

func _on_Area2D2_body_entered(body):
	if body.name == 'walls':
		self.queue_free()
		var death = particles.instance()
		death.position = global_position
		get_tree().current_scene.add_child(death)
		var reload = text.instance()
		get_tree().current_scene.add_child(reload)
		get_parent().get_node("AudioStreamPlayer").playing = false
		
		



func _physics_process(delta):
	global_rotation = 0
	if score:
		score_2 += 0.1
		get_parent().get_node("ball/Label").text = str(score_2)
