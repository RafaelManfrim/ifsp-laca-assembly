# SOMANDO 3 NÚMEROS

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
	lw $t1, num2
	lw $t2, num3
	
	add $t3, $t0, $t1
	add $t3, $t3, $t2
	la $t4, result
	sw $t3, 0($t4)
	
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
