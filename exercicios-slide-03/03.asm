# Calcular a soma dos números de 1 a 10

.data
	response_msg: .asciiz "A soma dos números de 1 a 10 é: "
	soma: .word 0 
.text
.globl main

main:
	li $t0, 10 # $t0 guarda o total de execuções que serão realizadas
	li $t1, 1 # $t1 guarda o numero da execução atual
	
	jal loop # Entra no loop
	
loop:
	bgt $t1, $t0, finaliza_programa # exec_number > total_execs, chama finaliza_programa
	
	lw $t3, soma # Busca a soma atual
	add $t3, $t3, $t1 # Soma com o número da execução atual
	sw $t3, soma # Guarda na variável soma
	
	addi $t1, $t1, 1 # Adiciona 1 a quantidade de execuções
	
	jr $ra # Volta para o início do loop
	
finaliza_programa:
	la $a0, response_msg
	li $v0, 4
	syscall
	
	li $v0, 1
	lw $a0, soma
	syscall
	
	li $v0, 10
	syscall
