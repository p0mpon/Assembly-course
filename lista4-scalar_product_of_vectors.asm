.data
	liczba: .asciiz "podaj liczbe wspolrzednych: "
	msg: .asciiz "wprowadz wektor nr "
	nl: .asciiz "\n"
	msg2: .asciiz "iloczyn skalarny wektorow wynosi "
	
.text
	li $v0, 4
	la $a0, liczba
	syscall
	li $v0, 5
	syscall
	beqz $v0, exit
	move $s0, $v0 # $s0 = liczba wsp
	
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 1
	li $a0, 1
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	jal wprowadzanie # wektor 1
	move $s1, $sp # poczatek pierwszego wektora
	
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 1
	li $a0, 2
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	jal wprowadzanie # wektor 2
	
	li $s0, 0 # wynik
	move $t0, $s1
	iloczyn:
		beq $sp, $s1, print # koniec drugiego wektora
		lw $t1, ($t0) # pierwszy wektor
		beqz $t1, print # koniec pierwszego wektora
		lw $t2, ($sp) # drugi wektor
		bne $t1, $t2, rozne
		#rowne
		lw $t1, 4($t0)
		lw $t2, 4($sp)
		mul $t1, $t1, $t2
		add $s0, $s0, $t1
		addi $t0, $t0, 8
		sw $zero, ($sp)
		sw $zero, 4($sp)
		addi $sp, $sp, 8
		j iloczyn
		rozne:
		blt $t1, $t2, drugi
		# zmienia sie pierwszy
		addi $t0, $t0, 8
		j iloczyn
		drugi:
		# zmienia sie drugi
		sw $zero, ($sp)
		sw $zero, 4($sp)
		addi $sp, $sp, 8
		j iloczyn
	
	print:
		li $v0, 4
		la $a0, msg2
		syscall
		li $v0, 1
		move $a0, $s0
		syscall
		
		stack:
			lw $t1, ($sp)
			beqz $t1, exit
			sw $zero, ($sp)
			sw $zero, 4($sp)
			addi $sp, $sp, 8
			j stack
	
	exit:
		li $v0, 10
		syscall
	
	wprowadzanie:
		li $t0, 1
		while:
			li $v0, 5
			syscall
			beqz $v0, zero
			addi $sp, $sp, -8
			sw $v0, 4($sp)
			sw $t0, ($sp)
			zero:
			addi $t0, $t0, 1
			ble $t0, $s0, while
		jr $ra
