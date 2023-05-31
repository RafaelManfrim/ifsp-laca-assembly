# Calcular a sequência de Fibonacci até um determinado limite

.data
	msg: .asciiz "Digite até qual posição de Fibonacci você deseja: "
	response_msg: .asciiz "\nEsse número é: "
	
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	move $t0, $v0
	li $t1, 1
	li $t2, 2

	beq	$t0, $t1, primeiro_numero
	beq	$t0, $t2, segundo_numero

	li $t1, 0 # Número anterior
	li $t2, 1 # Número atual

	addi $t0, $t0, -2
	
	jal	loop
	
loop:
	beqz $t0, finaliza_loop

	add	$t3, $t1, $t2
	move $t1, $t2
	move $t2, $t3

	addi $t0, $t0, -1

	jr $ra

primeiro_numero:
	li $a0, 0
	li $v0, 1
	syscall

	j finaliza_programa

segundo_numero:
	li $a0, 1
	li $v0, 1
	syscall

	j finaliza_programa

finaliza_loop:
	move $a0, $t3
	li $v0, 1
	syscall

	j finaliza_programa

finaliza_programa:
	li $v0, 10
	syscall
