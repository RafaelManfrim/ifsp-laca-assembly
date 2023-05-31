# Inversão de uma string

.data
	msg: .asciiz "Digite uma frase: "
	resp: .asciiz "A string digitada invertida é: "
	input:	.space	256
	output:	.space	256
	
.text
.globl main

main:
	la $a0, msg
	li $v0, 4
	syscall

	li	$v0, 8
	la	$a0, input
	li	$a1, 256
	syscall

	jal string_lenght

	move $t1, $v0 # Tamanho da string
	move $t2, $a0 # Endereço da string
	
	li	$t0, 0 # Contador
	li	$t3, 0 # Endereço da string + contador
	
	reverse_loop:
		add	$t3, $t2, $t0		# Soma o contador com o endereço da string
		lb	$t4, 0($t3)		# Carrega o byte da string na posição $t3
		beqz	$t4, exit		# Se chegar no final da string, sai do loop
		sb	$t4, output($t1)		# Guarda o byte no array de output
		addi	$t1, $t1, -1		# Decrementa o tamanho total da string restante
		addi	$t0, $t0, 1		# Incrementando o contador
		j	reverse_loop		# Voltando para o loop

string_lenght:
	li	$t0, 0 # Contador do tamanho da string
	li	$t2, 0
	
	string_lenght_loop:
		add	$t2, $a0, $t0
		lb	$t1, 0($t2)
		beqz	$t1, string_lenght_exit
		addi	$t0, $t0, 1
		j	string_lenght_loop
		
	string_lenght_exit:
		addi	$t0, $t0, -1
		move $v0, $t0
		li $t0, 0
		jr	$ra
	
exit:
	li	$v0, 4
	la	$a0, resp
	syscall

	li	$v0, 4
	la	$a0, output
	syscall
		
	li	$v0, 10
	syscall
