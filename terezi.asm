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
		bne $t1, 65, A #A
		li $t1, 52
		A:
		bne $t1, 69, E #E
		li $t1, 51
		E:
		bne $t1, 73, I #I
		li $t1, 49
		I:
		sb $t1, ($t0)
		addi $t0, $t0, 1
		j while
	
	done:
	li $v0, 4
	la $a0, string
	syscall
	
	exit:
		li $v0, 10
		syscall
	