# SOMANDO 3 NÚMEROS COM 2 REGISTRADORES

.data
num1: .word 5
num2: .word 7
num3: .word -3
result: .word 0
msg: .asciiz "O resultado da soma é: "

.text 
.globl main

main:
	# Fazendo a soma e armazenando o resultado
	lw $t0, num1
	add $t1, $t1, $t0
	lw $t0, num2
	add $t1, $t1, $t0
	lw $t0, num3
	add $t1, $t1, $t0
	sw $t1, result
	
	# Impressão da string msg
	li $v0, 4
	la $a0, msg
	syscall
	
	# Impressão do resultado da soma
	li $v0, 1
	lw $a0, result
	syscall
	
	# Finalizado o programa
	li $v0, 10
	syscall 
