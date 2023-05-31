# Verificar se um número é positivo, negativo ou zero

.data
	msg: .asciiz "Digite um número: "
	positivo_msg: .asciiz "\nEsse número é positivo."
	negativo_msg: .asciiz "\nEsse número é negativo."
	zero_msg: .asciiz "\nEsse número é zero."
	
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	li $t0, 0
	
	bgt $v0, $t0, positivo
	
	blt $v0, $t0, negativo
	
	j zero
	
positivo:
	la $a0, positivo_msg
	j finaliza_programa

negativo:
	la $a0, negativo_msg
	j finaliza_programa
	
zero:
	la $a0, zero_msg
	j finaliza_programa

finaliza_programa:
	li $v0, 4
	syscall

	li $v0, 10
	syscall