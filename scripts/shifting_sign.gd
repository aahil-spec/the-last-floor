extends Label3D


@export var visiblity_notifier:VisibleOnScreenNotifier3D

var room_numbers:Array[String]=[
	"Room No. : 1001",
	"Room No. : 879",
	"Room No. : 912",
	"Room No. : 765",
	"Room No. : 456",
	"Room No. : 503"
]

var current_index:int=0
var is_locked:bool=false

func _ready():
	self.text=room_numbers[0]
	if visiblity_notifier:
		visiblity_notifier.screen_exited.connect(_on_screen_exited)
func _on_screen_exited():
	if is_locked:
		return
	current_index+=1
	if current_index>=room_numbers.size()-1:
		current_index=room_numbers.size()-1
		is_locked=true
	self.text=room_numbers[current_index]
