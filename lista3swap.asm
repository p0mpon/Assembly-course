.data
	n: .asciiz "prosze podac n (n<100): "
	msg: .asciiz "prosze podac liczby:\n"
	blad: .asciiz "n musi byc wieksze od 0 i mniejsze od 100: "
	nl: .asciiz ", "

.text
	li $v0, 4
	la $a0, n
	syscall
	
	inputN:
		li $v0, 5
		syscall
		blez $v0, no
		bge $v0, 100, no
		j cont
		no:
		li $v0, 4
		la $a0, blad
		syscall
		j inputN
	
	cont:
	addi $s0, $v0, -1 #n-1
	mul $s0, $s0, 4
	move $a0, $v0
	mul $a0, $a0, 4 #ilosc bajtow
	li $v0, 9
	syscall #w $v0 jest adres poczatku
	move $s1, $v0
	li $v0, 4
	la $a0, msg
	syscall
	
	input:
		li $v0, 5
		syscall
		add $t1, $t0, $s1
		sw $v0, ($t1)
		addi $t0, $t0, 4
		ble $t0, $s0, input
		
	jal sort
	j print
	
	sort:
		blt $t2, $s0, cont2
		jr $ra
		cont2:
		li $t3, 0
		mul $t4, $t2, -1 #-i
		add $t4, $s0, $t4 # n-i-1
		
		while:
			add $t5, $t3, $s1
			lw $t0, ($t5)
			lw $t1, 4($t5)
			ble $t0, $t1, skip
			subi $sp, $sp, 4
			sw $ra, ($sp)
			jal swap
			lw $ra, ($sp)
			addi $sp, $sp, 4
			skip:
			addi $t3, $t3, 4 #+4 (j)
			blt $t3, $t4, while
		
		addi $t2, $t2, 4 #+4 (i)
		j sort
	
	print:
		li $t0, 0
		printWhile:
			bgt $t0, $s0, exit
			add $t1, $t0, $s1
			lw $a0, ($t1)
			li $v0, 1
			syscall
			li $v0, 4
			la $a0, nl
			syscall
			addi $t0, $t0, 4
			j printWhile
	
	exit:
		li $v0, 10
		syscall
		
	swap:
		sw $t0, 4($t5)
		sw $t1, ($t5)
		jr $ra
