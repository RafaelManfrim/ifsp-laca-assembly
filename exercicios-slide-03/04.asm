# Calcular o fatorial de um número

.data
	alert: .asciiz "O programa só acerta o fatorial até 12.\n"
	msg: .asciiz "Digite o número que será calculado o fatorial: "
	response_msg: .asciiz "\nO fatorial desse número é: "
	resultado: .word 1
	
.text
.globl main

main:
	la $a0, alert
	li $v0, 4
	syscall
	
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0 # Coloca em $t0 o número que encontraremos o fatorial
	
	jal loop # Entra no loop

loop:
	beqz $t0, finaliza_programa
	
	lw $t1, resultado # Busca o resultado parcial das multiplicações
	mul $t2, $t0, $t1 # Realiza a multiplicação do número atual pelo resultado parcial
	sw $t2, resultado # Coloca de volta no resultado parcial
	
	addi $t0, $t0, -1 # Diminui 1 do número para a próxima execução do loop
	
	jr $ra # Volta para o início do loop

finaliza_programa:
	la $a0, response_msg
	li $v0, 4
	syscall
	
	li $v0, 1
	lw $a0, resultado
	syscall
	
	li $v0, 10
	syscall
