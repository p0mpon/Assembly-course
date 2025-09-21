.data
	msg: .asciiz "podaj slowo\n"
	slowo: .space 100
	tak: .asciiz "tak"
	nie: .asciiz "nie"

.text
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 8
	la $a0, slowo
	li $a1, 100
	syscall
	
	la $t0, slowo
	check_length:
		addi $t0, $t0, 1
		lb $t1, ($t0)
		bne $t1, 10, check_length
		move $t1, $t0
	
	la $t0, slowo
	subi $t0, $t0, 1
	check_palindrom:
		addi $t0, $t0, 1
		subi $t1, $t1, 1
		bge $t0, $t1, yes
		lb $t2, ($t0)
		lb $t3, ($t1)
		beq $t2, $t3, check_palindrom
		j no
	
	yes:
		li $v0, 4
		la $a0, tak
		syscall
		j exit
	
	no:
		li $v0, 4
		la $a0, nie
		syscall
		j exit
		
	exit:
		li $v0, 10
		syscall