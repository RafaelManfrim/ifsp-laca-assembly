.data 
	welcome_msg: .asciiz "Bem vindo à calculadora em Assembly MIPS\n"

	menu_msg: .asciiz "Escolha a operação que deseja realizar:\nA - Adição\nS - Subtração\nM - Multiplicação\nD - Divisão\nP - Potenciação\nF - Fechar\nEscolha a operação: "
	
	character_error_msg: .asciiz "Digite uma opção válida\n"

	first_num_msg: .asciiz "\nDigite o primeiro número: "
	second_num_msg: .asciiz "Digite o segundo número: "

	blank_line: .asciiz "\n\n"

	response_msg: .asciiz "O resultado da operação é: "
	exit_msg: .asciiz "\nObrigado por usar a calculadora!"
	
	verifica_segundo_numero_error_msg: .asciiz "O segundo número é zero, por favor digite outro\n"

.text
.globl main

main:
	# Mostra a mensagem de boas vindas
	li $v0, 4
	la $a0, welcome_msg
	syscall

app:
	# Mostra o menu de opções
	li $v0, 4
	la $a0, menu_msg
	syscall

	# Lê a opção escolhida pelo usuário
	li $v0, 12
	syscall

	# Salva a opção escolhida pelo usuário em $t0
	move $t0, $v0

	# Se o usuário escolher a opção F, o programa sai
	beq $t0, 'F', exit
	beq $t0, 'f', exit

	# Se o usuário escolher a opção A, o programa vai para a função adicao
	beq $t0, 'A', adicao
	beq $t0, 'a', adicao

	# Se o usuário escolher a opção S, o programa vai para a função subtracao
	beq $t0, 'S', subtracao
	beq $t0, 's', subtracao

	# Se o usuário escolher a opção M, o programa vai para a função multiplicacao
	beq $t0, 'M', multiplicacao
	beq $t0, 'm', multiplicacao

	# Se o usuário escolher a opção D, o programa vai para a função divisao
	beq $t0, 'D', divisao
	beq $t0, 'd', divisao
	
	# Se o usuário escolher a opção P, o programa vai para a função potencia
	beq $t0, 'P', potencia
	beq $t0, 'p', potencia
	
	# Se o usuário escolher uma opção inválida, o programa volta para o começo do while
	li $v0, 4
	la $a0, character_error_msg
	syscall

	j app

adicao:
	# Chama a função que solicita os números
	jal solicita_numeros
	
	add $t3, $t1, $t2

	# Chama a função que imprime o resultado
	j print_result

subtracao:
	jal solicita_numeros
	
	sub $t3, $t1, $t2
	
	j print_result

multiplicacao:
	jal solicita_numeros
	
	# Realiza a multiplicação dos dois números
	mul $t3, $t1, $t2
	
	j print_result

divisao:
	jal solicita_numeros
	
	# Entre num loop que verifica se o segundo número é 0 e só libera o programa se não for
	verifica_segundo_numero:
		bne $t2, $zero, continuar
		li $v0, 4
		la $a0, verifica_segundo_numero_error_msg
		syscall
		
		# Solicita o segundo número
		li $v0, 4
		la $a0, second_num_msg
		syscall

		# Lê o segundo número
		li $v0, 5
		syscall

		# Salva o segundo número em $t2
		move $t2, $v0
		
		j verifica_segundo_numero
		
	continuar: 
		# Realiza a divisão dos dois números
		div $t1, $t2
		mflo $t3
		
		j print_result

potencia:
	jal solicita_numeros
	
	li $t3, 1
	
	j while
	
	# Realiza a potenciação dos dois números
	while:
		# Verifica se o segundo número é 0 e chama a função que imprime o resultado
		beqz $t2, print_result
		
		# Multiplicar o resultado parcial pela base e armazenar
		mult $t3, $t1
  		mflo $t3
		
		# Decrementa o expoente
		addi $t2, $t2, -1
		
		# Volta para o while
		j while

solicita_numeros:
	# Solicita e lê o primeiro número
	li $v0, 4
	la $a0, first_num_msg
	syscall

	li $v0, 5
	syscall

	# Salva o primeiro número em $t1
	move $t1, $v0

	# Solicita e lê o segundo número
	li $v0, 4
	la $a0, second_num_msg
	syscall

	li $v0, 5
	syscall

	# Salva o segundo número em $t2
	move $t2, $v0

	# Retorna para a função que chamou
	jr $ra

print_result:
	# Mostra a mensagem de impressão do resultado
	li $v0, 4
	la $a0, response_msg
	syscall

	# Imprime o resultado
	move $a0, $t3
	li $v0, 1
	syscall

	# Imprime uma linha em branco
	li $v0, 4
	la $a0, blank_line
	syscall

	# Reinicia a calculadora
	j app

exit:
	# Mostra a mensagem de saída
	li $v0, 4
	la $a0, exit_msg
	syscall

	# Encerra o programa
	li $v0, 10
	syscall
