.data
	komunikat: .asciiz "prosze podac dzialanie\n"
	instrukcja: .asciiz "0 = +, 1 = -, 2 = /, 3 = *\n"
	kontynuacja: .asciiz "\nczy kontynuowac? 0/1\n"

.text
	do:
		li $v0, 4
		la $a0, komunikat
		syscall
		la $a0, instrukcja
		syscall
		
		li $v0, 5
		syscall
		move $s0, $v0
		li $v0, 5
		syscall
		move $s1, $v0
		li $v0, 5
		syscall
		move $s2, $v0
		
		beq $s1, 0, dodawanie
		beq $s1, 1, odejmowanie
		beq $s1, 2, dzielenie
		beq $s1, 3, mnozenie
		back:
	
		li $v0, 1
		syscall
	while:
		la $a0, kontynuacja
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		beq $v0, 1, do
	
	exit:
		li $v0, 10
		syscall
	
	dodawanie:
		add $a0, $s0, $s2
		j back
	
	odejmowanie:
		sub $a0, $s0, $s2
		j back
		
	dzielenie:
		div $a0, $s0, $s2
		j back
		
	mnozenie:
		mul $a0, $s0, $s2
		j back