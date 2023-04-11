#####################################################################
#
# CSCB58 Winter 2023 Assembly Final Project
# University of Toronto, Scarborough
#
# Student Name: Emma Gong, 
# Student Number:1007819951
# UtorID: gongemma
# Email: emma.gong@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 
# - Unit height in pixels: 8 
# - Display width in pixels: 512 
# - Display height in pixels: 512 
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1, 2, 3
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Fail condition
# 2. Health/score
# 3. Win condition
# 4. Moving objects
# 5. Different levels
# 6. Enemies shoot back
#
# Link to video demonstration for final submission:
# https://www.youtube.com/watch?v=YdxHjHEjvv0
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################


.eqv	BASE_ADDRESS	0x10008000
.eqv	GRAY 		0xD3D3D3
.eqv	DARK_GRAY	0x949494
.eqv	YELLOW		0xFFFF00
.eqv	GOLDEN_YELLOW   0xFEEB75
.eqv	PURPLE		0xA45EE5
.eqv	PINK            0xFC8EAC
.eqv	WHITE		0xFFFFFF
.eqv	BLACK		0x000000
.eqv	GREEN		0x74B72E
.eqv	ORANGE		0xEC9706
.eqv	SKIN		0xFDEFE5
.eqv	LIGHT_BLUE	0xC0E6F0
.eqv	DARK_BLUE	0x8ACBDE
.eqv    BLUE            0xADD8E6
.eqv    RED		0xFF2C2C
.eqv	ROSE_RED	0xE3242B
.eqv	BROWN		0x80471C
.eqv	ASH_GRAY	0x564C4D


.data

wizard: .word 	0x1000B680, 0x1000B684, 0x1000B77C, 0x1000B780, 0x1000B784, 0x1000B788, 0x1000B880, 0x1000B884, 0x1000B980, 0x1000B984, 0x1000BA80, 0x1000BA84
game1_enemy1: .word 1, 0x100084C0, 0x100085B8, 0x100085BC, 0x100085C0, 0x100085C4, 0x100085C8, 0x100086B8, 0x100086BC, 0x100086C0, 0x100086C4, 0x100086C8, 0x100087B8, 0x100087BC, 0x100087C0, 0x100087C4, 0x100087C8, 0x100088BC, 0x100088C4
game1_enemy2: .word 1, 0x1000983C, 0x10009934, 0x10009938, 0x1000993C, 0x10009940, 0x10009944, 0x10009A34, 0x10009A38, 0x10009A3C, 0x10009A40, 0x10009A44, 0x10009B34, 0x10009B38, 0x10009B3C, 0x10009B40, 0x10009B44, 0x10009C38, 0x10009C40
game1_enemy_move: .word	0x1000843C, 0x100084C0, 0x1000983C, 0x100098C0
game2_enemy1: .word 0:13
game2_enemy2: .word 0:19 
game2_enemy3: .word 0:13
game2_enemy_move: .word 0x10008300, 0x100083E0, 0x10009738, 0x100097C4, 0x1000A000, 0x1000A0DC
game3_enemy1: .word 0:13
game3_enemy_move: .word 0x10008530, 0x100085D0
game3_bullet1:	0, 0x10008E60, 0x10008EF0
game3_bullet2:	0, 0x100099D4, 0x10009900
game3_bullet3:	0, 0x1000A428, 0x1000A4FC
game3_bullet4:	0, 0x1000AFD4, 0x1000AF04

 
.text
Global_Var:	li $s7, 0xffff0000	# Address of keystroke event
        	la $s6, wizard 		# Address of wizard
        	li $s0, 150 		# Refresh Rate
        	li $s1, 1 		# Level Number
        	li $s2, 3		# health
        	li $s3, 0		# number of collected item
        	li $s4, 0		# time for wizard to keep red after collision
        	li $s5, 8		# number of items that need to be collected

#########################################
# LEVEL SETTING
#########################################
level_one:	li $t0, BASE_ADDRESS	#Paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color

		li $t0, BASE_ADDRESS	#Draw LEVEL 1
		li $t1, YELLOW
		jal print_level
		jal print_one
		
		li $t1, 1500	#sleep 1.5sec
		li $v0, 32
        	add $a0, $t1, $zero
        	syscall

start_one:	li $t0, BASE_ADDRESS	#Paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color

		li $t0, BASE_ADDRESS	#Draw the platform, enemies, coins, and diamonds for level 1
		li $t1, WHITE
		addi $t0, $t0, 2356
		addi $t3, $t0, 152
		jal color
		
		addi $t0, $t0, 104
		addi $t3, $t0, 152
		jal color
		
		addi $t0, $t0, 2100
		addi $t3, $t0, 80
		jal color
		
		addi $t0, $t0, 96
		addi $t3, $t0, 160
		jal color
		
		addi $t0, $t0, 96
		addi $t3, $t0, 80
		jal color
		
		addi $t0, $t0, 2100
		addi $t3, $t0, 152
		jal color
		
		addi $t0, $t0, 104
		addi $t3, $t0, 152
		jal color
		
		addi $t0, $t0, 2100
		addi $t3, $t0, 80
		jal color
		
		addi $t0, $t0, 96
		addi $t3, $t0, 160
		jal color
		
		addi $t0, $t0, 96
		addi $t3, $t0, 80
		jal color
		
		addi $t0, $t0, 2100
		addi $t3, $t0, 152
		jal color
		
		addi $t0, $t0, 104
		addi $t3, $t0, 152
		jal color
		
		li $t0, BASE_ADDRESS
		addi $t0, $t0, 15104
		addi $t3, $t0, 1280	
		jal color
		
		jal draw_life
		
		jal game_1_coin
		
		jal game_1_diamond
		
		jal game_1_enemy
		
		jal Ini_Wizard
		
		li $s3, 0	#set the initial values for level 1
		li $s2, 3	#$s3 = collected item; $s2 = health; $s1 = level number; $s5 = number of collected item
		li $s1, 1
		li $s5, 8
		
		j game_loop
		
level_two:	li $t0, BASE_ADDRESS	#Paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color

		li $t0, BASE_ADDRESS	#Draw LEVEL 2
		li $t1, YELLOW
		jal print_level
		jal print_two
		
		li $t1, 1500	#sleep 1.5sec
		li $v0, 32
        	add $a0, $t1, $zero
        	syscall
		
start_two: 	li $t0, BASE_ADDRESS	#Paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color
		
		li $t0, BASE_ADDRESS	#Draw the platform, enemies, coins, and diamonds for level 2
		li $t1, WHITE
		addi $t0, $t0, 2344
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 76
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 1828
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 64
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 88
		jal color
		
		addi $t0, $t0, 64
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 2088
		addi $t3, $t0, 180
		jal color
		
		addi $t0, $t0, 76
		addi $t3, $t0, 180
		jal color
		
		addi $t0, $t0, 2084
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 64
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 88
		jal color
		
		addi $t0, $t0, 64
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 44
		jal color
		
		addi $t0, $t0, 2088
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 76
		addi $t3, $t0, 68
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 68
		jal color
		
		li $t0, BASE_ADDRESS
		addi $t0, $t0, 15104
		addi $t3, $t0, 64	
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 48	
		jal color
		
		addi $t0, $t0, 32
		addi $t3, $t0, 132	
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 48	
		jal color
		
		addi $t0, $t0, 32
		addi $t3, $t0, 132	
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 48	
		jal color
		
		addi $t0, $t0, 32
		addi $t3, $t0, 132	
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 48	
		jal color
		
		addi $t0, $t0, 32
		addi $t3, $t0, 132	
		jal color
		
		addi $t0, $t0, 44
		addi $t3, $t0, 48	
		jal color
		
		addi $t0, $t0, 32
		addi $t3, $t0, 68	
		jal color
		
		jal draw_life
		
		jal game_2_coin
		
		jal game_2_diamond
		
		jal game_2_enemy
		
		jal Ini_Wizard
		
		li $s3, 0	#set the initial values for level 2
		li $s2, 3
		li $s1, 2
		li $s5, 8
		
		j game_loop
	
level_three:	li $t0, BASE_ADDRESS	#paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color

		li $t0, BASE_ADDRESS	#draw LEVEL 3
		li $t1, YELLOW
		jal print_level
		jal print_three
		
		li $t1, 1500	#sleep 1.5sec
		li $v0, 32
        	add $a0, $t1, $zero
        	syscall
        	
start_three:	li $t0, BASE_ADDRESS	#paint the background black
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color
		
		li $t0, BASE_ADDRESS	#Draw the platform, enemies, coins, and diamonds for level 3
		li $t1, WHITE
		sw $t1, 36($t0)
		sw $t1, 40($t0)
		sw $t1, 292($t0)
		sw $t1, 296($t0)
		sw $t1, 548($t0)
		sw $t1, 552($t0)
		sw $t1, 804($t0)
		sw $t1, 808($t0)
		sw $t1, 1060($t0)
		sw $t1, 1064($t0)
		sw $t1, 1316($t0)
		sw $t1, 1320($t0)
		sw $t1, 1572($t0)
		sw $t1, 1576($t0)
		sw $t1, 1828($t0)
		sw $t1, 1832($t0)
		
		sw $t1, 1824($t0)
		sw $t1, 1820($t0)
		
		sw $t1, 1800($t0)
		sw $t1, 1796($t0)
		sw $t1, 1792($t0)

		li $t0, BASE_ADDRESS
		addi $t0, $t0, 4352
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 2424
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 2304
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 2424
		addi $t3, $t0, 196	
		jal color
		
		addi $t0, $t0, 60
		addi $t3, $t0, 196	
		jal color
		
		li $t0, BASE_ADDRESS
		addi $t0, $t0, 15104
		addi $t3, $t0, 1280	
		jal color
		
		jal draw_life
		
		jal game_3_coin		
		
		jal game_3_diamond	
		
		jal game_3_enemy
		
		jal game_3_moving_enemy
		
		jal Ini_Wizard

		li $s3, 0	#set initial values for level 3
		li $s2, 3
		li $s1, 3
		li $s5, 2
		
		j game_loop
#########################################
# GAME PLAY
#########################################
game_loop:	add $a0, $s6, $zero	#store address of wizard in $a0
		add $a1, $s7, $zero	#store address of key stroke in $a1
		jal key_update		#respond to keys
		jal game_move		#the moving of enemies
		
		add $a0, $s6, $zero	#store address of wizard in $a0
		add $a1, $s2, $zero	#store health status in $a1
		add $a2, $s4, $zero	#store time left for wizard to stay red after collision in $a2
		jal check_collision	#check if collision with enemy happened
		addi $s2, $v0, 0	#update health status
		addi $s4, $v1, 0	#update the time left for wizard to stay red after collision in $a2
		
		addi $a0, $s2, 0	#store health status in $a0
		jal update_health	#draw new health status
		beq $s2, 0, fail	#if health status = 0, game over
		beq $s3, $s5, next_level	#if number of collected item = number of items need to be collected, next level
	
Refresh:	li $v0, 32	
        	add $a0, $s0, $zero
        	syscall
        	j game_loop
        	
#########################################
# ENEMY MOVING
#########################################
game_move:	beq $s1, 1, game_1_move		#branch to each level's corresponding enemy moving route
		beq $s1, 2, game_2_move
		beq $s1, 3, game_3_move

#$t8 stores 1 or 2 indicating if the enemy is moving right or left. $t3 stores the left boundary of the enemy's moving route.
#$t4 stores the left right boundary of the enemy's moving route.
#For bullets, $t8 stores the current address of the bullet, if is 0 then new bullet need to be generated.
#$t3 stores the starting address of the bullet, $t4 stores the address where the bullet disappears.		
game_1_move:	li $t0, GRAY
		li $t1, DARK_GRAY
		la $t9, game1_enemy_move
		move $t6, $ra
		##enemy 1 move
		la $t2, game1_enemy1
		lw $t8, 0($t2)		
		lw $t3, 0($t9)
		lw $t4, 4($t9)
		jal stoneman_horizontal_move
		##enemy 2 move
		la $t2, game1_enemy2
		lw $t8, 0($t2)
		lw $t3, 8($t9)
		lw $t4, 12($t9)
		jal stoneman_horizontal_move
		
		move $ra, $t6
		j return
		
game_2_move:	li $t0, GREEN
		li $t1, ORANGE
		la $t9, game2_enemy_move
		move $t6, $ra
		##enemy 1 move
		la $t2, game2_enemy1
		lw $t8, 0($t2)
		lw $t3, 0($t9)
		lw $t4, 4($t9)
		jal horizontal_fly
		##enemy 2 move
		li $t0, GRAY
		li $t1, DARK_GRAY
		la $t2, game2_enemy2
		lw $t8, 0($t2)
		lw $t3, 8($t9)
		lw $t4, 12($t9)
		jal stoneman_horizontal_move
		##enemy 3 move
		li $t0, GREEN
		li $t1, ORANGE
		la $t2, game2_enemy3
		lw $t8, 0($t2)
		lw $t3, 16($t9)
		lw $t4, 20($t9)
		jal horizontal_fly
		
		move $ra, $t6
		j return
		
game_3_move: 	li $t0, GREEN
		li $t1, ORANGE
		la $t9, game3_enemy_move
		move $t6, $ra
		##enemy 1 move
		la $t2, game3_enemy1
		lw $t8, 0($t2)
		lw $t3, 0($t9)
		lw $t4, 4($t9)
		jal horizontal_fly
		##bullet one
		li $t0, ASH_GRAY
		la $t2, game3_bullet1
		lw $t8, 0($t2)
		lw $t3, 4($t2)
		lw $t4, 8($t2)
		jal bullet_right
		##bullet two
		la $t2, game3_bullet2
		lw $t8, 0($t2)
		lw $t3, 4($t2)
		lw $t4, 8($t2)
		jal bullet_left
		##bullet three
		la $t2, game3_bullet3
		lw $t8, 0($t2)
		lw $t3, 4($t2)
		lw $t4, 8($t2)
		jal bullet_right
		##bullet four
		la $t2, game3_bullet4
		lw $t8, 0($t2)
		lw $t3, 4($t2)
		lw $t4, 8($t2)
		jal bullet_left
		move $ra, $t6
		j game_3_enemy
		
#bullet moving right
bullet_right: 	beq $t8, 0, new_bullet		#if current address of the bullet is 0, new bullet need to be generated
		beq $t8, $t4, bullet_disappear	#if the bullet reach the end address, it disappears
		sw $zero, 0($t8)
		addi $t8, $t8, 4
		sw $t0, 0($t8)
		sw $t8, 0($t2)
		j return

#bullet moving left		
bullet_left:	beq $t8, 0, new_bullet		#if current address of the bullet is 0, new bullet need to be generated
		beq $t8, $t4, bullet_disappear	#if the bullet reach the end address, it disappears
		sw $zero, 0($t8)
		addi $t8, $t8, -4
		sw $t0, 0($t8)
		sw $t8, 0($t2)
		j return

#generating new bullet		
new_bullet:	sw $t3, 0($t2)	
		lw $t8, 0($t2)
		sw $t0, 0($t8)
		j return
		
bullet_disappear:	li $t8, 0	#set the current address of the bullet to 0
			sw $t8, 0($t2)
			sw $zero, 0($t4)
			j return
		
#takes in $t2, $t8, $t3, $t4
#$t2 stores the address of the enemy, $t8 stores the moving direction of the enemy, $t3 and $t4 are moving boundaries of the enemy		
stoneman_horizontal_move:	beq $t8, 1, stoneman_move_right
        			beq $t8, 2, stoneman_move_left
        			
horizontal_fly:		beq $t8, 1, fly_right
        		beq $t8, 2, fly_left
        		
fly_right:	lw $t8, 4($t2)
		beq $t4, $t8, fly_left	#if reached the right boundary, move left
		li $t8, 1	
		sw $t8, 0($t2)	#set current moving direction to 1, indicating moving right
		lw $t8, 4($t2)
		lw $t8, 284($t8)
		beq $t8, LIGHT_BLUE, fly_over_right	#if a diamond is in front, skip it, appear at the other side of the diamond
		lw $t8, 4($t2)
       		sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t0, 0($t8)
        	sw $t8, 4($t2)
        	lw $t8, 8($t2) #2nd unit
        	addi $t8, $t8, 4
        	sw $t0, 0($t8)
        	sw $t8, 8($t2)
       		lw $t8, 12($t2) #3rd unit
       		sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t0, 0($t8)
        	sw $t8, 12($t2)
        	lw $t8, 16($t2) #4th unit
        	addi $t8, $t8, 4
        	sw $t0, 0($t8)
        	sw $t8, 16($t2)
        	lw $t8, 20($t2) #5th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 20($t2)
        	lw $t8, 24($t2) #6th unit
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 24($t2)
        	lw $t8, 28($t2) #7th unit
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 28($t2)
        	lw $t8, 32($t2) #8th unit
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 32($t2)
        	lw $t8, 36($t2) #9th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 36($t2)
        	lw $t8, 40($t2) #10th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 40($t2)
        	lw $t8, 44($t2) #11th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 44($t2)
        	lw $t8, 48($t2) #12th unit
       		sw $zero, 0($t8)
        	addi $t8, $t8, 4
        	sw $t1, 0($t8)
        	sw $t8, 48($t2)
        	j return
        	
fly_left:	lw $t8, 4($t2)
		beq $t3, $t8, fly_right	#left boundary is reached, move right
		li $t8, 2	#set current moving direction to 2, indicating moving left
		sw $t8, 0($t2)
		lw $t8, 4($t2)
		lw $t8, 256($t8)
		beq $t8, DARK_BLUE, fly_over_left	#if a diamond is in front, skip it, appear at the other side of the diamond
		
		lw $t8, 4($t2)
        	addi $t8, $t8, -4
        	sw $t0, 0($t8)
        	sw $t8, 4($t2)
        	lw $t8, 8($t2) #2nd unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t0, 0($t8)
        	sw $t8, 8($t2)
       		lw $t8, 12($t2) #3rd unit
        	addi $t8, $t8, -4
        	sw $t0, 0($t8)
        	sw $t8, 12($t2)
        	lw $t8, 16($t2) #4th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t0, 0($t8)
        	sw $t8, 16($t2)
        	lw $t8, 20($t2) #5th unit
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 20($t2)
        	lw $t8, 24($t2) #6th unit
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 24($t2)
        	lw $t8, 28($t2) #7th unit
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 28($t2)
        	lw $t8, 32($t2) #8th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 32($t2)
        	lw $t8, 36($t2) #9th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 36($t2)
        	lw $t8, 40($t2) #10th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 40($t2)
        	lw $t8, 44($t2) #11th unit
        	sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 44($t2)
        	lw $t8, 48($t2) #12th unit
       		sw $zero, 0($t8)
        	addi $t8, $t8, -4
        	sw $t1, 0($t8)
        	sw $t8, 48($t2)
        	j return

#skip the diamond when flying right       	
fly_over_right:		lw $t8, 4($t2) #1st unit
			sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t0, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 36
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		j return
    
#skip the diamond when flying left           		
fly_over_left:		lw $t8, 4($t2) #1st unit
			sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t0, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -36
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		j return
        		
##same as flying_right and flying_left, just for different types of enemy       		
stoneman_move_right:	lw $t8, 4($t2)
			beq $t4, $t8, stoneman_move_left	#right boundary reached, move to left
			li $t8, 1	#update current moving direction
			sw $t8, 0($t2)
			lw $t8, 4($t2)
			lw $t8, 16($t8)
			beq $t8, LIGHT_BLUE, sm_jump_over_right	#if diamond in front, skip to the other side of the diamond
		
			lw $t8, 4($t2)
       			sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		lw $t8, 52($t2) #13th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 52($t2)
        		lw $t8, 56($t2) #14th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 56($t2)
        		lw $t8, 60($t2) #15th unit
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 60($t2)
        		lw $t8, 64($t2) #16th unit
        		addi $t8, $t8, 4
        		sw $t1, 0($t8)
        		sw $t8, 64($t2)
        		lw $t8, 68($t2) #17th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 68($t2)
        		lw $t8, 72($t2) #18th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 4
        		sw $t0, 0($t8)
        		sw $t8, 72($t2)
        		j return
        	
stoneman_move_left:	lw $t8, 4($t2)
			beq $t3, $t8, stoneman_move_right	#left boundary reached, move right
			li $t8, 2	#update current moving direction
			sw $t8, 0($t2)
			lw $t8, 4($t2)
			lw $t8, -16($t8)
			beq $t8, DARK_BLUE, sm_jump_over_left	#if diamond in front, skip to the other side
		
			lw $t8, 4($t2)
       			sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		lw $t8, 52($t2) #13th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 52($t2)
        		lw $t8, 56($t2) #14th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 56($t2)
        		lw $t8, 60($t2) #15th unit
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 60($t2)
        		lw $t8, 64($t2) #16th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t1, 0($t8)
        		sw $t8, 64($t2)
        		lw $t8, 68($t2) #17th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 68($t2)
        		lw $t8, 72($t2) #18th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -4
        		sw $t0, 0($t8)
        		sw $t8, 72($t2)
        		j return

#skip diamond when moving right       	
sm_jump_over_right:	lw $t8, 4($t2) #1st unit
			sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		lw $t8, 52($t2) #13th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 52($t2)
        		lw $t8, 56($t2) #14th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 56($t2)
        		lw $t8, 60($t2) #15th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 60($t2)
        		lw $t8, 64($t2) #16th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t1, 0($t8)
        		sw $t8, 64($t2)
        		lw $t8, 68($t2) #17th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 68($t2)
        		lw $t8, 72($t2) #18th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, 40
        		sw $t0, 0($t8)
        		sw $t8, 72($t2)
        		j return

#skip diamond when moving left         		
sm_jump_over_left:	lw $t8, 4($t2) #1st unit
			sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 4($t2)
        		lw $t8, 8($t2) #2nd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 8($t2)
        		lw $t8, 12($t2) #3rd unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 12($t2)
        		lw $t8, 16($t2) #4th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 16($t2)
        		lw $t8, 20($t2) #5th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 20($t2)
        		lw $t8, 24($t2) #6th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 24($t2)
        		lw $t8, 28($t2) #7th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 28($t2)
        		lw $t8, 32($t2) #8th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 32($t2)
        		lw $t8, 36($t2) #9th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 36($t2)
        		lw $t8, 40($t2) #10th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 40($t2)
        		lw $t8, 44($t2) #11th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 44($t2)
        		lw $t8, 48($t2) #12th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 48($t2)
        		lw $t8, 52($t2) #13th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 52($t2)
        		lw $t8, 56($t2) #14th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 56($t2)
        		lw $t8, 60($t2) #15th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 60($t2)
        		lw $t8, 64($t2) #16th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t1, 0($t8)
        		sw $t8, 64($t2)
        		lw $t8, 68($t2) #17th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 68($t2)
        		lw $t8, 72($t2) #18th unit
        		sw $zero, 0($t8)
        		addi $t8, $t8, -40
        		sw $t0, 0($t8)
        		sw $t8, 72($t2)
        		j return
			
#########################################
# KEY CHECK & RESPOND
#########################################
key_update: 	lw $t4, 0($a1)
		li $t7, PURPLE  
         	li $t8, SKIN
            	beq $t4, 1, k_pressed	#check if key is pressed
            	j falling

k_pressed: 	lw $t5, 4($a1)
         	beq $t5, 0x70, respond_p  #branch to corresponding key
         	beq $t5, 0x61, respond_a
         	beq $t5, 0x64, respond_d
         	beq $t5, 0x77, respond_w
         	j return
         
respond_a: 	#Respond to key press 'a'
        	#check if the wizard has reach the left end
        	lw $t0, 8($a0)  
        	li $t1, 256
        	div $t0, $t1
        	mfhi $t1
       		beq $t1, 0, return
       		#check if a platform is at left that block the way
       		li $t1, WHITE
       		lw $t0, -4($t0)
       		beq $t1, $t0, return
       		lw $t0, 0($a0)
       		lw $t0, -4($t0)
       		beq $t1, $t0, return
       		lw $t0, 24($a0)
       		lw $t0, -4($t0)
       		beq $t1, $t0, return
       		lw $t0, 32($a0)
       		lw $t0, -4($t0)
       		beq $t1, $t0, return
       		lw $t0, 40($a0)
       		lw $t0, -4($t0)
       		beq $t1, $t0, return
       		
       		#update the new location for wizard
       		addi $t6, $ra, 0
       		lw $t0, 0($a0)
       		addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 0($a0)
        	lw $t0, 4($a0) #2nd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 4($a0)
        	lw $t0, 8($a0) #3rd unit
        	addi $t0, $t0, -4
        	lw $t2, 0($t0)
        	jal check_collectable_left
        	sw $t7, 0($t0)
        	sw $t0, 8($a0)
        	lw $t0, 12($a0) #4th unit
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 12($a0)
        	lw $t0, 16($a0) #5th unit
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 16($a0)
        	lw $t0, 20($a0) #6th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 20($a0)
        	lw $t0, 24($a0) #7th unit
        	addi $t0, $t0, -4
        	sw $t8, 0($t0)
        	sw $t0, 24($a0)
        	lw $t0, 28($a0) #8th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -4
        	sw $t8, 0($t0)
        	sw $t0, 28($a0)
        	lw $t0, 32($a0) #9th unit
        	addi $t0, $t0, -4
        	lw $t2, 0($t0)
        	jal check_collectable_left 	#check if anything to collect when moving left
        	sw $t7, 0($t0)
        	sw $t0, 32($a0)
        	lw $t0, 36($a0) #10th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 36($a0)
        	lw $t0, 40($a0) #11th unit
        	addi $t0, $t0, -4
        	lw $t2, 0($t0)
        	jal check_collectable_left	#check if anything to collect when moving left
        	sw $t7, 0($t0)
        	sw $t0, 40($a0)
        	lw $t0, 44($a0) #12th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -4
        	sw $t7, 0($t0)
        	sw $t0, 44($a0)
        	addi $ra, $t6, 0
        	j return

respond_d: 	#Respond to key press 'd' 
        	#check if the wizard has reach the right end
        	lw $t0, 20($a0) 
        	li $t1, 256
        	div $t0, $t1
        	mfhi $t1
       		beq $t1, 252, return
       		#check if a platform is at right that block the way
       		li $t1, WHITE
       		lw $t0, 4($t0)
       		beq $t1, $t0, return
       		lw $t0, 4($a0)
       		lw $t0, 4($t0)
       		beq $t1, $t0, return
       		lw $t0, 28($a0)
       		lw $t0, 4($t0)
       		beq $t1, $t0, return
       		lw $t0, 36($a0)
       		lw $t0, 4($t0)
       		beq $t1, $t0, return
       		lw $t0, 44($a0)
       		lw $t0, 4($t0)
       		beq $t1, $t0, return
       		
       		#update the new location for wizard
       		addi $t6, $ra, 0
       		lw $t0, 0($a0)
       		sw $zero, 0($t0)
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 0($a0)
        	lw $t0, 4($a0) #2nd unit
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 4($a0)
        	lw $t0, 8($a0) #3rd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 8($a0)
        	lw $t0, 12($a0) #4th unit
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 12($a0)
        	lw $t0, 16($a0) #5th unit
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 16($a0)
        	lw $t0, 20($a0) #6th unit
        	addi $t0, $t0, 4
        	lw $t2, 0($t0)
        	jal check_collectable_right	#check if anything to collect when moving right
        	sw $t7, 0($t0)
        	sw $t0, 20($a0)
        	lw $t0, 24($a0) #7th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 4
        	sw $t8, 0($t0)
        	sw $t0, 24($a0)
        	lw $t0, 28($a0) #8th unit
        	addi $t0, $t0, 4
        	sw $t8, 0($t0)
        	sw $t0, 28($a0)
        	lw $t0, 32($a0) #9th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 32($a0)
        	lw $t0, 36($a0) #10th unit
        	addi $t0, $t0, 4
        	lw $t2, 0($t0)
        	jal check_collectable_right	#check if anything to collect when moving right
        	sw $t7, 0($t0)
        	sw $t0, 36($a0)
        	lw $t0, 40($a0) #11th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 4
        	sw $t7, 0($t0)
        	sw $t0, 40($a0)
        	lw $t0, 44($a0) #12th unit	
        	addi $t0, $t0, 4
        	lw $t2, 0($t0)
        	jal check_collectable_right	#check if anything to collect when moving right
        	sw $t7, 0($t0)
        	sw $t0, 44($a0)
        	addi $ra, $t6, 0
        	j return
        	
respond_w: 	#Respond to key press 'w' 
        	#check if the wizard has reach the top 
        	lw $t0, 0($a0) 
        	addi $t0, $t0, -256
        	blt $t0, 0x10008000, return
        	#check if a platform is at top that block the way
        	lw $t2, 0($t0)
        	li $t1, WHITE
        	beq $t2, $t1, return  
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	lw $t0, 4($a0) 
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	lw $t0, 8($a0)  
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	lw $t0, 20($a0)  
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	addi $t0, $t0, -256
        	lw $t2, 0($t0)
        	beq $t2, $t1, return
        	
        	
       		#update the new location for wizard
       		addi $t6, $ra, 0
       		lw $t0, 0($a0)
        	addi $t0, $t0, -512
        	lw $t2, 0($t0)
        	jal check_collectable_above	#check if anything to collect when jumping
        	sw $t7, 0($t0)
        	sw $t0, 0($a0)
        	lw $t0, 4($a0) #2nd unit
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 4($a0)
        	lw $t0, 8($a0) #3rd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 8($a0)
        	lw $t0, 12($a0) #4th unit
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 12($a0)
        	lw $t0, 16($a0) #5th unit
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 16($a0)
        	lw $t0, 20($a0) #6th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 20($a0)
        	lw $t0, 24($a0) #7th unit
        	addi $t0, $t0, -512
        	sw $t8, 0($t0)
        	sw $t0, 24($a0)
        	lw $t0, 28($a0) #8th unit
        	addi $t0, $t0, -512
        	sw $t8, 0($t0)
        	sw $t0, 28($a0)
        	lw $t0, 32($a0) #9th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 32($a0)
        	lw $t0, 36($a0) #10th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 36($a0)
        	lw $t0, 40($a0) #11th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 40($a0)
        	lw $t0, 44($a0) #12th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -512
        	sw $t7, 0($t0)
        	sw $t0, 44($a0)
        	addi $ra, $t6, 0
        	j return

respond_p:	j level_one	#restart the game
        	
falling: 	#Fall when no key is pressed and not standing on a platform
        	lw $t0, 40($a0)  
        	addi $t0, $t0, 256
        	bgt $t0, 0x1000C000, fall_from_top	#check if reached at base line (a design used in level 2)
        	#check if standing on a platform
        	lw $t0, 0($t0)
        	li $t1, WHITE
        	beq $t0, $t1, return
        	lw $t0, 44($a0)  
        	addi $t0, $t0, 256
        	lw $t0, 0($t0)
        	beq $t0, $t1, return
        	lw $t0, 8($a0)  
        	addi $t0, $t0, 256
        	lw $t0, 0($t0)
        	beq $t0, $t1, return
        	lw $t0, 20($a0)  
        	addi $t0, $t0, 256
        	lw $t0, 0($t0)
        	beq $t0, $t1, return
        	
        	#update the new location for wizard
        	addi $t6, $ra, 0
        	lw $t0, 0($a0)
        	sw $zero, 0($t0)
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 0($a0)
        	lw $t0, 4($a0) #2nd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 4($a0)
        	lw $t0, 8($a0) #3rd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 8($a0)
        	lw $t0, 12($a0) #4th unit
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 12($a0)
        	lw $t0, 16($a0) #5th unit
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 16($a0)
        	lw $t0, 20($a0) #6th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 20($a0)
        	lw $t0, 24($a0) #7th unit
        	addi $t0, $t0, 256
        	sw $t8, 0($t0)
        	sw $t0, 24($a0)
        	lw $t0, 28($a0) #8th unit
        	addi $t0, $t0, 256
        	sw $t8, 0($t0)
        	sw $t0, 28($a0)
        	lw $t0, 32($a0) #9th unit
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 32($a0)
        	lw $t0, 36($a0) #10th unit
        	addi $t0, $t0, 256
        	sw $t7, 0($t0)
        	sw $t0, 36($a0)
        	lw $t0, 40($a0) #11th unit
        	addi $t0, $t0, 256
        	lw $t2, 0($t0)
        	jal check_collectable_below
        	sw $t7, 0($t0)
        	sw $t0, 40($a0)
        	lw $t0, 44($a0) #12th unit
        	addi $t0, $t0, 256
        	lw $t2, 0($t0)
        	jal check_collectable_below
        	sw $t7, 0($t0)
        	sw $t0, 44($a0)
        	addi $ra, $t6, 0
        	j return
        	
fall_from_top:	lw $t0, 0($a0)
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 0($a0)
        	lw $t0, 4($a0) #2nd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 4($a0)
        	lw $t0, 8($a0) #3rd unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 8($a0)
        	lw $t0, 12($a0) #4th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 12($a0)
        	lw $t0, 16($a0) #5th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 16($a0)
        	lw $t0, 20($a0) #6th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 20($a0)
        	lw $t0, 24($a0) #7th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t8, 0($t0)
        	sw $t0, 24($a0)
        	lw $t0, 28($a0) #8th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t8, 0($t0)
        	sw $t0, 28($a0)
        	lw $t0, 32($a0) #9th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 32($a0)
        	lw $t0, 36($a0) #10th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 36($a0)
        	lw $t0, 40($a0) #11th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 40($a0)
        	lw $t0, 44($a0) #12th unit
        	sw $zero, 0($t0)
        	addi $t0, $t0, -15104
        	sw $t7, 0($t0)
        	sw $t0, 44($a0)
        	j return
        	
#########################################
# CHECK IF COIN / DIAMOND IS COLLECTED
#########################################

check_collectable_left:		beq $t2, BLACK, return
				beq $t2, YELLOW, coin_left	#coin found when moving left
				beq $t2, GOLDEN_YELLOW, coin_left	
				beq $t2, DARK_BLUE, diamond_left	#diamond found when moving left
				j return
				
check_collectable_right:	beq $t2, BLACK, return
				beq $t2, YELLOW, coin_right	#coin found when moving right
				beq $t2, GOLDEN_YELLOW, coin_right	
				beq $t2, LIGHT_BLUE, diamond_right	#diamond found when moving right
				j return
				
check_collectable_below:	beq $t2, BLACK, return
				beq $t2, YELLOW, coin_below	#coin found when falling
				beq $t2, GOLDEN_YELLOW, coin_below	
				beq $t2, LIGHT_BLUE, diamond_below	#diamond found when falling
				beq $t2, DARK_BLUE, diamond_below
				j return
				
check_collectable_above:	beq $t2, BLACK, return
				beq $t2, DARK_BLUE, diamond_above	#diamond found when jumping
				beq $t2, BLUE, diamond_above
				j return


#vanishing the coins / diamond when collected
diamond_above:	sw $zero, -256($t0)
		sw $zero, -252($t0)
		sw $zero, -260($t0)
		sw $zero, -264($t0)
		sw $zero, -248($t0)
		sw $zero, -512($t0)
		sw $zero, -516($t0)
		sw $zero, -520($t0)
		sw $zero, -508($t0)
		sw $zero, -504($t0)
		sw $zero, -764($t0)
		sw $zero, -768($t0)
		sw $zero, -772($t0)
		addi $s3, $s3, 1
		j return

coin_left: 	sw $zero, -260($t0)
		sw $zero, -4($t0)
		sw $zero, 252($t0)
		sw $zero, 256($t0)
		addi $s3, $s3, 1
		j return
		
coin_right:	sw $zero, -252($t0)
		sw $zero, 4($t0)
		sw $zero, 260($t0)
		sw $zero, 256($t0)
		addi $s3, $s3, 1
		j return
		
coin_below:	sw $zero, -4($t0)
		sw $zero, 4($t0)
		sw $zero, 256($t0)
		sw $zero, 260($t0)
		sw $zero, 252($t0)
		addi $s3, $s3, 1
		j return
		
diamond_left:	sw $zero, -256($t0)
		sw $zero, 256($t0)
		sw $zero, 512($t0)
		sw $zero, 768($t0)
		
		sw $zero, -4($t0)
		sw $zero, -260($t0)
		sw $zero, 252($t0)
		sw $zero, 508($t0)
		sw $zero, 764($t0)
		
		sw $zero, -8($t0)
		sw $zero, -264($t0)
		sw $zero, 248($t0)
		sw $zero, 504($t0)
		sw $zero, 760($t0)
		
		sw $zero, -12($t0)
		sw $zero, -268($t0)
		sw $zero, 244($t0)
		sw $zero, 500($t0)
		sw $zero, 756($t0)
		
		sw $zero, -16($t0)
		sw $zero, -272($t0)
		sw $zero, 240($t0)
		sw $zero, 496($t0)
		sw $zero, 752($t0)
		
		addi $s3, $s3, 1
		j return
		
diamond_right:	sw $zero, -256($t0)
		sw $zero, 256($t0)
		sw $zero, 512($t0)
		sw $zero, 768($t0)
		
		sw $zero, 4($t0)
		sw $zero, -252($t0)
		sw $zero, 260($t0)
		sw $zero, 516($t0)
		sw $zero, 772($t0)
		
		sw $zero, 8($t0)
		sw $zero, -248($t0)
		sw $zero, 264($t0)
		sw $zero, 520($t0)
		sw $zero, 776($t0)
		
		sw $zero, 12($t0)
		sw $zero, -244($t0)
		sw $zero, 268($t0)
		sw $zero, 524($t0)
		sw $zero, 780($t0)
		
		sw $zero, 16($t0)
		sw $zero, -240($t0)
		sw $zero, 272($t0)
		sw $zero, 528($t0)
		sw $zero, 784($t0)
		
		addi $s3, $s3, 1
		j return
		
diamond_below:	sw $zero, 4($t0)
		sw $zero, 8($t0)
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, -4($t0)
		sw $zero, -8($t0)
		sw $zero, -12($t0)
		sw $zero, -16($t0)
		
		sw $zero, -260($t0)
		sw $zero, -264($t0)
		sw $zero, -268($t0)
		sw $zero, -252($t0)
		sw $zero, -248($t0)
		sw $zero, -244($t0)
		
		sw $zero, 256($t0)
		sw $zero, 260($t0)
		sw $zero, 264($t0)
		sw $zero, 268($t0)
		sw $zero, 272($t0)
		sw $zero, 252($t0)
		sw $zero, 248($t0)
		sw $zero, 244($t0)
		sw $zero, 240($t0)
		
		sw $zero, 512($t0)
		sw $zero, 516($t0)
		sw $zero, 520($t0)
		sw $zero, 524($t0)
		sw $zero, 528($t0)
		sw $zero, 508($t0)
		sw $zero, 504($t0)
		sw $zero, 500($t0)
		sw $zero, 496($t0)
		
		sw $zero, 768($t0)
		sw $zero, 772($t0)
		sw $zero, 776($t0)
		sw $zero, 780($t0)
		sw $zero, 784($t0)
		sw $zero, 764($t0)
		sw $zero, 760($t0)
		sw $zero, 756($t0)
		sw $zero, 752($t0)
		
		addi $s3, $s3, 1
		j return

#########################################
# CHECK COLLISION WITH ENEMY
#########################################
check_collision:	lw $t0, 0($a0)
			addi $v0, $a1, 0
			li $v1, 0
			beq $a2, 1, original_color
			bgt $a2, 1, red_color
			lw $t2, 0($t0)	#unit 1
			bne $t2, PURPLE, collided
			lw $t0, 4($a0)	#unit 2
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 8($a0)	#unit 3
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 12($a0)	#unit 4
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 16($a0) #unit 5
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 20($a0) #unit 6
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 24($a0) #unit 7
			lw $t2, 0($t0)
			bne $t2, SKIN, collided
			lw $t0, 28($a0) #unit 8
			lw $t2, 0($t0)
			bne $t2, SKIN, collided
			lw $t0, 32($a0) #unit 9
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 36($a0) #unit 10
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 40($a0) #unit 11
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			lw $t0, 44($a0) #unit 12
			lw $t2, 0($t0)
			bne $t2, PURPLE, collided
			j return

collided:	li $a2, 10	#time for the wizard to stay red after collision
		addi $v0, $v0, -1	#health status decrease by one
		ble $v0, 0, return	#if health status is 0, return
		j red_color
		
original_color:		li $t9, PURPLE
			li $t8, SKIN
			lw $t2, 0($a0)	#unit 1
			sw $t9, 0($t2)
			lw $t2, 4($a0)	#unit 2
			sw $t9, 0($t2)
			lw $t2, 8($a0)	#unit 3
			sw $t9, 0($t2)
			lw $t2, 12($a0)	#unit 4
			sw $t9, 0($t2)
			lw $t2, 16($a0)	#unit 5
			sw $t9, 0($t2)
			lw $t2, 20($a0)	#unit 6
			sw $t9, 0($t2)
			lw $t2, 24($a0)	#unit 7
			sw $t8, 0($t2)
			lw $t2, 28($a0)	#unit 8
			sw $t8, 0($t2)
			lw $t2, 32($a0)	#unit 9
			sw $t9, 0($t2)
			lw $t2, 36($a0)	#unit 10
			sw $t9, 0($t2)
			lw $t2, 40($a0)	#unit 11
			sw $t9, 0($t2)
			lw $t2, 44($a0)	#unit 12
			sw $t9, 0($t2)
			addi $v1, $a2, -1
			j return
			 
red_color:	li $t9, RED
		lw $t2, 0($a0)	#unit 1
		sw $t9, 0($t2)
		lw $t2, 4($a0)	#unit 2
		sw $t9, 0($t2)
		lw $t2, 8($a0)	#unit 3
		sw $t9, 0($t2)
		lw $t2, 12($a0)	#unit 4
		sw $t9, 0($t2)
		lw $t2, 16($a0)	#unit 5
		sw $t9, 0($t2)
		lw $t2, 20($a0)	#unit 6
		sw $t9, 0($t2)
		lw $t2, 24($a0)	#unit 7
		sw $t9, 0($t2)
		lw $t2, 28($a0)	#unit 8
		sw $t9, 0($t2)
		lw $t2, 32($a0)	#unit 9
		sw $t9, 0($t2)
		lw $t2, 36($a0)	#unit 10
		sw $t9, 0($t2)
		lw $t2, 40($a0)	#unit 11
		sw $t9, 0($t2)
		lw $t2, 44($a0)	#unit 12
		sw $t9, 0($t2)
		addi $v1, $a2, -1
		j return


#########################################
# UPDATE HEALTH STATUS
#########################################	
update_health:	li $t0, BASE_ADDRESS
		beq $a0, 3, three_lives
		beq $a0, 2, two_lives
		beq $a0, 1, one_life
		
		sw $zero, 15552($t0)
		sw $zero, 15560($t0)
		sw $zero, 15804($t0) 
		sw $zero, 15808($t0)
		sw $zero, 15812($t0)
		sw $zero, 15816($t0)
		sw $zero, 15820($t0)
		sw $zero, 16064($t0)
		sw $zero, 16068($t0)
		sw $zero, 16072($t0)
		sw $zero, 16324($t0)
		j return
		  
        
one_life:   	sw $zero, 15576($t0)
		sw $zero, 15584($t0)
		sw $zero, 15828($t0)
		sw $zero, 15832($t0)
		sw $zero, 15836($t0)
		sw $zero, 15840($t0)
		sw $zero, 15844($t0)
		sw $zero, 16088($t0)
		sw $zero, 16092($t0)
		sw $zero, 16096($t0)
		sw $zero, 16348($t0)
		j return
        
two_lives:	sw $zero, 15600($t0) 
		sw $zero, 15608($t0)
		sw $zero, 15852($t0)
		sw $zero, 15856($t0)
		sw $zero, 15860($t0)
		sw $zero, 15864($t0)
		sw $zero, 15868($t0)
		sw $zero, 16112($t0)
		sw $zero, 16116($t0)
		sw $zero, 16120($t0)
		sw $zero, 16372($t0)
        
three_lives:   	j return

##################################################
# FUNCTIONS (MOSTLY FOR DISPLAYING AND COLORING)
##################################################
return: 	jr $ra

next_level:	beq $s1, 1, level_two		#branch the next level / WIN according to current level
		beq $s1, 2, level_three
		beq $s1, 3, win

Ini_Wizard:	la $t4, wizard		#initializing the address of wizard
		li $t0, PURPLE
		li $t1, SKIN
		addi $t5, $gp, 13952
		sw $t5, 0($t4) #unit 1
		addi $t5, $gp, 13956
		sw $t5, 4($t4) #unit 2
		addi $t5, $gp, 14204
		sw $t5, 8($t4) #unit 3
		addi $t5, $gp, 14208
		sw $t5, 12($t4) #unit 4
		addi $t5, $gp, 14212
		sw $t5, 16($t4) #unit 5
		addi $t5, $gp, 14216
		sw $t5, 20($t4) #unit 6
		addi $t5, $gp, 14464
		sw $t5, 24($t4) #unit 7
		addi $t5, $gp, 14468
		sw $t5, 28($t4) #unit 8
		addi $t5, $gp, 14720
		sw $t5, 32($t4) #unit 9
		addi $t5, $gp, 14724
		sw $t5, 36($t4) #unit 10
		addi $t5, $gp, 14976
		sw $t5, 40($t4) #unit 11
		addi $t5, $gp, 14980
		sw $t5, 44($t4) #unit 12
		
		lw $t2, 0($t4)
		sw $t0, 0($t2)
		lw $t2, 4($t4)
		sw $t0, 0($t2)
		lw $t2, 8($t4)
		sw $t0, 0($t2)
		lw $t2, 12($t4)
		sw $t0, 0($t2)
		lw $t2, 16($t4)
		sw $t0, 0($t2)
		lw $t2, 20($t4)
		sw $t0, 0($t2)
		lw $t2, 24($t4)
		sw $t1, 0($t2)
		lw $t2, 28($t4)
		sw $t1, 0($t2)
		lw $t2, 32($t4)
		sw $t0, 0($t2)
		lw $t2, 36($t4)
		sw $t0, 0($t2)
		lw $t2, 40($t4)
		sw $t0, 0($t2)
		lw $t2, 44($t4)
		sw $t0, 0($t2)
		j return
		
draw_life:	li $t0, BASE_ADDRESS
		li $t1, PINK
		sw $t1, 15552($t0)
		sw $t1, 15560($t0) ##
		sw $t1, 15576($t0)
		sw $t1, 15584($t0) ##
		sw $t1, 15600($t0) 
		sw $t1, 15608($t0) ##
		sw $t1, 15804($t0) 
		sw $t1, 15808($t0)
		sw $t1, 15812($t0)
		sw $t1, 15816($t0)
		sw $t1, 15820($t0) ##
		sw $t1, 15828($t0)
		sw $t1, 15832($t0)
		sw $t1, 15836($t0)
		sw $t1, 15840($t0)
		sw $t1, 15844($t0) ##
		sw $t1, 15852($t0)
		sw $t1, 15856($t0)
		sw $t1, 15860($t0)
		sw $t1, 15864($t0)
		sw $t1, 15868($t0) ##
		sw $t1, 16064($t0)
		sw $t1, 16068($t0)
		sw $t1, 16072($t0) ##
		sw $t1, 16088($t0)
		sw $t1, 16092($t0)
		sw $t1, 16096($t0) ##
		sw $t1, 16112($t0)
		sw $t1, 16116($t0)
		sw $t1, 16120($t0) ##
		sw $t1, 16324($t0)
		sw $t1, 16348($t0)
		sw $t1, 16372($t0)
		j return	

color:	 	beq $t0, $t3, return	
		sw $t1, 0($t0)		# paint the unit. 
		add $t0, $t0, $t2	# increment $t0
		j color			# loop back
		
game_1_coin: 	li $t0, BASE_ADDRESS	#coin location for game 1
		li $t1, GOLDEN_YELLOW
		li $t2, YELLOW
		
		sw $t2, 12104($t0)
		sw $t1, 12108($t0)
		sw $t1, 11848($t0)
		sw $t2, 11852($t0)
		
		sw $t2, 12124($t0)
		sw $t1, 12128($t0)
		sw $t1, 11868($t0)
		sw $t2, 11872($t0)
		
		sw $t2, 12144($t0)
		sw $t1, 12148($t0)
		sw $t1, 11888($t0)
		sw $t2, 11892($t0)
		
		sw $t2, 12164($t0)
		sw $t1, 12168($t0)
		sw $t1, 11908($t0)
		sw $t2, 11912($t0)
		
		sw $t2, 12184($t0)
		sw $t1, 12188($t0)
		sw $t1, 11928($t0)
		sw $t2, 11932($t0)
		
		sw $t2, 12204($t0)
		sw $t1, 12208($t0)
		sw $t1, 11948($t0)
		sw $t2, 11952($t0)
		
		j return
		
game_1_diamond:	li $t0, BASE_ADDRESS	#diamond location for game 1
		li $t1, LIGHT_BLUE
		li $t2, DARK_BLUE
		li $t3, BLUE
		sw $t1, 1144($t0)
		sw $t3, 1148($t0)
		sw $t2, 1152($t0)
		sw $t1, 1396($t0)
		sw $t1, 1400($t0)
		sw $t3, 1404($t0)
		sw $t2, 1408($t0)
		sw $t2, 1412($t0)
		sw $t1, 1656($t0)
		sw $t3, 1660($t0)
		sw $t2, 1664($t0)
		sw $t2, 1916($t0)
		
		sw $t1, 6264($t0)
		sw $t3, 6268($t0)
		sw $t2, 6272($t0)
		sw $t1, 6516($t0)
		sw $t1, 6520($t0)
		sw $t3, 6524($t0)
		sw $t2, 6528($t0)
		sw $t2, 6532($t0)
		sw $t1, 6776($t0)
		sw $t3, 6780($t0)
		sw $t2, 6784($t0)
		sw $t2, 7036($t0)
		j return
		
game_1_enemy:	li $t0, BASE_ADDRESS	#enemy location for game 1
		li $t1, GRAY
		li $t2, DARK_GRAY
		la $t4, game1_enemy1
		sw $t1, 1216($t0)
		sw $t2, 1464($t0)
		sw $t1, 1468($t0)
		sw $t1, 1472($t0)
		sw $t1, 1476($t0)
		sw $t2, 1480($t0)
		sw $t2, 1720($t0)
		sw $t1, 1724($t0)
		sw $t1, 1728($t0)
		sw $t1, 1732($t0)
		sw $t2, 1736($t0)
		sw $t2, 1976($t0)
		sw $t1, 1980($t0)
		sw $t1, 1984($t0)
		sw $t1, 1988($t0)
		sw $t2, 1992($t0)
		sw $t1, 2236($t0)
		sw $t1, 2244($t0)
		addi $t5, $gp, 1216
		sw $t5, 4($t4) #unit 1
		addi $t5, $gp, 1464
		sw $t5, 8($t4) #unit 2
		addi $t5, $gp, 1468
		sw $t5, 12($t4) #unit 3
		addi $t5, $gp, 1472
		sw $t5, 16($t4) #unit 4
		addi $t5, $gp, 1476
		sw $t5, 20($t4) #unit 5
		addi $t5, $gp, 1480
		sw $t5, 24($t4) #unit 6
		addi $t5, $gp, 1720
		sw $t5, 28($t4) #unit 7
		addi $t5, $gp, 1724
		sw $t5, 32($t4) #unit 8
		addi $t5, $gp, 1728
		sw $t5, 36($t4) #unit 9
		addi $t5, $gp, 1732
		sw $t5, 40($t4) #unit 10
		addi $t5, $gp, 1736
		sw $t5, 44($t4) #unit 11
		addi $t5, $gp, 1976
		sw $t5, 48($t4) #unit 12
		addi $t5, $gp, 1980
		sw $t5, 52($t4) #unit 13
		addi $t5, $gp, 1984
		sw $t5, 56($t4) #unit 14
		addi $t5, $gp, 1988
		sw $t5, 60($t4) #unit 15
		addi $t5, $gp, 1992
		sw $t5, 64($t4) #unit 16
		addi $t5, $gp, 2236
		sw $t5, 68($t4) #unit 17
		addi $t5, $gp, 2244
		sw $t5, 72($t4) #unit 18
		
		la $t4, game1_enemy2
		sw $t1, 6204($t0)
		sw $t2, 6452($t0)
		sw $t1, 6456($t0)
		sw $t1, 6460($t0)
		sw $t1, 6464($t0)
		sw $t2, 6468($t0)
		sw $t2, 6708($t0)
		sw $t1, 6712($t0)
		sw $t1, 6716($t0)
		sw $t1, 6720($t0)
		sw $t2, 6724($t0)
		sw $t2, 6964($t0)
		sw $t1, 6968($t0)
		sw $t1, 6972($t0)
		sw $t1, 6976($t0)
		sw $t2, 6980($t0)
		sw $t1, 7224($t0)
		sw $t1, 7232($t0)
		addi $t5, $gp, 6204
		sw $t5, 4($t4) #unit 1
		addi $t5, $gp, 6452
		sw $t5, 8($t4) #unit 2
		addi $t5, $gp, 6456
		sw $t5, 12($t4) #unit 3
		addi $t5, $gp, 6460
		sw $t5, 16($t4) #unit 4
		addi $t5, $gp, 6464
		sw $t5, 20($t4) #unit 5
		addi $t5, $gp, 6468
		sw $t5, 24($t4) #unit 6
		addi $t5, $gp, 6708
		sw $t5, 28($t4) #unit 7
		addi $t5, $gp, 6712
		sw $t5, 32($t4) #unit 8
		addi $t5, $gp, 6716
		sw $t5, 36($t4) #unit 9
		addi $t5, $gp, 6720
		sw $t5, 40($t4) #unit 10
		addi $t5, $gp, 6724
		sw $t5, 44($t4) #unit 11
		addi $t5, $gp, 6964
		sw $t5, 48($t4) #unit 12
		addi $t5, $gp, 6968
		sw $t5, 52($t4) #unit 13
		addi $t5, $gp, 6972
		sw $t5, 56($t4) #unit 14
		addi $t5, $gp, 6976
		sw $t5, 60($t4) #unit 15
		addi $t5, $gp, 6980
		sw $t5, 64($t4) #unit 16
		addi $t5, $gp, 7224
		sw $t5, 68($t4) #unit 17
		addi $t5, $gp, 7232
		sw $t5, 72($t4) #unit 18
		
		j return
		
game_2_coin:	li $t0, BASE_ADDRESS	#coin location for game 2
		li $t1, GOLDEN_YELLOW
		li $t2, YELLOW
		
		sw $t1, 3856($t0)
		sw $t2, 3860($t0)
		sw $t2, 4112($t0)
		sw $t1, 4116($t0)
		
		sw $t1, 3964($t0)
		sw $t2, 3968($t0)
		sw $t2, 4220($t0)
		sw $t1, 4224($t0)
		
		sw $t1, 4072($t0)
		sw $t2, 4076($t0)
		sw $t2, 4328($t0)
		sw $t1, 4332($t0)
		
		sw $t1, 11588($t0)
		sw $t2, 11592($t0)
		sw $t2, 11844($t0)
		sw $t1, 11848($t0)
		
		sw $t1, 11700($t0)
		sw $t2, 11704($t0)
		sw $t2, 11956($t0)
		sw $t1, 11960($t0)
		
		j return 
		
game_2_diamond:	li $t0, BASE_ADDRESS	#diamond location for game 2
		li $t1, LIGHT_BLUE
		li $t2, DARK_BLUE
		li $t3, BLUE
		sw $t1, 1092($t0)
		sw $t3, 1096($t0)
		sw $t2, 1100($t0)
		sw $t1, 1344($t0)
		sw $t1, 1348($t0)
		sw $t3, 1352($t0)
		sw $t2, 1356($t0)
		sw $t2, 1360($t0)
		sw $t1, 1604($t0)
		sw $t3, 1608($t0)
		sw $t2, 1612($t0)
		sw $t2, 1864($t0)
		
		sw $t1, 1204($t0)
		sw $t3, 1208($t0)
		sw $t2, 1212($t0)
		sw $t1, 1456($t0)
		sw $t1, 1460($t0)
		sw $t3, 1464($t0)
		sw $t2, 1468($t0)
		sw $t2, 1472($t0)
		sw $t1, 1716($t0)
		sw $t3, 1720($t0)
		sw $t2, 1724($t0)
		sw $t2, 1976($t0)
		
		sw $t1, 6012($t0)
		sw $t3, 6016($t0)
		sw $t2, 6020($t0)
		sw $t1, 6264($t0)
		sw $t1, 6268($t0)
		sw $t3, 6272($t0)
		sw $t2, 6276($t0)
		sw $t2, 6280($t0)
		sw $t1, 6524($t0)
		sw $t3, 6528($t0)
		sw $t2, 6532($t0)
		sw $t2, 6784($t0)
		
		j return
		
game_2_enemy:	li $t0, BASE_ADDRESS	#enemy location for game 2
		li $t1, GREEN
		li $t2, ORANGE
		la $t4, game2_enemy1
		sw $t1, 768($t0)
		sw $t1, 772($t0)
		sw $t1, 792($t0)
		sw $t1, 796($t0)
		sw $t2, 1032($t0)
		sw $t2, 1036($t0)
		sw $t2, 1040($t0)
		sw $t2, 1044($t0)
		sw $t2, 1288($t0)
		sw $t2, 1300($t0)
		sw $t2, 1544($t0)
		sw $t2, 1556($t0)
		addi $t5, $zero, 1
		sw $t5, 0($t4)
		addi $t5, $gp, 768
		sw $t5, 4($t4) #unit 1
		addi $t5, $gp, 772
		sw $t5, 8($t4) #unit 2
		addi $t5, $gp, 792
		sw $t5, 12($t4) #unit 3
		addi $t5, $gp, 796
		sw $t5, 16($t4) #unit 4
		addi $t5, $gp, 1032
		sw $t5, 20($t4) #unit 5
		addi $t5, $gp, 1036
		sw $t5, 24($t4) #unit 6
		addi $t5, $gp, 1040
		sw $t5, 28($t4) #unit 7
		addi $t5, $gp, 1044
		sw $t5, 32($t4) #unit 8
		addi $t5, $gp, 1288
		sw $t5, 36($t4) #unit 9
		addi $t5, $gp, 1300
		sw $t5, 40($t4) #unit 10
		addi $t5, $gp, 1544
		sw $t5, 44($t4) #unit 11
		addi $t5, $gp, 1556
		sw $t5, 48($t4) #unit 12
		
		
		li $t1, GRAY
		li $t2, DARK_GRAY
		la $t4, game2_enemy2
		sw $t1, 5944($t0)
		sw $t2, 6192($t0)
		sw $t1, 6196($t0)
		sw $t1, 6200($t0)
		sw $t1, 6204($t0)
		sw $t2, 6208($t0)
		sw $t2, 6448($t0)
		sw $t1, 6452($t0)
		sw $t1, 6456($t0)
		sw $t1, 6460($t0)
		sw $t2, 6464($t0)
		sw $t2, 6704($t0)
		sw $t1, 6708($t0)
		sw $t1, 6712($t0)
		sw $t1, 6716($t0)
		sw $t2, 6720($t0)
		sw $t1, 6964($t0)
		sw $t1, 6972($t0)
		li $t5, 1
		sw $t5, 0($t4) 
		addi $t5, $gp, 5944
		sw $t5, 4($t4) #unit 1
		addi $t5, $gp, 6192
		sw $t5, 8($t4) #unit 2
		addi $t5, $gp, 6196
		sw $t5, 12($t4) #unit 3
		addi $t5, $gp, 6200
		sw $t5, 16($t4) #unit 4
		addi $t5, $gp, 6204
		sw $t5, 20($t4) #unit 5
		addi $t5, $gp, 6208
		sw $t5, 24($t4) #unit 6
		addi $t5, $gp, 6448
		sw $t5, 28($t4) #unit 7
		addi $t5, $gp, 6452
		sw $t5, 32($t4) #unit 8
		addi $t5, $gp, 6456
		sw $t5, 36($t4) #unit 9
		addi $t5, $gp, 6460
		sw $t5, 40($t4) #unit 10
		addi $t5, $gp, 6464
		sw $t5, 44($t4) #unit 11
		addi $t5, $gp, 6704
		sw $t5, 48($t4) #unit 12
		addi $t5, $gp, 6708
		sw $t5, 52($t4) #unit 13
		addi $t5, $gp, 6712
		sw $t5, 56($t4) #unit 14
		addi $t5, $gp, 6716
		sw $t5, 60($t4) #unit 15
		addi $t5, $gp, 6720
		sw $t5, 64($t4) #unit 16
		addi $t5, $gp, 6964
		sw $t5, 68($t4) #unit 17
		addi $t5, $gp, 6972
		sw $t5, 72($t4) #unit 18
		
		li $t1, GREEN
		li $t2, ORANGE
		la $t4, game2_enemy3
		sw $t1, 8404($t0)
		sw $t1, 8408($t0)
		sw $t1, 8428($t0)
		sw $t1, 8432($t0)
		sw $t2, 8668($t0)
		sw $t2, 8672($t0)
		sw $t2, 8676($t0)
		sw $t2, 8680($t0)
		sw $t2, 8924($t0)
		sw $t2, 8936($t0)
		sw $t2, 9180($t0)
		sw $t2, 9192($t0)
		addi $t5, $zero, 1
		sw $t5, 0($t4)
		addi $t5, $gp, 8404
		sw $t5, 4($t4) #unit 1
		addi $t5, $gp, 8408
		sw $t5, 8($t4) #unit 2
		addi $t5, $gp, 8428
		sw $t5, 12($t4) #unit 3
		addi $t5, $gp, 8432
		sw $t5, 16($t4) #unit 4
		addi $t5, $gp, 8668
		sw $t5, 20($t4) #unit 5
		addi $t5, $gp, 8672
		sw $t5, 24($t4) #unit 6
		addi $t5, $gp, 8676
		sw $t5, 28($t4) #unit 7
		addi $t5, $gp, 8680
		sw $t5, 32($t4) #unit 8
		addi $t5, $gp, 8924
		sw $t5, 36($t4) #unit 9
		addi $t5, $gp, 8936
		sw $t5, 40($t4) #unit 10
		addi $t5, $gp, 9180
		sw $t5, 44($t4) #unit 11
		addi $t5, $gp, 9192
		sw $t5, 48($t4) #unit 12
		j return
		
game_3_diamond:	li $t0, BASE_ADDRESS	#diamond location for game 3
		li $t1, LIGHT_BLUE
		li $t2, DARK_BLUE
		li $t3, BLUE
		sw $t1, 780($t0)
		sw $t3, 784($t0)
		sw $t2, 788($t0)
		sw $t1, 1032($t0)
		sw $t1, 1036($t0)
		sw $t3, 1040($t0)
		sw $t2, 1044($t0)
		sw $t2, 1048($t0)
		sw $t1, 1292($t0)
		sw $t3, 1296($t0)
		sw $t2, 1300($t0)
		sw $t2, 1552($t0)
		j return 
		
game_3_enemy: 	li $t1, ROSE_RED	#enemy location for game 3
		li $t2, GRAY
		li $t3, BROWN
		sw $t1, 3392($gp)
		sw $t1, 3644($gp)
		sw $t1, 3648($gp)
		sw $t1, 3652($gp)
		sw $t1, 3904($gp)
		sw $t1, 3392($gp)
		sw $t1, 4156($gp)
		sw $t1, 4164($gp)
		
		sw $t2, 3404($gp)
		sw $t2, 3408($gp)
		sw $t2, 3412($gp)
		sw $t2, 3416($gp)
		sw $t2, 3420($gp)
		sw $t2, 3660($gp)
		sw $t2, 3664($gp)
		sw $t2, 3668($gp)
		sw $t2, 3672($gp)
		sw $t2, 3676($gp)
		
		sw $t3, 3920($gp)
		sw $t3, 3924($gp)
		sw $t3, 4172($gp)
		sw $t3, 4176($gp)
		sw $t3, 4180($gp)
		sw $t3, 4184($gp)
		
		#enemy 2
		sw $t1, 6388($gp)
		sw $t1, 6640($gp)
		sw $t1, 6644($gp)
		sw $t1, 6648($gp)
		sw $t1, 6900($gp)
		sw $t1, 7152($gp)
		sw $t1, 7160($gp)
		
		sw $t2, 6376($gp)
		sw $t2, 6372($gp)
		sw $t2, 6368($gp)
		sw $t2, 6364($gp)
		sw $t2, 6360($gp)
		sw $t2, 6632($gp)
		sw $t2, 6628($gp)
		sw $t2, 6624($gp)
		sw $t2, 6620($gp)
		sw $t2, 6616($gp)
		
		sw $t3, 6884($gp)
		sw $t3, 6880($gp)
		sw $t3, 7136($gp)
		sw $t3, 7140($gp)
		sw $t3, 7144($gp)
		sw $t3, 7132($gp)
		
		#Enemy 3:
		sw $t1, 8968($gp)
		sw $t1, 9220($gp)
		sw $t1, 9224($gp)
		sw $t1, 9228($gp)
		sw $t1, 9480($gp)
		sw $t1, 9732($gp)
		sw $t1, 9740($gp)
		
		sw $t2, 8980($gp)
		sw $t2, 8984($gp)
		sw $t2, 8988($gp)
		sw $t2, 8992($gp)
		sw $t2, 8996($gp)
		sw $t2, 9236($gp)
		sw $t2, 9240($gp)
		sw $t2, 9244($gp)
		sw $t2, 9248($gp)
		sw $t2, 9252($gp)
		
		sw $t3, 9500($gp)
		sw $t3, 9496($gp)
		sw $t3, 9752($gp)
		sw $t3, 9756($gp)
		sw $t3, 9760($gp)
		sw $t3, 9748($gp)
		
		#Enemy 4:
		sw $t1, 12020($gp)
		sw $t1, 12272($gp)
		sw $t1, 12276($gp)
		sw $t1, 12280($gp)
		sw $t1, 12532($gp)
		sw $t1, 12784($gp)
		sw $t1, 12792($gp)
		
		sw $t2, 12008($gp)
		sw $t2, 12004($gp)
		sw $t2, 12000($gp)
		sw $t2, 11996($gp)
		sw $t2, 11992($gp)
		sw $t2, 12264($gp)
		sw $t2, 12260($gp)
		sw $t2, 12256($gp)
		sw $t2, 12252($gp)
		sw $t2, 12248($gp)
		
		sw $t3, 12516($gp)
		sw $t3, 12512($gp)
		sw $t3, 12776($gp)
		sw $t3, 12772($gp)
		sw $t3, 12768($gp)
		sw $t3, 12764($gp)
		j return
		
game_3_coin:	li $t0, BASE_ADDRESS	#coin location for game 3
		li $t1, GOLDEN_YELLOW
		li $t2, YELLOW
		
		sw $t2, 2620($t0)
		sw $t1, 2624($t0)
		sw $t1, 2876($t0)
		sw $t2, 2880($t0)
		
		j return
		
game_3_moving_enemy:	li $t1, GREEN	#location of the moving enemy in game three
			li $t2, ORANGE
			sw $t1, 1328($gp)
			sw $t1, 1332($gp)
			sw $t1, 1352($gp)
			sw $t1, 1356($gp)
			sw $t2, 1592($gp)
			sw $t2, 1596($gp)
			sw $t2, 1600($gp)
			sw $t2, 1604($gp)
			sw $t2, 1848($gp)
			sw $t2, 1860($gp)
			sw $t2, 2104($gp)
			sw $t2, 2116($gp)
			
			la $t4, game3_enemy1
			addi $t5, $zero, 1
			sw $t5, 0($t4)
			addi $t5, $gp, 1328
			sw $t5, 4($t4) #unit 1
			addi $t5, $gp, 1332
			sw $t5, 8($t4) #unit 2
			addi $t5, $gp, 1352
			sw $t5, 12($t4) #unit 3
			addi $t5, $gp, 1356
			sw $t5, 16($t4) #unit 4
			addi $t5, $gp, 1592
			sw $t5, 20($t4) #unit 5
			addi $t5, $gp, 1596
			sw $t5, 24($t4) #unit 6
			addi $t5, $gp, 1600
			sw $t5, 28($t4) #unit 7
			addi $t5, $gp, 1604
			sw $t5, 32($t4) #unit 8
			addi $t5, $gp, 1848
			sw $t5, 36($t4) #unit 9
			addi $t5, $gp, 1860
			sw $t5, 40($t4) #unit 10
			addi $t5, $gp, 2104
			sw $t5, 44($t4) #unit 11
			addi $t5, $gp, 2116
			sw $t5, 48($t4) #unit 12
			j return

print_level:	# Draw L
		li $t0, BASE_ADDRESS
		li $t1, YELLOW
		addi $t2, $t0, 3872
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		sw $t1, 1024($t2)
		sw $t1, 1028($t2)
		sw $t1, 1280($t2)
		sw $t1, 1284($t2)
		sw $t1, 1536($t2)
		sw $t1, 1540($t2)
		sw $t1, 1792($t2)
		sw $t1, 1796($t2)
		sw $t1, 2048($t2)
		sw $t1, 2052($t2)
		
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		
		# Draw E
		addi $t2, $t0, 3912
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		sw $t1, 20($t2)
		sw $t1, 24($t2)
		sw $t1, 28($t2)
		
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 272($t2)
		sw $t1, 276($t2)
		sw $t1, 280($t2)
		sw $t1, 284($t2)
		
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		
		sw $t1, 1024($t2)
		sw $t1, 1028($t2)
		sw $t1, 1032($t2)
		sw $t1, 1036($t2)
		sw $t1, 1040($t2)
		sw $t1, 1044($t2)
		sw $t1, 1048($t2)
		sw $t1, 1052($t2)
		
        	sw $t1, 1280($t2)
        	sw $t1, 1284($t2)
        	sw $t1, 1288($t2)
        	sw $t1, 1292($t2)
        	sw $t1, 1296($t2)
        	sw $t1, 1300($t2)
        	sw $t1, 1304($t2)
        	sw $t1, 1308($t2)
        	
        	sw $t1, 1536($t2)
		sw $t1, 1540($t2)
		sw $t1, 1792($t2)
		sw $t1, 1796($t2)
		sw $t1, 2048($t2)
		sw $t1, 2052($t2)
		
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		
		# Draw V
		addi $t2, $t0, 3952
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 36($t2)
		sw $t1, 40($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 292($t2)
		sw $t1, 296($t2)
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 548($t2)
		sw $t1, 552($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		sw $t1, 804($t2)
		sw $t1, 808($t2)
		sw $t1, 1032($t2)
		sw $t1, 1036($t2)
		sw $t1, 1052($t2)
		sw $t1, 1056($t2)
		sw $t1, 1288($t2)
		sw $t1, 1292($t2)
		sw $t1, 1308($t2)
		sw $t1, 1312($t2)
		sw $t1, 1544($t2)
		sw $t1, 1548($t2)
		sw $t1, 1564($t2)
		sw $t1, 1568($t2)
		sw $t1, 1800($t2)
		sw $t1, 1804($t2)
		sw $t1, 1820($t2)
		sw $t1, 1824($t2)
		sw $t1, 2064($t2)
		sw $t1, 2068($t2)
		sw $t1, 2072($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		
		# Draw E
		addi $t2, $t0, 4004
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		sw $t1, 20($t2)
		sw $t1, 24($t2)
		sw $t1, 28($t2)
		
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 272($t2)
		sw $t1, 276($t2)
		sw $t1, 280($t2)
		sw $t1, 284($t2)
		
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		
		sw $t1, 1024($t2)
		sw $t1, 1028($t2)
		sw $t1, 1032($t2)
		sw $t1, 1036($t2)
		sw $t1, 1040($t2)
		sw $t1, 1044($t2)
		sw $t1, 1048($t2)
		sw $t1, 1052($t2)
		
        	sw $t1, 1280($t2)
        	sw $t1, 1284($t2)
        	sw $t1, 1288($t2)
        	sw $t1, 1292($t2)
        	sw $t1, 1296($t2)
        	sw $t1, 1300($t2)
        	sw $t1, 1304($t2)
        	sw $t1, 1308($t2)
        	
        	sw $t1, 1536($t2)
		sw $t1, 1540($t2)
		sw $t1, 1792($t2)
		sw $t1, 1796($t2)
		sw $t1, 2048($t2)
		sw $t1, 2052($t2)
		
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		
		# Draw L
		addi $t2, $t0, 4044
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		sw $t1, 1024($t2)
		sw $t1, 1028($t2)
		sw $t1, 1280($t2)
		sw $t1, 1284($t2)
		sw $t1, 1536($t2)
		sw $t1, 1540($t2)
		sw $t1, 1792($t2)
		sw $t1, 1796($t2)
		sw $t1, 2048($t2)
		sw $t1, 2052($t2)
		
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		j return

print_one:	addi $t2, $t0, 7548
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 520($t2)
		sw $t1, 524($t2)
		sw $t1, 776($t2)
		sw $t1, 780($t2)
		sw $t1, 1032($t2)
		sw $t1, 1036($t2)
		sw $t1, 1288($t2)
		sw $t1, 1292($t2)
		sw $t1, 1544($t2)
		sw $t1, 1548($t2)
		sw $t1, 1800($t2)
		sw $t1, 1804($t2)
		sw $t1, 2056($t2)
		sw $t1, 2060($t2)
		sw $t1, 2300($t2)
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2556($t2)
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		j return

print_two:	addi $t2, $t0, 7544
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 272($t2)
		
		sw $t1, 252($t2)
		sw $t1, 508($t2)
		sw $t1, 512($t2)
		sw $t1, 760($t2)
		sw $t1, 764($t2)
		sw $t1, 1016($t2)
		sw $t1, 1020($t2)
		
		sw $t1, 276($t2)
		sw $t1, 528($t2)
		sw $t1, 532($t2)
		sw $t1, 536($t2)
		sw $t1, 788($t2)
		sw $t1, 792($t2)
		sw $t1, 796($t2)
		sw $t1, 1048($t2)
		sw $t1, 1052($t2)
		sw $t1, 1304($t2)
		sw $t1, 1308($t2)
		sw $t1, 1556($t2)
		sw $t1, 1560($t2)
		sw $t1, 1564($t2)
		sw $t1, 1812($t2)
		sw $t1, 1816($t2)
		sw $t1, 2064($t2)
		sw $t1, 2068($t2)
		sw $t1, 2072($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2820($t2)
		sw $t1, 2824($t2)
		sw $t1, 2828($t2)
		sw $t1, 3072($t2)
		sw $t1, 3076($t2)
		sw $t1, 3080($t2)
		sw $t1, 3328($t2)
		sw $t1, 3332($t2)
		
		sw $t1, 3580($t2)
		sw $t1, 3584($t2)
		sw $t1, 3588($t2)
		sw $t1, 3592($t2)
		sw $t1, 3596($t2)
		sw $t1, 3600($t2)
		sw $t1, 3604($t2)
		sw $t1, 3608($t2)
		sw $t1, 3612($t2)
		sw $t1, 3616($t2)
		
		sw $t1, 3836($t2)
		sw $t1, 3840($t2)
		sw $t1, 3844($t2)
		sw $t1, 3848($t2)
		sw $t1, 3852($t2)
		sw $t1, 3856($t2)
		sw $t1, 3860($t2)
		sw $t1, 3864($t2)
		sw $t1, 3868($t2)
		sw $t1, 3872($t2)
		
		j return

print_three:	addi $t2, $t0, 7548
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 272($t2)
		
		sw $t1, 512($t2)
		sw $t1, 508($t2)
		sw $t1, 504($t2)
		sw $t1, 760($t2)
		sw $t1, 764($t2)
		sw $t1, 768($t2)
		
		sw $t1, 528($t2)
		sw $t1, 532($t2)
		sw $t1, 536($t2)
		sw $t1, 784($t2)
		sw $t1, 788($t2)
		sw $t1, 792($t2)
		
		sw $t1, 1044($t2)
		sw $t1, 1048($t2)
		sw $t1, 1052($t2)
		sw $t1, 1300($t2)
		sw $t1, 1304($t2)
		sw $t1, 1308($t2)
		
		sw $t1, 1556($t2)
		sw $t1, 1552($t2)
		sw $t1, 1548($t2)
		sw $t1, 1812($t2)
		sw $t1, 1808($t2)
		sw $t1, 1804($t2)
		
		sw $t1, 2068($t2)
		sw $t1, 2072($t2)
		sw $t1, 2076($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		sw $t1, 2836($t2)
		sw $t1, 2840($t2)
		sw $t1, 2844($t2)
		
		sw $t1, 3092($t2)
		sw $t1, 3088($t2)
		sw $t1, 3084($t2)
		sw $t1, 3080($t2)
		sw $t1, 3076($t2)
		sw $t1, 3072($t2)
		
		sw $t1, 3348($t2)
		sw $t1, 3344($t2)
		sw $t1, 3340($t2)
		sw $t1, 3336($t2)
		sw $t1, 3332($t2)
		sw $t1, 3328($t2)
		
		sw $t1, 2560($t2)
		sw $t1, 2556($t2)
		sw $t1, 2552($t2)
		sw $t1, 2816($t2)
		sw $t1, 2812($t2)
		sw $t1, 2808($t2)
		j return
		
fail:		li $t0, BASE_ADDRESS
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color
		
		li $t0, BASE_ADDRESS
		li $t1, YELLOW
		#####print G
		addi $t2, $t0, 3112
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		sw $t1, 20($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 268($t2)
		sw $t1, 272($t2)
		sw $t1, 276($t2)
		sw $t1, 532($t2)
		sw $t1, 536($t2)
		sw $t1, 540($t2)
		sw $t1, 788($t2)
		sw $t1, 792($t2)
		sw $t1, 796($t2)
		sw $t1, 504($t2)
		sw $t1, 508($t2)
		sw $t1, 512($t2)
		sw $t1, 760($t2)
		sw $t1, 764($t2)
		sw $t1, 768($t2)
		sw $t1, 1016($t2)
		sw $t1, 1020($t2)
		sw $t1, 1024($t2)
		sw $t1, 1272($t2)
		sw $t1, 1276($t2)
		sw $t1, 1280($t2)
		sw $t1, 1528($t2)
		sw $t1, 1532($t2)
		sw $t1, 1536($t2)
		sw $t1, 1784($t2)
		sw $t1, 1788($t2)
		sw $t1, 1792($t2)
		sw $t1, 2040($t2)
		sw $t1, 2044($t2)
		sw $t1, 2048($t2)
		sw $t1, 2296($t2)
		sw $t1, 2300($t2)
		sw $t1, 2304($t2)
		sw $t1, 2552($t2)
		sw $t1, 2556($t2)
		sw $t1, 2560($t2)
		sw $t1, 2808($t2)
		sw $t1, 2812($t2)
		sw $t1, 2816($t2)
		sw $t1, 3072($t2)
		sw $t1, 3076($t2)
		sw $t1, 3080($t2)
		sw $t1, 3084($t2)
		sw $t1, 3088($t2)
		sw $t1, 3092($t2)
		sw $t1, 3328($t2)
		sw $t1, 3332($t2)
		sw $t1, 3336($t2)
		sw $t1, 3340($t2)
		sw $t1, 3344($t2)
		sw $t1, 3348($t2)
		sw $t1, 2836($t2)
		sw $t1, 2840($t2)
		sw $t1, 2844($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		sw $t1, 2068($t2)
		sw $t1, 2064($t2)
		sw $t1, 2060($t2)
		sw $t1, 2324($t2)
		sw $t1, 2320($t2)
		sw $t1, 2316($t2)
		
		#####print A
		sw $t1, 56($t2)
		sw $t1, 60($t2)
		sw $t1, 64($t2)
		sw $t1, 312($t2)
		sw $t1, 316($t2)
		sw $t1, 320($t2)
		sw $t1, 560($t2)
		sw $t1, 564($t2)
		sw $t1, 568($t2)
		sw $t1, 572($t2)
		sw $t1, 576($t2)
		sw $t1, 580($t2)
		sw $t1, 584($t2)
		sw $t1, 816($t2)
		sw $t1, 820($t2)
		sw $t1, 824($t2)
		sw $t1, 828($t2)
		sw $t1, 832($t2)
		sw $t1, 836($t2)
		sw $t1, 840($t2)
		sw $t1, 1064($t2)
		sw $t1, 1068($t2)
		sw $t1, 1072($t2)
		sw $t1, 1320($t2)
		sw $t1, 1324($t2)
		sw $t1, 1328($t2)
		sw $t1, 1576($t2)
		sw $t1, 1580($t2)
		sw $t1, 1584($t2)
		sw $t1, 1832($t2)
		sw $t1, 1836($t2)
		sw $t1, 1840($t2)
		sw $t1, 1844($t2)
		sw $t1, 1848($t2)
		sw $t1, 1852($t2)
		sw $t1, 1856($t2)
		sw $t1, 1860($t2)
		sw $t1, 1864($t2)
		sw $t1, 2088($t2)
		sw $t1, 2092($t2)
		sw $t1, 2096($t2)
		sw $t1, 2100($t2)
		sw $t1, 2104($t2)
		sw $t1, 2108($t2)
		sw $t1, 2112($t2)
		sw $t1, 2116($t2)
		sw $t1, 2120($t2)
		sw $t1, 2344($t2)
		sw $t1, 2348($t2)
		sw $t1, 2352($t2)
		sw $t1, 2600($t2)
		sw $t1, 2604($t2)
		sw $t1, 2608($t2)
		sw $t1, 2856($t2)
		sw $t1, 2860($t2)
		sw $t1, 2864($t2)
		sw $t1, 3112($t2)
		sw $t1, 3116($t2)
		sw $t1, 3120($t2)
		sw $t1, 3368($t2)
		sw $t1, 3372($t2)
		sw $t1, 3376($t2)
		sw $t1, 1096($t2)
		sw $t1, 1100($t2)
		sw $t1, 1104($t2)
		sw $t1, 1352($t2)
		sw $t1, 1356($t2)
		sw $t1, 1360($t2)
		sw $t1, 1608($t2)
		sw $t1, 1612($t2)
		sw $t1, 1616($t2)
		sw $t1, 1868($t2)
		sw $t1, 1872($t2)
		sw $t1, 2124($t2)
		sw $t1, 2128($t2)
		sw $t1, 2376($t2)
		sw $t1, 2380($t2)
		sw $t1, 2384($t2)
		sw $t1, 2632($t2)
		sw $t1, 2636($t2)
		sw $t1, 2640($t2)
		sw $t1, 2888($t2)
		sw $t1, 2892($t2)
		sw $t1, 2896($t2)
		sw $t1, 3144($t2)
		sw $t1, 3148($t2)
		sw $t1, 3152($t2)
		sw $t1, 3400($t2)
		sw $t1, 3404($t2)
		sw $t1, 3408($t2)
		
		#####print M
		sw $t1, 92($t2)
		sw $t1, 96($t2)
		sw $t1, 100($t2)
		sw $t1, 348($t2)
		sw $t1, 352($t2)
		sw $t1, 356($t2)
		sw $t1, 604($t2)
		sw $t1, 608($t2)
		sw $t1, 612($t2)
		sw $t1, 616($t2)
		sw $t1, 620($t2)
		sw $t1, 624($t2)
		sw $t1, 628($t2)
		sw $t1, 632($t2)
		sw $t1, 636($t2)
		sw $t1, 640($t2)
		sw $t1, 644($t2)
		sw $t1, 648($t2)
		sw $t1, 860($t2)
		sw $t1, 864($t2)
		sw $t1, 868($t2)
		sw $t1, 872($t2)
		sw $t1, 876($t2)
		sw $t1, 880($t2)
		sw $t1, 884($t2)
		sw $t1, 888($t2)
		sw $t1, 892($t2)
		sw $t1, 896($t2)
		sw $t1, 900($t2)
		sw $t1, 904($t2)
		sw $t1, 1116($t2)
		sw $t1, 1120($t2)
		sw $t1, 1124($t2)
		sw $t1, 1372($t2)
		sw $t1, 1376($t2)
		sw $t1, 1380($t2)
		sw $t1, 1628($t2)
		sw $t1, 1632($t2)
		sw $t1, 1636($t2)
		sw $t1, 1884($t2)
		sw $t1, 1888($t2)
		sw $t1, 1892($t2)
		sw $t1, 2140($t2)
		sw $t1, 2144($t2)
		sw $t1, 2148($t2)
		sw $t1, 2396($t2)
		sw $t1, 2400($t2)
		sw $t1, 2404($t2)
		sw $t1, 2652($t2)
		sw $t1, 2656($t2)
		sw $t1, 2660($t2)
		sw $t1, 2908($t2)
		sw $t1, 2912($t2)
		sw $t1, 2916($t2)
		sw $t1, 3164($t2)
		sw $t1, 3168($t2)
		sw $t1, 3172($t2)
		sw $t1, 3420($t2)
		sw $t1, 3424($t2)
		sw $t1, 3428($t2)
		sw $t1, 1140($t2)
		sw $t1, 1144($t2)
		sw $t1, 1148($t2)
		sw $t1, 1396($t2)
		sw $t1, 1400($t2)
		sw $t1, 1404($t2)
		sw $t1, 1652($t2)
		sw $t1, 1656($t2)
		sw $t1, 1660($t2)
		sw $t1, 1908($t2)
		sw $t1, 1912($t2)
		sw $t1, 1916($t2)
		sw $t1, 2164($t2)
		sw $t1, 2168($t2)
		sw $t1, 2172($t2)
		sw $t1, 2420($t2)
		sw $t1, 2424($t2)
		sw $t1, 2428($t2)
		sw $t1, 2676($t2)
		sw $t1, 2680($t2)
		sw $t1, 2684($t2)
		sw $t1, 2932($t2)
		sw $t1, 2936($t2)
		sw $t1, 2940($t2)
		sw $t1, 3188($t2)
		sw $t1, 3192($t2)
		sw $t1, 3196($t2)
		sw $t1, 3444($t2)
		sw $t1, 3448($t2)
		sw $t1, 3452($t2)
		sw $t1, 140($t2)
		sw $t1, 144($t2)
		sw $t1, 148($t2)
		sw $t1, 396($t2)
		sw $t1, 400($t2)
		sw $t1, 404($t2)
		sw $t1, 652($t2)
		sw $t1, 656($t2)
		sw $t1, 660($t2)
		sw $t1, 908($t2)
		sw $t1, 912($t2)
		sw $t1, 916($t2)
		sw $t1, 1164($t2)
		sw $t1, 1168($t2)
		sw $t1, 1172($t2)
		sw $t1, 1420($t2)
		sw $t1, 1424($t2)
		sw $t1, 1428($t2)
		sw $t1, 1676($t2)
		sw $t1, 1680($t2)
		sw $t1, 1684($t2)
		sw $t1, 1932($t2)
		sw $t1, 1936($t2)
		sw $t1, 1940($t2)
		sw $t1, 2188($t2)
		sw $t1, 2192($t2)
		sw $t1, 2196($t2)
		sw $t1, 2444($t2)
		sw $t1, 2448($t2)
		sw $t1, 2452($t2)
		sw $t1, 2700($t2)
		sw $t1, 2704($t2)
		sw $t1, 2708($t2)
		sw $t1, 2956($t2)
		sw $t1, 2960($t2)
		sw $t1, 2964($t2)
		sw $t1, 3212($t2)
		sw $t1, 3216($t2)
		sw $t1, 3220($t2)
		sw $t1, 3468($t2)
		sw $t1, 3472($t2)
		sw $t1, 3476($t2)
		
		#####print E
		sw $t1, 156($t2)
		sw $t1, 160($t2)
		sw $t1, 164($t2)
		sw $t1, 168($t2)
		sw $t1, 172($t2)
		sw $t1, 176($t2)
		sw $t1, 180($t2)
		sw $t1, 184($t2)
		sw $t1, 188($t2)
		sw $t1, 412($t2)
		sw $t1, 416($t2)
		sw $t1, 420($t2)
		sw $t1, 424($t2)
		sw $t1, 428($t2)
		sw $t1, 432($t2)
		sw $t1, 436($t2)
		sw $t1, 440($t2)
		sw $t1, 444($t2)
		sw $t1, 668($t2)
		sw $t1, 672($t2)
		sw $t1, 676($t2)
		sw $t1, 924($t2)
		sw $t1, 928($t2)
		sw $t1, 932($t2)
		sw $t1, 1180($t2)
		sw $t1, 1184($t2)
		sw $t1, 1188($t2)
		sw $t1, 1436($t2)
		sw $t1, 1440($t2)
		sw $t1, 1444($t2)
		sw $t1, 1692($t2)
		sw $t1, 1696($t2)
		sw $t1, 1700($t2)
		sw $t1, 1704($t2)
		sw $t1, 1708($t2)
		sw $t1, 1712($t2)
		sw $t1, 1716($t2)
		sw $t1, 1720($t2)
		sw $t1, 1724($t2)
		sw $t1, 1948($t2)
		sw $t1, 1952($t2)
		sw $t1, 1956($t2)
		sw $t1, 1960($t2)
		sw $t1, 1964($t2)
		sw $t1, 1968($t2)
		sw $t1, 1972($t2)
		sw $t1, 1976($t2)
		sw $t1, 1980($t2)
		sw $t1, 2204($t2)
		sw $t1, 2208($t2)
		sw $t1, 2212($t2)
		sw $t1, 2460($t2)
		sw $t1, 2464($t2)
		sw $t1, 2468($t2)
		sw $t1, 2716($t2)
		sw $t1, 2720($t2)
		sw $t1, 2724($t2)
		sw $t1, 2972($t2)
		sw $t1, 2976($t2)
		sw $t1, 2980($t2)
		sw $t1, 3228($t2)
		sw $t1, 3232($t2)
		sw $t1, 3236($t2)
		sw $t1, 3484($t2)
		sw $t1, 3488($t2)
		sw $t1, 3492($t2)
		sw $t1, 3496($t2)
		sw $t1, 3500($t2)
		sw $t1, 3504($t2)
		sw $t1, 3508($t2)
		sw $t1, 3512($t2)
		sw $t1, 3516($t2)
		sw $t1, 3240($t2)
		sw $t1, 3244($t2)
		sw $t1, 3248($t2)
		sw $t1, 3252($t2)
		sw $t1, 3256($t2)
		sw $t1, 3260($t2)
		
		#######Print O
		sw $t1, 4352($t2)
		sw $t1, 4356($t2)
		sw $t1, 4360($t2)
		sw $t1, 4364($t2)
		sw $t1, 4368($t2)
		sw $t1, 4372($t2)
		sw $t1, 4608($t2)
		sw $t1, 4612($t2)
		sw $t1, 4616($t2)
		sw $t1, 4620($t2)
		sw $t1, 4624($t2)
		sw $t1, 4628($t2)
		sw $t1, 4864($t2)
		sw $t1, 4860($t2)
		sw $t1, 4856($t2)
		sw $t1, 5112($t2)
		sw $t1, 5116($t2)
		sw $t1, 5120($t2)
		sw $t1, 5368($t2)
		sw $t1, 5372($t2)
		sw $t1, 5376($t2)
		sw $t1, 5624($t2)
		sw $t1, 5628($t2)
		sw $t1, 5632($t2)
		sw $t1, 5880($t2)
		sw $t1, 5884($t2)
		sw $t1, 5888($t2)
		sw $t1, 6136($t2)
		sw $t1, 6140($t2)
		sw $t1, 6144($t2)
		sw $t1, 6392($t2)
		sw $t1, 6396($t2)
		sw $t1, 6400($t2)
		sw $t1, 6648($t2)
		sw $t1, 6652($t2)
		sw $t1, 6656($t2)
		sw $t1, 6904($t2)
		sw $t1, 6908($t2)
		sw $t1, 6912($t2)
		sw $t1, 7168($t2)
		sw $t1, 7172($t2)
		sw $t1, 7176($t2)
		sw $t1, 7180($t2)
		sw $t1, 7184($t2)
		sw $t1, 7188($t2)
		sw $t1, 7424($t2)
		sw $t1, 7428($t2)
		sw $t1, 7432($t2)
		sw $t1, 7436($t2)
		sw $t1, 7440($t2)
		sw $t1, 7444($t2)
		sw $t1, 4884($t2)
		sw $t1, 4888($t2)
		sw $t1, 4892($t2)
		sw $t1, 5140($t2)
		sw $t1, 5144($t2)
		sw $t1, 5148($t2)
		sw $t1, 5396($t2)
		sw $t1, 5400($t2)
		sw $t1, 5404($t2)
		sw $t1, 5652($t2)
		sw $t1, 5656($t2)
		sw $t1, 5660($t2)
		sw $t1, 5908($t2)
		sw $t1, 5912($t2)
		sw $t1, 5916($t2)
		sw $t1, 6164($t2)
		sw $t1, 6168($t2)
		sw $t1, 6172($t2)
		sw $t1, 6420($t2)
		sw $t1, 6424($t2)
		sw $t1, 6428($t2)
		sw $t1, 6676($t2)
		sw $t1, 6680($t2)
		sw $t1, 6684($t2)
		sw $t1, 6932($t2)
		sw $t1, 6936($t2)
		sw $t1, 6940($t2)
		
		#######Print V
		sw $t1, 4392($t2)
		sw $t1, 4396($t2)
		sw $t1, 4648($t2)
		sw $t1, 4652($t2)
		sw $t1, 4904($t2)
		sw $t1, 4908($t2)
		sw $t1, 5160($t2)
		sw $t1, 5164($t2)
		sw $t1, 5416($t2)
		sw $t1, 5420($t2)
		sw $t1, 5680($t2)
		sw $t1, 5684($t2)
		sw $t1, 5936($t2)
		sw $t1, 5940($t2)
		sw $t1, 6192($t2)
		sw $t1, 6196($t2)
		sw $t1, 6448($t2)
		sw $t1, 6452($t2)
		sw $t1, 6704($t2)
		sw $t1, 6708($t2)
		sw $t1, 6968($t2)
		sw $t1, 6972($t2)
		sw $t1, 7224($t2)
		sw $t1, 7228($t2)
		sw $t1, 7480($t2)
		sw $t1, 7484($t2)
		sw $t1, 6720($t2)
		sw $t1, 6724($t2)
		sw $t1, 6464($t2)
		sw $t1, 6468($t2)
		sw $t1, 6208($t2)
		sw $t1, 6212($t2)
		sw $t1, 5952($t2)
		sw $t1, 5956($t2)
		sw $t1, 5696($t2)
		sw $t1, 5700($t2)
		sw $t1, 5448($t2)
		sw $t1, 5452($t2)
		sw $t1, 5192($t2)
		sw $t1, 5196($t2)
		sw $t1, 4936($t2)
		sw $t1, 4940($t2)
		sw $t1, 4680($t2)
		sw $t1, 4684($t2)
		sw $t1, 4424($t2)
		sw $t1, 4428($t2)
		
		#######Print E
		sw $t1, 4440($t2)
		sw $t1, 4444($t2)
		sw $t1, 4448($t2)
		sw $t1, 4452($t2)
		sw $t1, 4456($t2)
		sw $t1, 4460($t2)
		sw $t1, 4464($t2)
		sw $t1, 4468($t2)
		sw $t1, 4472($t2)
		sw $t1, 4476($t2)
		sw $t1, 4696($t2)
		sw $t1, 4700($t2)
		sw $t1, 4704($t2)
		sw $t1, 4708($t2)
		sw $t1, 4712($t2)
		sw $t1, 4716($t2)
		sw $t1, 4720($t2)
		sw $t1, 4724($t2)
		sw $t1, 4728($t2)
		sw $t1, 4732($t2)
		sw $t1, 4952($t2)
		sw $t1, 4956($t2)
		sw $t1, 4960($t2)
		sw $t1, 5208($t2)
		sw $t1, 5212($t2)
		sw $t1, 5216($t2)
		sw $t1, 5464($t2)
		sw $t1, 5468($t2)
		sw $t1, 5472($t2)
		sw $t1, 5720($t2)
		sw $t1, 5724($t2)
		sw $t1, 5728($t2)
		sw $t1, 5976($t2)
		sw $t1, 5980($t2)
		sw $t1, 5984($t2)
		sw $t1, 5988($t2)
		sw $t1, 5992($t2)
		sw $t1, 5996($t2)
		sw $t1, 6000($t2)
		sw $t1, 6004($t2)
		sw $t1, 6008($t2)
		sw $t1, 6012($t2)
		sw $t1, 6232($t2)
		sw $t1, 6236($t2)
		sw $t1, 6240($t2)
		sw $t1, 6244($t2)
		sw $t1, 6248($t2)
		sw $t1, 6252($t2)
		sw $t1, 6256($t2)
		sw $t1, 6260($t2)
		sw $t1, 6264($t2)
		sw $t1, 6268($t2)
		sw $t1, 6488($t2)
		sw $t1, 6492($t2)
		sw $t1, 6496($t2)
		sw $t1, 6744($t2)
		sw $t1, 6748($t2)
		sw $t1, 6752($t2)
		sw $t1, 7000($t2)
		sw $t1, 7004($t2)
		sw $t1, 7008($t2)
		sw $t1, 7256($t2)
		sw $t1, 7260($t2)
		sw $t1, 7264($t2)
		sw $t1, 7268($t2)
		sw $t1, 7272($t2)
		sw $t1, 7276($t2)
		sw $t1, 7280($t2)
		sw $t1, 7284($t2)
		sw $t1, 7288($t2)
		sw $t1, 7292($t2)
		sw $t1, 7512($t2)
		sw $t1, 7516($t2)
		sw $t1, 7520($t2)
		sw $t1, 7524($t2)
		sw $t1, 7528($t2)
		sw $t1, 7532($t2)
		sw $t1, 7536($t2)
		sw $t1, 7540($t2)
		sw $t1, 7544($t2)
		sw $t1, 7548($t2)
		
		#######Print R
		sw $t1, 4496($t2)
		sw $t1, 4500($t2)
		sw $t1, 4504($t2)
		sw $t1, 4508($t2)
		sw $t1, 4512($t2)
		sw $t1, 4516($t2)
		sw $t1, 4520($t2)
		sw $t1, 4752($t2)
		sw $t1, 4756($t2)
		sw $t1, 4760($t2)
		sw $t1, 4764($t2)
		sw $t1, 4768($t2)
		sw $t1, 4772($t2)
		sw $t1, 4776($t2)
		sw $t1, 5000($t2)
		sw $t1, 5004($t2)
		sw $t1, 5008($t2)
		sw $t1, 5256($t2)
		sw $t1, 5260($t2)
		sw $t1, 5264($t2)
		sw $t1, 5512($t2)
		sw $t1, 5516($t2)
		sw $t1, 5520($t2)
		sw $t1, 5768($t2)
		sw $t1, 5772($t2)
		sw $t1, 5776($t2)
		sw $t1, 6024($t2)
		sw $t1, 6028($t2)
		sw $t1, 6032($t2)
		sw $t1, 6036($t2)
		sw $t1, 6040($t2)
		sw $t1, 6044($t2)
		sw $t1, 6048($t2)
		sw $t1, 6052($t2)
		sw $t1, 6056($t2)
		sw $t1, 6280($t2)
		sw $t1, 6284($t2)
		sw $t1, 6288($t2)
		sw $t1, 6292($t2)
		sw $t1, 6296($t2)
		sw $t1, 6300($t2)
		sw $t1, 6304($t2)
		sw $t1, 6308($t2)
		sw $t1, 6312($t2)
		sw $t1, 6536($t2)
		sw $t1, 6540($t2)
		sw $t1, 6544($t2)
		sw $t1, 6792($t2)
		sw $t1, 6796($t2)
		sw $t1, 6800($t2)
		sw $t1, 7048($t2)
		sw $t1, 7052($t2)
		sw $t1, 7056($t2)
		sw $t1, 7304($t2)
		sw $t1, 7308($t2)
		sw $t1, 7312($t2)
		sw $t1, 7560($t2)
		sw $t1, 7564($t2)
		sw $t1, 7568($t2)
		sw $t1, 5032($t2)
		sw $t1, 5036($t2)
		sw $t1, 5040($t2)
		sw $t1, 5288($t2)
		sw $t1, 5292($t2)
		sw $t1, 5296($t2)
		sw $t1, 5552($t2)
		sw $t1, 5544($t2)
		sw $t1, 5548($t2)
		sw $t1, 5808($t2)
		sw $t1, 5800($t2)
		sw $t1, 5804($t2)
		sw $t1, 6568($t2)
		sw $t1, 6572($t2)
		sw $t1, 6576($t2)
		sw $t1, 6824($t2)
		sw $t1, 6828($t2)
		sw $t1, 6832($t2)
		sw $t1, 7080($t2)
		sw $t1, 7084($t2)
		sw $t1, 7088($t2)
		sw $t1, 7336($t2)
		sw $t1, 7340($t2)
		sw $t1, 7344($t2)
		sw $t1, 7592($t2)
		sw $t1, 7596($t2)
		sw $t1, 7600($t2)
		
		li $t1, 1500
		li $v0, 32
        	add $a0, $t1, $zero
        	syscall
        	
        	#restarting current level
        	beq $s1, 1, level_one	
        	beq $s1, 2, level_two
        	beq $s1, 3, level_three
        	
win:		li $t0, BASE_ADDRESS
		li $t1, BLACK
		li $t2, 4
		addi $t3, $t0, 16384
		jal color

		# Draw W
		li $t0, BASE_ADDRESS
		li $t1, YELLOW
		addi $t2, $t0, 5176
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 256($t2)
		sw $t1, 260($t2)
		sw $t1, 264($t2)
		sw $t1, 512($t2)
		sw $t1, 516($t2)
		sw $t1, 520($t2)
		sw $t1, 768($t2)
		sw $t1, 772($t2)
		sw $t1, 776($t2)
		sw $t1, 1024($t2)
		sw $t1, 1028($t2)
		sw $t1, 1032($t2)
		sw $t1, 1280($t2)
		sw $t1, 1284($t2)
		sw $t1, 1288($t2)
		sw $t1, 1536($t2)
		sw $t1, 1540($t2)
		sw $t1, 1544($t2)
		sw $t1, 1792($t2)
		sw $t1, 1796($t2)
		sw $t1, 1800($t2)
		sw $t1, 2048($t2)
		sw $t1, 2052($t2)
		sw $t1, 2056($t2)
		sw $t1, 2304($t2)
		sw $t1, 2308($t2)
		sw $t1, 2312($t2)
		sw $t1, 2316($t2)
		sw $t1, 2320($t2)
		sw $t1, 2324($t2)
		sw $t1, 2328($t2)
		sw $t1, 2332($t2)
		sw $t1, 2336($t2)
		sw $t1, 2340($t2)
		sw $t1, 2344($t2)
		sw $t1, 2348($t2)
	
		sw $t1, 2072($t2)
		sw $t1, 2076($t2)
		sw $t1, 2080($t2)
		sw $t1, 1816($t2)
		sw $t1, 1820($t2)
		sw $t1, 1824($t2)
		sw $t1, 1560($t2)
		sw $t1, 1564($t2)
		sw $t1, 1568($t2)
	
		sw $t1, 2560($t2)
		sw $t1, 2564($t2)
		sw $t1, 2568($t2)
		sw $t1, 2572($t2)
		sw $t1, 2576($t2)
		sw $t1, 2580($t2)
		sw $t1, 2584($t2)
		sw $t1, 2588($t2)
		sw $t1, 2592($t2)
		sw $t1, 2596($t2)
		sw $t1, 2600($t2)
		sw $t1, 2604($t2)
		sw $t1, 2816($t2)
		sw $t1, 2820($t2)
		sw $t1, 2824($t2)
		sw $t1, 3072($t2)
		sw $t1, 3076($t2)
		sw $t1, 3080($t2)
		
		sw $t1, 2864($t2)
		sw $t1, 2868($t2)
		sw $t1, 2872($t2)
		sw $t1, 3120($t2)
		sw $t1, 3124($t2)
		sw $t1, 3128($t2)
		sw $t1, 2608($t2)
		sw $t1, 2612($t2)
		sw $t1, 2616($t2)
		sw $t1, 2352($t2)
		sw $t1, 2356($t2)
		sw $t1, 2360($t2)
		sw $t1, 2096($t2)
		sw $t1, 2100($t2)
		sw $t1, 2104($t2)
		sw $t1, 1840($t2)
		sw $t1, 1844($t2)
		sw $t1, 1848($t2)
		sw $t1, 1584($t2)
		sw $t1, 1588($t2)
		sw $t1, 1592($t2)
		sw $t1, 1328($t2)
		sw $t1, 1332($t2)
		sw $t1, 1336($t2)
		sw $t1, 1072($t2)
		sw $t1, 1076($t2)
		sw $t1, 1080($t2)
		sw $t1, 816($t2)
		sw $t1, 820($t2)
		sw $t1, 824($t2)
		sw $t1, 560($t2)
		sw $t1, 564($t2)
		sw $t1, 568($t2)
		sw $t1, 304($t2)
		sw $t1, 308($t2)
		sw $t1, 312($t2)
		sw $t1, 48($t2)
		sw $t1, 52($t2)
		sw $t1, 56($t2)
		
		#Draw I
		sw $t1, 68($t2)
		sw $t1, 72($t2)
		sw $t1, 76($t2)
		sw $t1, 324($t2)
		sw $t1, 328($t2)
		sw $t1, 332($t2)
		sw $t1, 580($t2)
		sw $t1, 584($t2)
		sw $t1, 588($t2)
		sw $t1, 836($t2)
		sw $t1, 840($t2)
		sw $t1, 844($t2)
		sw $t1, 1092($t2)
		sw $t1, 1096($t2)
		sw $t1, 1100($t2)
		sw $t1, 1348($t2)
		sw $t1, 1352($t2)
		sw $t1, 1356($t2)
		sw $t1, 1604($t2)
		sw $t1, 1608($t2)
		sw $t1, 1612($t2)
		sw $t1, 1860($t2)
		sw $t1, 1864($t2)
		sw $t1, 1868($t2)
		sw $t1, 2116($t2)
		sw $t1, 2120($t2)
		sw $t1, 2124($t2)
		sw $t1, 2372($t2)
		sw $t1, 2376($t2)
		sw $t1, 2380($t2)
		sw $t1, 2628($t2)
		sw $t1, 2632($t2)
		sw $t1, 2636($t2)
		sw $t1, 2884($t2)
		sw $t1, 2888($t2)
		sw $t1, 2892($t2)
		sw $t1, 3140($t2)
		sw $t1, 3144($t2)
		sw $t1, 3148($t2)
		
		#Draw N
		sw $t1, 88($t2)
		sw $t1, 92($t2)
		sw $t1, 96($t2)
		sw $t1, 344($t2)
		sw $t1, 348($t2)
		sw $t1, 352($t2)
		sw $t1, 600($t2)
		sw $t1, 604($t2)
		sw $t1, 608($t2)
		sw $t1, 856($t2)
		sw $t1, 860($t2)
		sw $t1, 864($t2)
		sw $t1, 1112($t2)
		sw $t1, 1116($t2)
		sw $t1, 1120($t2)
		sw $t1, 1368($t2)
		sw $t1, 1372($t2)
		sw $t1, 1376($t2)
		sw $t1, 1624($t2)
		sw $t1, 1628($t2)
		sw $t1, 1632($t2)
		sw $t1, 1880($t2)
		sw $t1, 1884($t2)
		sw $t1, 1888($t2)
		sw $t1, 2136($t2)
		sw $t1, 2140($t2)
		sw $t1, 2144($t2)
		sw $t1, 2392($t2)
		sw $t1, 2396($t2)
		sw $t1, 2400($t2)
		sw $t1, 2648($t2)
		sw $t1, 2652($t2)
		sw $t1, 2656($t2)
		sw $t1, 2904($t2)
		sw $t1, 2908($t2)
		sw $t1, 2912($t2)
		sw $t1, 3160($t2)
		sw $t1, 3164($t2)
		sw $t1, 3168($t2)
		
		sw $t1, 612($t2)
		sw $t1, 616($t2)
		sw $t1, 620($t2)
		sw $t1, 868($t2)
		sw $t1, 872($t2)
		sw $t1, 876($t2)
		sw $t1, 1132($t2)
		sw $t1, 1136($t2)
		sw $t1, 1140($t2)
		sw $t1, 1388($t2)
		sw $t1, 1392($t2)
		sw $t1, 1396($t2)
		
		sw $t1, 1652($t2)
		sw $t1, 1656($t2)
		sw $t1, 1660($t2)
		sw $t1, 1908($t2)
		sw $t1, 1912($t2)
		sw $t1, 1916($t2)
		
		sw $t1, 128($t2)
		sw $t1, 132($t2)
		sw $t1, 136($t2)
		sw $t1, 384($t2)
		sw $t1, 388($t2)
		sw $t1, 392($t2)
		sw $t1, 640($t2)
		sw $t1, 644($t2)
		sw $t1, 648($t2)
		sw $t1, 896($t2)
		sw $t1, 900($t2)
		sw $t1, 904($t2)
		sw $t1, 1152($t2)
		sw $t1, 1156($t2)
		sw $t1, 1160($t2)
		sw $t1, 1408($t2)
		sw $t1, 1412($t2)
		sw $t1, 1416($t2)
		sw $t1, 1664($t2)
		sw $t1, 1668($t2)
		sw $t1, 1672($t2)
		sw $t1, 1920($t2)
		sw $t1, 1924($t2)
		sw $t1, 1928($t2)
		sw $t1, 2176($t2)
		sw $t1, 2180($t2)
		sw $t1, 2184($t2)
		sw $t1, 2432($t2)
		sw $t1, 2436($t2)
		sw $t1, 2440($t2)
		sw $t1, 2688($t2)
		sw $t1, 2692($t2)
		sw $t1, 2696($t2)
		sw $t1, 2944($t2)
		sw $t1, 2948($t2)
		sw $t1, 2952($t2)
		sw $t1, 3200($t2)
		sw $t1, 3204($t2)
		sw $t1, 3208($t2)	
			
END:	li $v0, 10	      # End of the system
        syscall