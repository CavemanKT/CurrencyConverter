extends Node

func _ready():
	OS.set_low_processor_usage_mode(true)
	OS.set_window_title('Currency Converter')
	OS.set_window_size(OS.get_window_size() * 1.5)
