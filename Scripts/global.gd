extends Node

# Create the Player in global, this allows all scenes to easily access it's variables
var player_scene = load("res://Scenes/player.tscn")
var current_player_GL = player_scene.instantiate() # GL = global, to reduce confusion across scenes

# Reference List for all enemy types
@export var enemy_scenes: Array[PackedScene] = []


''' ---------- DICTIONARY DATA ---------- '''
''' The Levels_Dict contains a reference list of each Level
each Level contains a list of lists containing a Wave and a wave_delay
each Wave contains a list of lists containing a reference to enemy_scenes 
	and subsequent data being spawn data
each Spawn Data is a list of lists containing a variable name and and variable data
every enemy will have at least spawn_position (in the first spot), 
	which is a list telling which direction (0=top, 1=left, 2=right) and spot to spawn from (% wise from 0 to 1)
'''

var Level_1_Waves = [
	[ # Spawns 3 basic enemies at 30%, 50%, and 70% across the top, with the middle one being twice as fast
		[   0, ["spawn_position", [0, 0.3]], ["speed", 300]   ],
		[   0, ["spawn_position", [0, 0.5]], ["speed", 600]   ],
		[   0, ["spawn_position", [0, 0.7]], ["speed", 300]   ]
	],
	[ # Spawns 3 aimer enemies that slide in from the left, ending with staggered horizontal positions
		[   1, ["spawn_position", [0, 0.2]], ["relative_shoot_pos", Vector2(100, 0)]   ],
		[   1, ["spawn_position", [0, 0.5]], ["relative_shoot_pos", Vector2(80, 0)]   ],
		[   1, ["spawn_position", [0, 0.8]], ["relative_shoot_pos", Vector2(60, 0)]   ]
	],
	[ # Spawns 2 basic enemies flanking one aimer, coming from the top
		[   0, ["spawn_position", [0, 0.4]]   ],
		[   0, ["spawn_position", [0, 0.6]]   ],
		[   1, ["spawn_position", [0, 0.5]], ["relative_shoot_pos", Vector2(0, 50)]   ]
	]
]

var Levels_Dict = {
	# Level 1 spawns wave 1, then waits 5 seconds before wave 2, 
	# 	waits 5 more seconds then wave 3, then 10 seconds before the level ends
	"Level_1": [ [Level_1_Waves[0],5], [Level_1_Waves[1],5], [Level_1_Waves[2],10] ],
	"Level_2": []
}


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
