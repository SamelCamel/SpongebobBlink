extends Node

var playerAPI
var player_face
var blink_stream
var status
var can_play = false
var has_played = false

onready var blink_sound = preload("res://mods/SamelCamel.SpongebobBlink/Assets/Sounds/spongebob_blink.wav")

func _ready():
	playerAPI = get_node_or_null("/root/BlueberryWolfiAPIs/PlayerAPI")
	
	if playerAPI != null:
		status = playerAPI.connect("_ingame", self, "connect_to_player")
		# print("Connect Status for connect to _ingame: " + str(status))
	
	blink_stream = AudioStreamPlayer3D.new()
	#if blink_stream != null: print("[SAMELCAMEL] created new audiostreamplayer2d")
	
	var thread = Thread.new()

func connect_to_player():
	blink_stream.set_stream(blink_sound)
	
	player_face = playerAPI.local_player.get_node("body/player_body/Armature/Skeleton/face/player_face")
	
	if player_face != null:
		player_face.add_child(blink_stream)

func _process(delta):
	if(player_face != null):
		if(has_played == false and can_play == true):
			blink_stream.play(0.0)
			has_played = true
			
		if(player_face.blink_time > 0):
			can_play = true
			
		if(player_face.blink_time == 0):
			has_played = false
			can_play = false
