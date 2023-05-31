# Verificar se um número é par ou ímpar

.data
	msg: .asciiz "Digite um número: "
	is_par_msg: .asciiz "\nEsse número é par"
	is_impar_msg: .asciiz "\nEsse número é ímpar"
	numero: .word 0
	
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, numero
	lw $t0, numero
	li, $t1, 2

	div $t0, $t1 # resto armazenado em hi e quociente armazenado em lo.
	
	mfhi $t2
	
	beqz $t2, is_par
	
	j is_impar
	
is_par:
	la $a0, is_par_msg
	li $v0, 4
	syscall
	
	j finaliza_programa

is_impar:
	la $a0, is_impar_msg
	li $v0, 4
	syscall
	
	j finaliza_programa

finaliza_programa:
	li $v0, 10
	syscall