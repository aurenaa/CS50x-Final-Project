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
	queue_text("Mr Whiskers! I was looking for you.")
	queue_text("In mums bed huh, I won't tell her don't worry.")

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

