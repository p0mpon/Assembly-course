.data
	msg1: .asciiz  "Enter a value:"
	msg2: .asciiz  "Sum of value and 100:"

.text
	li $v0,4    # prompt user (print string)
	la $a0,msg1    # indicate the message!
	syscall
	li $v0,5    # read integer, X
	syscall
	addi $s0,$v0,100    # $s0 = X + 100
	li $v0,4   # output message
	la $a0,msg2    # indicate the message!
	syscall
	li $v0,1   # print integer!
	move $a0,$s0   # value to print!
	syscall
	li $v0,10   # exit program!
	syscall
