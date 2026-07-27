extends Control

signal closed

@onready var portrait: TextureRect = %Portrait
@onready var name_label: Label = %NameLabel
@onready var reply_label: RichTextLabel = %ReplyLabel
@onready var input: LineEdit = %QuestionInput
@onready var ask_button: Button = %AskButton
@onready var status_label: Label = %StatusLabel
@onready var bridge: BridgeClient = %BridgeClient

var speaker_id := "bell"
var speaker_name := "Ignatius Bell"
var portrait_tex: Texture2D
var history: Array = []
var _busy := false

func _ready() -> void:
	visible = false
	ask_button.pressed.connect(_on_ask_pressed)
	input.text_submitted.connect(_on_text_submitted)
	bridge.chat_finished.connect(_on_chat_finished)

func open(npc_id: String, display_name: String, tex: Texture2D, intro: String = "") -> void:
	speaker_id = npc_id
	speaker_name = display_name
	portrait_tex = tex
	portrait.texture = tex
	name_label.text = display_name
	var lead := intro if not intro.is_empty() else "They regard you in the summer stillness of Richmond House."
	reply_label.text = "[i]%s[/i]\n\nAsk anything — the house, the experiment, the people (as understood in 1856)." % lead
	input.placeholder_text = "Ask %s anything (1856 knowledge only)…" % display_name
	input.text = ""
	status_label.text = ""
	history.clear()
	visible = true
	input.grab_focus()

func close_panel() -> void:
	visible = false
	closed.emit()

func _on_ask_pressed() -> void:
	_submit(input.text)

func _on_text_submitted(text: String) -> void:
	_submit(text)

func _submit(text: String) -> void:
	var q := text.strip_edges()
	if q.is_empty() or _busy:
		return
	_busy = true
	ask_button.disabled = true
	status_label.text = "%s is considering… (Engram + Ollama)" % speaker_name
	reply_label.text = "[i]You:[/i] %s\n\n[i]…[/i]" % q
	bridge.send_chat(speaker_id, q, history)

func _on_chat_finished(reply: String, error: String) -> void:
	_busy = false
	ask_button.disabled = false
	if not error.is_empty():
		status_label.text = error
		reply_label.text += "\n\n[color=#ff8888]%s[/color]" % error
		return
	status_label.text = "Remembered in Engram."
	var last_q := input.text.strip_edges()
	history.append({"role": "user", "content": last_q})
	history.append({"role": "assistant", "content": reply})
	var short := speaker_name.split(" ")[-1]
	reply_label.text = "[i]You:[/i] %s\n\n[b]%s:[/b] %s" % [last_q, short, reply]
	input.text = ""
	input.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel"):
		close_panel()
		get_viewport().set_input_as_handled()