.data
	alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUWVXYZ"
	pytanie: .asciiz "szyfrowanie - 0, odszyfrowanie - 1\n"
	przesuniecie: .asciiz "przesuniecie: "
	zdanie: .asciiz "wpisz tekst max. 16 liter\n"
	tekst: .space 17
	

.text
	li $v0, 4
	la $a0, pytanie
	syscall
	li $v0, 5
	syscall
	li $v0, 4
	la $a0, przesuniecie
	syscall
	li $v0, 5
	syscall
	move $s0, $v0 # $s0 = przesuniecie
	
	li $v0, 4
	la $a0, zdanie
	syscall
	li $v0, 8
	la $a0, tekst
	li $a1, 16
	move $t0, $a0 # $t0 = adres tekstu
	syscall
	
	while:
		lb $t1, ($t0)
		beq $t1, 10, done
		beq $t1, 32, mniejsze
		add $t1, $t1, $s0
		ble $t1, 90, wieksze
		sub $t1, $t1, 26
		wieksze:
		bge $t1, $t1, mniejsze
		add $t1, $t1, 26
		mniejsze:
		sb $t1, ($t0)
		addi $t0, $t0, 1
		j while
	
	done:
	li $v0, 4
	la $a0, tekst
	syscall

	exit:
		li $v0, 10
		syscall