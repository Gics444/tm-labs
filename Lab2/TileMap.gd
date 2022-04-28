extends TileMap

const TILE_SIZE = 64

const SPEED_1 = 0.3
const SPEED_2 = 0.15
const SPEED_3 = 0.1
const SPEED_4 = 0.05

const BASIC_ROLE = 0
const HARDENED_ROLE = 1
const KILLER_ROLE = 2
const BASIC_ENV = 3
const FERTILE_ENV = 4
const DEADLY_ENV = 5
const CRIMINAL_ENV = 6

const ALIVE = [BASIC_ROLE, HARDENED_ROLE, KILLER_ROLE]
const DEAD = [BASIC_ENV, FERTILE_ENV, DEADLY_ENV, CRIMINAL_ENV]

export(int) var width
export(int) var height

var playing = false
var mouse_left_down = false

const btnHeight = 170
const btnYPos = -200

var temp_field 
var environments

onready var pausePlayBtn = $PausePlayButton
onready var randomBtn = $RandomButton
onready var expandedRandomBtn = $ExpandedRandomButton

onready var basicRole = $Roles/Basic
onready var hardenedRole = $Roles/Hardened
onready var killerRole = $Roles/Killer
onready var basicEnv = $Environments/Basic
onready var fertileEnv = $Environments/Fertile
onready var deadlyEnv = $Environments/Deadly
onready var criminalEnv = $Environments/Criminal

onready var speed1Btn = $"SpeedButtons/1"
onready var speed2Btn = $"SpeedButtons/2"
onready var speed3Btn = $"SpeedButtons/3"
onready var speed4Btn = $"SpeedButtons/4"
onready var timer = $Timer

var playIcon = preload("res://sprites/play.png")
var stopIcon = preload("res://sprites/stop.png")

onready var speedPressed = $"SpeedButtons/1"
onready var cellPressed = $Roles/Basic

func _ready():
	randomize()
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	var cam = $Camera2D
	
	cam.position = (Vector2(width_px, height_px)/2)+Vector2(0, -768*0.15)
	cam.zoom = (Vector2(width_px, height_px) / Vector2(1360, 768))+Vector2(0.05,0.4)
	$GenerateLabel.rect_position = Vector2(0,btnYPos)
	
	randomBtn.rect_position = Vector2(600, btnYPos)
	randomBtn.rect_size = Vector2(500, btnHeight)
	randomBtn.disabled = false
	
	expandedRandomBtn.rect_position = Vector2(1100, btnYPos)
	expandedRandomBtn.rect_size = Vector2(500, btnHeight)
	expandedRandomBtn.disabled = false
	
	$"ClearButton".rect_position = Vector2(1760, btnYPos)
	$"ClearButton".rect_size = Vector2(430, btnHeight)
	
	$"HelpButton".rect_position = Vector2(2260, btnYPos)
	$"HelpButton".rect_size = Vector2(btnHeight, btnHeight)
	
	$"CellsLabel".rect_position = Vector2(2550, btnYPos)
	
	basicRole.rect_position = Vector2(3050, btnYPos)
	basicRole.id = BASIC_ROLE
	hardenedRole.rect_position = Vector2(3250, btnYPos)
	hardenedRole.id = HARDENED_ROLE
	killerRole.rect_position = Vector2(3450, btnYPos)
	killerRole.id = KILLER_ROLE
	basicEnv.rect_position = Vector2(3650, btnYPos)
	basicEnv.id = BASIC_ENV
	fertileEnv.rect_position = Vector2(3850, btnYPos)
	fertileEnv.id = FERTILE_ENV
	deadlyEnv.rect_position = Vector2(4050, btnYPos)
	deadlyEnv.id = DEADLY_ENV
	criminalEnv.rect_position = Vector2(4250, btnYPos)
	criminalEnv.id = CRIMINAL_ENV
	
	cellPressed.pressed = true
	
	pausePlayBtn.rect_position = Vector2(4700, btnYPos)
	pausePlayBtn.rect_size = Vector2(btnHeight, btnHeight)
	pausePlayBtn.icon = playIcon
	
	$"SpeedLabel".rect_position = Vector2(4900, btnYPos)
	
	speed1Btn.rect_size = Vector2(btnHeight, btnHeight)
	speed1Btn.rect_position = Vector2(5350, btnYPos)
	speed2Btn.rect_size = Vector2(btnHeight, btnHeight)
	speed2Btn.rect_position = Vector2(5550, btnYPos)
	speed3Btn.rect_size = Vector2(btnHeight, btnHeight)
	speed3Btn.rect_position = Vector2(5750, btnYPos)
	speed4Btn.rect_size = Vector2(btnHeight, btnHeight)
	speed4Btn.rect_position = Vector2(5950, btnYPos)
	
	speedPressed.pressed = true
	timer.wait_time = SPEED_1
	
	
	clear_board()
	

func clear_board():
	temp_field = []
	environments = []
	for x in range(width):
		var temp = []
		var tempEnv = []
		for y in range(height):
			set_cell(x, y, BASIC_ENV) 
			temp.append(BASIC_ENV)
			tempEnv.append(BASIC_ENV)
		temp_field.append(temp)
		environments.append(tempEnv)

func _input(event):
	if event.is_action_pressed("toggle_play"):
		pausePlayBtn.emit_signal("pressed")
	
	if event.is_action_pressed("speed_1"):
		speed1Btn.emit_signal("pressed")
		
	if event.is_action_pressed("speed_2"):
		speed2Btn.emit_signal("pressed")
		
	if event.is_action_pressed("speed_3"):
		speed3Btn.emit_signal("pressed")
	
	if event.is_action_pressed("speed_4"):
		speed4Btn.emit_signal("pressed")
	
	if not playing :
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.is_pressed():
				mouse_left_down = true
			elif event.button_index == 1 and not event.is_pressed():
				mouse_left_down = false
		
	
func _process(delta):
	if mouse_left_down:
		var pos = (get_local_mouse_position()/TILE_SIZE).floor()
		if get_cellv(pos) != INVALID_CELL:
			set_cellv(pos, cellPressed.id)
			if(cellPressed.id in DEAD):
				environments[pos.x][pos.y] = cellPressed.id

func update_field():
	if !playing:
		return
	
	for x in range(width):
		for y in range(height):
			match get_cell(x,y):
				BASIC_ROLE:
					resolve_basic_role(x, y)
				HARDENED_ROLE:
					resolve_hardened_role(x, y)
				KILLER_ROLE:
					resolve_killer_role(x, y)
				BASIC_ENV:
					resolve_basic_env(x, y)
				FERTILE_ENV:
					resolve_fertile_env(x, y)
				DEADLY_ENV:
					resolve_deadly_env(x, y)
				CRIMINAL_ENV:
					resolve_criminal_env(x, y)
					
	for x in range(width):
		for y in range(height):
			set_cell(x, y, temp_field[x][y])

func resolve_basic_role(x, y):
	var live_neighbors = 0
	var killer_nearby = false
	
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				var cell = get_cell((x+x_off+width)%width, (y+y_off+height)%height)
				if cell in ALIVE:
					live_neighbors += 1
				if cell == KILLER_ROLE:
					killer_nearby = true
					
	if live_neighbors in [2, 3]:
		if killer_nearby:
			var rand = randi()%100
			if rand < 50:
				temp_field[x][y] = environments[x][y]
			elif rand >=50 and rand < 80:
				temp_field[x][y] = KILLER_ROLE
			elif rand >=80 and rand <100:
				temp_field[x][y] = BASIC_ROLE
		else:
			temp_field[x][y] = BASIC_ROLE
	else:
		temp_field[x][y] = environments[x][y]
		

func resolve_hardened_role(x, y):
	var live_neighbors = 0
	var killer_nearby = false
	
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				var cell = get_cell((x+x_off+width)%width, (y+y_off+height)%height)
				if cell in ALIVE:
					live_neighbors += 1
				if cell == KILLER_ROLE:
					killer_nearby = true
					
	if live_neighbors in [1,2,3,4]:
		if killer_nearby:
			var rand = randi()%100
			if rand < 10:
				temp_field[x][y] = environments[x][y]
			elif rand >=10 and rand < 100:
				temp_field[x][y] = HARDENED_ROLE
		else:
			temp_field[x][y] = HARDENED_ROLE
	else:
		temp_field[x][y] = environments[x][y]

func resolve_killer_role(x, y):
	var live_neighbors = 0
	var hardened_nearby = false
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				var cell = get_cell((x+x_off+width)%width, (y+y_off+height)%height)
				if cell in ALIVE:
					live_neighbors += 1
				if cell == HARDENED_ROLE:
					hardened_nearby = true
	if live_neighbors in [2, 3]:
		if hardened_nearby:
			var rand = randi()%100
			if rand < 80:
				temp_field[x][y] = environments[x][y]
			elif rand >=80 and rand <100:
				temp_field[x][y] = KILLER_ROLE
		else:
			temp_field[x][y] = KILLER_ROLE
	else:
		temp_field[x][y] = environments[x][y]
	
func resolve_basic_env(x, y):
	var live_neighbors = 0
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				if get_cell((x+x_off+width)%width, (y+y_off+height)%height) in ALIVE:
					live_neighbors += 1
	if live_neighbors == 3:
		temp_field[x][y] = BASIC_ROLE
	else:
		temp_field[x][y] = environments[x][y]
	
func resolve_fertile_env(x, y):
	var live_neighbors = 0
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				if get_cell((x+x_off+width)%width, (y+y_off+height)%height) in ALIVE:
					live_neighbors += 1
	if live_neighbors == 2:
		var random = randi()%100
		var cell = BASIC_ROLE
		if random == 98:
			cell = HARDENED_ROLE
		if random == 99:
			cell = KILLER_ROLE
		temp_field[x][y] = cell
	else:
		temp_field[x][y] = environments[x][y]
	
func resolve_deadly_env(x, y):
	var live_neighbors = 0
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				if get_cell((x+x_off+width)%width, (y+y_off+height)%height) in ALIVE:
					live_neighbors += 1
	if live_neighbors == 4:
		var random = randi()%100
		var cell = BASIC_ROLE
		if random < 50:
			cell = HARDENED_ROLE
		elif random == 99:
			cell = KILLER_ROLE
		temp_field[x][y] = cell
	else:
		temp_field[x][y] = environments[x][y]

func resolve_criminal_env(x, y):
	var live_neighbors = 0
	for x_off in [-1, 0, 1]:
		for y_off in [-1, 0, 1]:
			if x_off!=y_off or x_off!=0:
				if get_cell((x+x_off+width)%width, (y+y_off+height)%height) in ALIVE:
					live_neighbors += 1
	if live_neighbors == 3:
		var random = randi()%100
		var cell = BASIC_ROLE
		if random < 5:
			cell = HARDENED_ROLE
		elif random >=5 and random <40:
			cell = KILLER_ROLE
		temp_field[x][y] = cell
	else:
		temp_field[x][y] = environments[x][y]
		
func _on_Timer_timeout():
	update_field()


func _on_RandomButton_pressed():
	clear_board()
	for x in range(width):
		for y in range(height):
			var cell = BASIC_ROLE if randi()%100 < 30 else BASIC_ENV
			set_cell(x, y, cell) 
			
func _on_ExpandedRandomButton_pressed():
	clear_board()
	var fertile = randi()%3+1
	var deadly = randi()%3+1
	var criminal = randi()%3+1
	
	for i in range(fertile):
		var size = randi()%75+35
		var origin = Vector2(randi()%width, randi()%height)
		
		while size>0:
			while environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] != BASIC_ENV:
				origin += Vector2(randi()%3-1, randi()%3-1)
			environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] = FERTILE_ENV
			size -= 1
	
	for i in range(deadly):
		var size = randi()%60+30
		var origin = Vector2(randi()%width, randi()%height)
		
		while size>0:
			while environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] != BASIC_ENV:
				origin += Vector2(randi()%3-1, randi()%3-1)
			environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] = DEADLY_ENV
			size -= 1
			
	for i in range(criminal):
		var size = randi()%75+35
		var origin = Vector2(randi()%width, randi()%height)
		
		while size>0:
			while environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] != BASIC_ENV:
				origin += Vector2(randi()%3-1, randi()%3-1)
			environments[(int(origin.x)+width)%width][(int(origin.y)+height)%height] = CRIMINAL_ENV
			size -= 1
	
	for x in range(width):
		for y in range(height):
			set_cell(x, y, environments[x][y]) 
			
	for x in range(width):
		for y in range(height):
			var random = randi()%100
			var cell = environments[x][y]
			if random < 18:
				cell = BASIC_ROLE
			elif random == 18:
				cell = HARDENED_ROLE
			elif random == 19:
				cell = KILLER_ROLE
				
			set_cell(x, y, cell) 
	
func _on_PausePlayButton_pressed():
	playing = !playing
	if playing:
		pausePlayBtn.icon = stopIcon
		randomBtn.disabled = true
		expandedRandomBtn.disabled = true
	else:
		pausePlayBtn.icon = playIcon
		randomBtn.disabled = false
		expandedRandomBtn.disabled = false


func _on_1_pressed():
	speedPressed.pressed = false
	speedPressed = speed1Btn
	speedPressed.pressed = true
	timer.wait_time = SPEED_1
func _on_2_pressed():
	speedPressed.pressed = false
	speedPressed = speed2Btn
	speedPressed.pressed = true
	timer.wait_time = SPEED_2
func _on_3_pressed():
	speedPressed.pressed = false
	speedPressed = speed3Btn
	speedPressed.pressed = true
	timer.wait_time = SPEED_3
func _on_4_pressed():
	speedPressed.pressed = false
	speedPressed = speed4Btn
	speedPressed.pressed = true
	timer.wait_time = SPEED_4


func _on_ClearButton_pressed():
	clear_board()


func _on_HelpButton_pressed():
	$WindowDialog.popup_centered()


func _on_BasicRole_pressed():
	cellPressed.pressed = false
	cellPressed = basicRole
	cellPressed.pressed = true

func _on_HardenedRole_pressed():
	cellPressed.pressed = false
	cellPressed = hardenedRole
	cellPressed.pressed = true
	
func _on_KillerRole_pressed():
	cellPressed.pressed = false
	cellPressed = killerRole
	cellPressed.pressed = true
	
func _on_BasicEnv_pressed():
	cellPressed.pressed = false
	cellPressed = basicEnv
	cellPressed.pressed = true

func _on_FertileEnv_pressed():
	cellPressed.pressed = false
	cellPressed = fertileEnv
	cellPressed.pressed = true

func _on_DeadlyEnv_pressed():
	cellPressed.pressed = false
	cellPressed = deadlyEnv
	cellPressed.pressed = true

func _on_CriminalEnv_pressed():
	cellPressed.pressed = false
	cellPressed = criminalEnv
	cellPressed.pressed = true



