.data 
	welcome_msg: .asciiz "Bem vindo � calculadora em Assembly MIPS\n"

	menu_msg: .asciiz "Escolha a opera��o que deseja realizar:\nA - Adi��o\nS - Subtra��o\nM - Multiplica��o\nD - Divis�o\nP - Potencia��o\nF - Fechar\nEscolha a opera��o: "
	
	character_error_msg: .asciiz "Digite uma op��o v�lida\n"

	first_num_msg: .asciiz "\nDigite o primeiro n�mero: "
	second_num_msg: .asciiz "Digite o segundo n�mero: "

	blank_line: .asciiz "\n\n"

	response_msg: .asciiz "O resultado da opera��o �: "
	exit_msg: .asciiz "\nObrigado por usar a calculadora!"
	
	verifica_segundo_numero_error_msg: .asciiz "O segundo n�mero � zero, por favor digite outro\n"

.text
.globl main

main:
	# Mostra a mensagem de boas vindas
	li $v0, 4
	la $a0, welcome_msg
	syscall

app:
	# Mostra o menu de op��es
	li $v0, 4
	la $a0, menu_msg
	syscall

	# L� a op��o escolhida pelo usu�rio
	li $v0, 12
	syscall

	# Salva a op��o escolhida pelo usu�rio em $t0
	move $t0, $v0

	# Se o usu�rio escolher a op��o F, o programa sai
	beq $t0, 'F', exit
	beq $t0, 'f', exit

	# Se o usu�rio escolher a op��o A, o programa vai para a fun��o adicao
	beq $t0, 'A', adicao
	beq $t0, 'a', adicao

	# Se o usu�rio escolher a op��o S, o programa vai para a fun��o subtracao
	beq $t0, 'S', subtracao
	beq $t0, 's', subtracao

	# Se o usu�rio escolher a op��o M, o programa vai para a fun��o multiplicacao
	beq $t0, 'M', multiplicacao
	beq $t0, 'm', multiplicacao

	# Se o usu�rio escolher a op��o D, o programa vai para a fun��o divisao
	beq $t0, 'D', divisao
	beq $t0, 'd', divisao
	
	# Se o usu�rio escolher a op��o P, o programa vai para a fun��o potencia
	beq $t0, 'P', potencia
	beq $t0, 'p', potencia
	
	# Se o usu�rio escolher uma op��o inv�lida, o programa volta para o come�o do while
	li $v0, 4
	la $a0, character_error_msg
	syscall

	j app

adicao:
	# Chama a fun��o que solicita os n�meros
	jal solicita_numeros
	
	add $t3, $t1, $t2

	# Chama a fun��o que imprime o resultado
	j print_result

subtracao:
	jal solicita_numeros
	
	sub $t3, $t1, $t2
	
	j print_result

multiplicacao:
	jal solicita_numeros
	
	# Realiza a multiplica��o dos dois n�meros
	mul $t3, $t1, $t2
	
	j print_result

divisao:
	jal solicita_numeros
	
	# Entre num loop que verifica se o segundo n�mero � 0 e s� libera o programa se n�o for
	verifica_segundo_numero:
		bne $t2, $zero, continuar
		li $v0, 4
		la $a0, verifica_segundo_numero_error_msg
		syscall
		
		# Solicita o segundo n�mero
		li $v0, 4
		la $a0, second_num_msg
		syscall

		# L� o segundo n�mero
		li $v0, 5
		syscall

		# Salva o segundo n�mero em $t2
		move $t2, $v0
		
		j verifica_segundo_numero
		
	continuar: 
		# Realiza a divis�o dos dois n�meros
		div $t1, $t2
		mflo $t3
		
		j print_result

potencia:
	jal solicita_numeros
	
	li $t3, 1
	
	j while
	
	# Realiza a potencia��o dos dois n�meros
	while:
		# Verifica se o segundo n�mero � 0 e chama a fun��o que imprime o resultado
		beqz $t2, print_result
		
		# Multiplicar o resultado parcial pela base e armazenar
		mult $t3, $t1
  		mflo $t3
		
		# Decrementa o expoente
		addi $t2, $t2, -1
		
		# Volta para o while
		j while

solicita_numeros:
	# Solicita e l� o primeiro n�mero
	li $v0, 4
	la $a0, first_num_msg
	syscall

	li $v0, 5
	syscall

	# Salva o primeiro n�mero em $t1
	move $t1, $v0

	# Solicita e l� o segundo n�mero
	li $v0, 4
	la $a0, second_num_msg
	syscall

	li $v0, 5
	syscall

	# Salva o segundo n�mero em $t2
	move $t2, $v0

	# Retorna para a fun��o que chamou
	jr $ra

print_result:
	# Mostra a mensagem de impress�o do resultado
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
	# Mostra a mensagem de sa�da
	li $v0, 4
	la $a0, exit_msg
	syscall

	# Encerra o programa
	li $v0, 10
	syscall
