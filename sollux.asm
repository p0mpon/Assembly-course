.data
	msg: .asciiz "podaj tekst\n"
	string: .space 1000

.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 8
	la $a0, string
	li $a1, 1000
	move $t0, $a0
	syscall
	
	while:
		lb $t1, ($t0)
		beq $t1, 10, done
		bne $t1, 115, s #s
		li $t1, 50
		sb $t1, ($t0)
		s:
		bne $t1, 105, i #i
		jal move_characters
		i:
		addi $t0, $t0, 1
		j while
	
	done:
	li $v0, 4
	la $a0, string
	syscall
	
	exit:
		li $v0, 10
		syscall
		
	move_characters:
		addi $t2, $t0, 1
		loop:
			lb $t3, ($t2)
			sb $t1, ($t2)
			beq $t3, 0, exit_loop
			move $t1, $t3
			addi $t2, $t2, 1
			j loop
		exit_loop:
		addi $t0, $t0, 1
		jr $ra