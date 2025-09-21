.data
	msg: .asciiz "podaj ciag znakow\n"
	kon: .asciiz "od konca co drugie:\n"
	ciag: .space 401
	nl: .asciiz "\n"
	palindrom: .space 201
	nope: .asciiz "\nNIE, to nie palindrom\n"
	yuh: .asciiz "\nTAK, to palindrom\n"
	
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 8
	la $a0, ciag
	move $s0, $a0
	li $a1, 400
	syscall
	
	#zadanie 1
	move $t0, $a0
	
	koniec:
		lb $t1, ($t0)
		beq $t1, 0, dalej
		addi $t0, $t0, 1
		j koniec
	
	dalej:
	li $v0, 4
	la $a0, kon
	syscall
	
	subi $t0, $t0, 2
	li $v0, 11
	
	od_konca:
		blt $t0, $s0, dalej2
		lb $a0, ($t0)
		syscall
		subi $t0, $t0, 2
		j od_konca
	
	dalej2:	
	#zadanie 2
	move $t0, $s0
	la $t1, palindrom
	
	od_poczatku:
		lb $t2, ($t0)
		ble $t2, 10, dalej3
		sb $t2, ($t1)
		addi $t1, $t1, 1
		addi $t0, $t0, 2
		j od_poczatku
	
	dalej3:
	li $v0, 4
	la $a0, nl
	syscall
	la $a0, palindrom
	syscall
	
	subi $t1, $t1, 1 # koniec
	la $t0, palindrom # poczatek
	
	czy_palindrom:
		ble $t1, $t0, tak
		lb $t2, ($t1)
		lb $t3, ($t0)
		bne $t2, $t3, nie
		addi $t0, $t0, 1
		subi $t1, $t1, 1
		j czy_palindrom
	
	tak:
		li $v0, 4
		la $a0, yuh
		syscall
		j exit
		
	nie:
		li $v0, 4
		la $a0, nope
		syscall
		j exit
	
	exit:
		li $v0, 10
		syscall