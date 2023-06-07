.data 
  welcome_msg: .asciiz "Bem víndo a calculadora em Assembly MIPS\n"

	menu_msg: .asciiz "Escolha a operação que deseja realizar:\nA - Adição\nS - Subtração\nM - Multiplicação\nD - Divisão\nP - Potenciação\nF - Fechar\nDigite o número da operação: "
  
  character_error_msg: .asciiz "Digite uma opção válida\n"

  first_num_msg: .asciiz "Digite o primeiro número: "
  second_num_msg: .asciiz "Digite o segundo número: "

  blank_line: .asciiz "\n\n"

  response_msg: .asciiz "O resultado da operação é: "
  exit_msg: .asciiz "Obrigado por usar a calculadora!"

.text
.globl main

main:
  # Mostra a mensagem de boas vindas
  li $v0, 4
  la $a0, welcome_msg
  syscall

  j while

while:
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

  li $t3, 'F'
  beq $t0, $t3, exit

  li $t3, 'f'
  beq $t0, $t3, exit

  # Se o usuário escolher a opção A, o programa vai para a função adicao

  li $t3, 'A'
  beq $t0, $t3, adicao

  li $t3, 'a'
  beq $t0, $t3, adicao

  # Se o usuário escolher a opção S, o programa vai para a função subtracao

  # Se o usuário escolher a opção M, o programa vai para a função multiplicacao

  # Se o usuário escolher a opção D, o programa vai para a função divisao

  # Se o usuário escolher a opção P, o programa vai para a função potencia

  # Se o usuário escolher uma opção inválida, o programa volta para o começo do while
  li $v0, 4
  la $a0, character_error_msg
  syscall

  j while

adicao:
  # Chama a função que solicita os números
  jal solicita_numeros
  
  # Realiza a adição dos dois números
  add $t4, $t1, $t2

  # Chama a função que imprime o resultado
  j print_result

subtracao:
  # Chama a função que solicita os números
  # Realiza a subtração dos dois números
  # Chama a função que imprime o resultado
  j print_result

multiplicacao:
  # Chama a função que solicita os números
  # Realiza a multiplicação dos dois números
  # Chama a função que imprime o resultado
  j print_result

divisao:
  # Chama a função que solicita os números
  # Entre num while que verifica se o segundo número é 0 e só libera o programa se não for
  # Realiza a divisão dos dois números
  # Chama a função que imprime o resultado
  j print_result

potencia:
  # Chama a função que solicita os números
  # Realiza a potenciação dos dois números
  # Chama a função que imprime o resultado
  j print_result

solicita_numeros:
  # Solicita o primeiro número
  li $v0, 4
  la $a0, first_num_msg
  syscall

  # Lê o primeiro número
  li $v0, 5
  syscall

  # Salva o primeiro número em $t1
  move $t1, $v0

  # Solicita o segundo número
  li $v0, 4
  la $a0, second_num_msg
  syscall

  # Lê o segundo número
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
  move $a0, $t4
  li $v0, 1
  syscall

  # Imprime uma linha em branco
  li $v0, 4
  la $a0, blank_line
  syscall

  # Reinicia a calculadora
  j while

exit:
  # Mostra a mensagem de saída
  li $v0, 4
  la $a0, exit_msg
  syscall

  # Encerra o programa
  li $v0, 10
  syscall
