.data
	msg: .asciiz "prosze podac n: "
	e: .double 0.0001
	one: .double 1.0
	pow2: .asciiz "^2 = "
	pow3: .asciiz "^3 = "
	nl: .asciiz "\n"
	
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	whileN:
		li $v0, 7
		syscall
		c.lt.d $f0, $f8
		bc1t whileN
		mov.d $f8, $f0
	
	l.d $f2, e
	l.d $f10, one
	c.lt.d $f8, $f10
	bc1f wiecej
	sub.d $f10, $f10, $f10
	wiecej:
	mov.d $f4, $f10
	
	pierwiastek2:
		mul.d $f6, $f4, $f4
		c.le.d $f8, $f6
		bc1f dalej
		li $v0, 3 #wartosc
		mov.d $f12, $f4
		syscall
		li $v0, 4
		la $a0, pow2
		syscall
		li $v0, 3 #wynik
		mov.d $f12, $f6
		syscall
		li $v0, 4
		la $a0, nl
		syscall
		mov.d $f4, $f10
		j pierwiastek3
		dalej:
		add.d $f4, $f4, $f2
		j pierwiastek2
		
	pierwiastek3:
		mul.d $f6, $f4, $f4
		mul.d $f6, $f6, $f4
		c.le.d $f8, $f6
		bc1f dalej2
		li $v0, 3 #wartosc
		mov.d $f12, $f4
		syscall
		li $v0, 4
		la $a0, pow3
		syscall
		li $v0, 3 #wynik
		mov.d $f12, $f6
		syscall
		j exit
		dalej2:
		add.d $f4, $f4, $f2
		j pierwiastek3
	
	exit:
		li $v0, 10
		syscall