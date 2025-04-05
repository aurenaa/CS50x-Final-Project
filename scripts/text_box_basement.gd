extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var timer = $Timer
@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state: State = State.READY
var text_queue: Array = []

func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("Just as Emily turns to head towards the electrical panel, she sees Nikola,")
	queue_text("her mischievous brother, standing in the corner.")
	queue_text("E: Nikola, was that you? Did you cut the power to scare us?")
	queue_text("N: Yep. Guilty as charged.")
	queue_text("E: What about the music, the radio how did you make it play?")
	queue_text("N: What are you talking about? I haven't touched any music.")
	queue_text("E: So...it wasn't you?")
	queue_text("Emily's complexion drains of color as she suddenly realizes that something is seriously amiss.")
	queue_text("N: Emily, what's going on?")
	queue_text("E: Something isn't right we should leave right now.")
	
func _process(delta: float):
	match current_state:
		State.READY:
			if text_queue.size() > 0:
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.modulate.a = 1.0
				end_symbol.text = "v"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
			if text_queue.size() == 0:
				if Input.is_action_just_pressed("ui_accept"):
					get_tree().change_scene_to_file("res://menues/credits.tscn")
				
func queue_text(next_text: String):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func unhide_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	var next_text: String = text_queue.pop_front()
	label.text = next_text
	label.modulate.a = 0.0
	change_state(State.READING)
	unhide_textbox()
	var animation_length: float = next_text.length() * CHAR_READ_RATE
	var delay_timer: Timer = Timer.new()
	delay_timer.wait_time = animation_length
	add_child(delay_timer)
	delay_timer.start()
	delay_timer.connect("timeout", Callable(self, "_on_delay_timer_timeout"))

func _on_delay_timer_timeout():
	label.modulate.a = 1.0
	end_symbol.text = "v"
	change_state(State.FINISHED)
	var timer_node = get_node_or_null("timer")
	if timer_node:
		timer_node.queue_free()

func change_state(next_state: State):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
