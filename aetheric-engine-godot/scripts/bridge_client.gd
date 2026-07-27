extends Node
class_name BridgeClient

const BRIDGE_URL := "http://127.0.0.1:3001/chat"
const HEALTH_URL := "http://127.0.0.1:3001/health"

signal chat_finished(reply: String, error: String)
signal health_checked(ok: bool, detail: String)

var _http: HTTPRequest

func _ready() -> void:
	_http = HTTPRequest.new()
	add_child(_http)
	_http.request_completed.connect(_on_request_completed)
	_http.timeout = 120.0

var _pending_kind := ""

func check_health() -> void:
	_pending_kind = "health"
	var err := _http.request(HEALTH_URL)
	if err != OK:
		health_checked.emit(false, "Could not reach bridge (is server running?)")

func send_chat(speaker: String, message: String, history: Array) -> void:
	_pending_kind = "chat"
	var body := {
		"speaker": speaker,
		"message": message,
		"history": history,
	}
	var json := JSON.stringify(body)
	var headers := ["Content-Type: application/json"]
	var err := _http.request(BRIDGE_URL, headers, HTTPClient.METHOD_POST, json)
	if err != OK:
		chat_finished.emit("", "Failed to send question to the bridge.")

func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if _pending_kind == "health":
		var ok := result == HTTPRequest.RESULT_SUCCESS and response_code == 200
		health_checked.emit(ok, body.get_string_from_utf8() if ok else "Bridge offline")
		return

	if result != HTTPRequest.RESULT_SUCCESS:
		chat_finished.emit("", "Bridge connection failed.")
		return
	if response_code != 200:
		chat_finished.emit("", "Bridge error %d" % response_code)
		return

	var text := body.get_string_from_utf8()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		chat_finished.emit("", "Bad response from bridge.")
		return
	if parsed.has("error"):
		chat_finished.emit("", str(parsed["error"]))
		return
	chat_finished.emit(str(parsed.get("reply", "...")), "")