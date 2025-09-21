.data
	msg: .asciiz "podaj n: "
	n: .asciiz "liczba musi byc wieksza od 0\n"
	eq: .asciiz "! = "
	one: .double 1.0
	of: .asciiz "nie mozna obliczyc silni :c"
	
.text
	#maksymalne n: 170
	li $v0, 4
	la $a0, msg
	syscall
	
	checkN:
		li $v0, 5
		syscall
		bge $zero, $v0, blad
		move $s0, $v0 #n
		li $t0, 2 #i
		mtc1.d $t0, $f0
		cvt.d.w $f0, $f0
		l.d $f12, one #wynik
		j while
		
	blad:
		li $v0, 4
		la $a0, n
		syscall
		j checkN
		
	while:
		bgt $t0, $s0, print
		mfc1 $t1, $f13
		beq $t1, 2146435072, overflow
	
	do:
		mul.d $f12, $f12, $f0 #wynik*=i
		addi $t0, $t0, 1 #i++
		mtc1.d $t0, $f0
		cvt.d.w $f0, $f0
		j while
		
	print:
		li $v0, 1
		move $a0, $s0
		syscall # n
		li $v0, 4
		la $a0, eq
		syscall #dzialanie
		li $v0, 3
		syscall #wynik
		j exit
		
	overflow:
		li $v0, 4
		la $a0, of
		syscall
		j exit
	
	exit:
		li $v0, 10
		syscall
	
