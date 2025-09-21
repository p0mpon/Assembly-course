.data
	msg: .asciiz "prosze podac parametry\n"
	a: .asciiz "a: "
	b: .asciiz "b: "
	c: .asciiz "c: "
	d: .asciiz "d: "
	x: .asciiz "x: "
	eq: .asciiz "ax^3 + bx^2 + cx + d = "
	
.text
	li $v0, 4 #print string
	la $a0, msg #the string to print
	syscall #does the operation in $v0
	
	la $a0, a #print a
	syscall
	li $v0, 5 #read int
	syscall #number gonna be in $v0
	move $t0, $v0 #the number is gonna be in $t0 now
	
	li $v0, 4
	la $a0, b #print b
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 4
	la $a0, c #print c
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 4
	la $a0, d #print d
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, x #print x
	syscall
	li $v0, 5
	syscall
	move $t3, $v0
	
	mul $t2, $t2, $t3 # $t2 = c*x
	add $s0, $s0, $t2 # $s0 = d + c*x
	
	mul $t1, $t1, $t3 # $t1 = b*x
	mul $t1, $t1, $t3 # $t1 = b*x*x
	add $s0, $s0, $t1 # $s0 = d + c*x + b*x*x
	
	mul $t0, $t0, $t3 # $t0 = a*x
	mul $t0, $t0, $t3 # $t0 = a*x*x
	mul $t0, $t0, $t3 # $t0 = a*x*x*x
	add $s0, $s0, $t0 # $s0 = d + c*x + b*x*x + a*x*x*x
	
	li $v0, 4
	la $a0, eq
	syscall #print the equation
	li $v0, 1
	move $a0, $s0
	syscall #print the result
	
	li $v0, 10
	syscall #exit