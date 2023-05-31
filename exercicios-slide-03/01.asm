# Crie uma estrutura em assembly que se assemelhe ao while do C

.data
	msg: .asciiz "Digite o número de vezes que será executado: "
	exec_status_msg: .asciiz "\nEssa é a vez número: "
	exec_number: .word 0
	total_execs: .word 0
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	beqz $v0, finaliza_programa
	
	sw $v0, total_execs
	
	lw $t0, total_execs
	
	jal loop
	
loop:
	lw $t1, exec_number
	
	addi $t1, $t1, 1
	
	sw $t1, exec_number
	
	la $a0, exec_status_msg
	li $v0, 4
	syscall
	
	li $v0, 1
	lw $a0, exec_number
	syscall
	
	sub $t2, $t0, $t1
	
	beqz $t2, finaliza_programa
	
	jr $ra
	
finaliza_programa:
	li $v0, 10
	syscall
