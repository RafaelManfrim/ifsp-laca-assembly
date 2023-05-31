# Verificar se um número é primo

.data
	msg: .asciiz "Digite um número positivo: "
	primo_msg: .asciiz "\nEsse número é primo."
	nao_primo_msg: .asciiz "\nEsse número não é primo."
	
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	move $t0, $v0 # Variável que armazena o número digitado

	li $t1, 1 # Variável de controle do laço
	li $t2, 0	# Variável de quantidade de divisores

	jal loop

loop:
	bgt $t1, $t0, finaliza_loop	# if $t1 > $t0 then goto finaliza_loop
	
	div $t0, $t1
	mfhi $t3

	beqz $t3, soma_divisores	# if $t3 == 0 then goto soma_divisores
	
	addi $t1, $t1, 1

	jr $ra

soma_divisores:
	addi $t2, $t2, 1
	addi $t1, $t1, 1

	j loop

finaliza_loop:
	beq $t2, 2, primo	# if $t2 == 2 then goto primo

	j nao_primo	# else goto nao_primo
	
primo:
	la $a0, primo_msg
	j finaliza_programa
	
nao_primo:
	la $a0, nao_primo_msg
	j finaliza_programa
	
finaliza_programa:
	li $v0, 4
	syscall

	li $v0, 10
	syscall
