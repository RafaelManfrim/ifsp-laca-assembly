.data 
  welcome_msg: .asciiz "Bem víndo a calculadora em Assembly MIPS\n"
	menu_msg: .asciiz "Escolha a operação que deseja realizar:\nA - Adição\nS - Subtração\nM - Multiplicação\nD - Divisão\nP - Potenciação\nF - Fechar\nDigite o número da operação: "

  first_num_msg: .asciiz "Digite o primeiro número: "
  second_num_msg: .asciiz "Digite o segundo número: "

  blank_line: .asciiz "\n\n"

  response_msg: .asciiz "O resultado da operação é: "
  exit_msg: .asciiz "Obrigado por usar a calculadora"

.text
.globl main

main:
  li $v0, 4
  la $a0, welcome_msg
  syscall

  j while

while:
  li $v0, 4
  la $a0, menu_msg
  syscall

  li $v0, 12
  syscall

  move $t0, $v0

  # Se o usuário escolher a opção F, o programa sai

  li $t3, 'F'
  beq $t0, $t3, exit

  li $t3, 'f'
  beq $t0, $t3, exit

  # Se o usuário escolher uma opção inválida, o programa volta para o começo do while

  # blt $t0, 1, while
  # bgt $t0, 6, while

  # O usuário escolhe os dois números que deseja realizar a operação

  li $v0, 4
  la $a0, first_num_msg
  syscall

  li $v0, 5
  syscall

  move $t1, $v0

  li $v0, 4
  la $a0, second_num_msg
  syscall

  li $v0, 5
  syscall

  move $t2, $v0

  li $t3, 'A'
  beq $t0, $t3, adicao

  li $t3, 'a'
  beq $t0, $t3, adicao

  # O programa chama a função da operação escolhida

adicao:
  add $t4, $t1, $t2

  j print_result

subtracao:
  # Realiza a subtração dos dois números
  j print_result

multiplicacao:
  # Realiza a multiplicação dos dois números
  j print_result

divisao:
  # Entre num while que verifica se o segundo número é 0 e só libera o programa se não for
  # Realiza a divisão dos dois números
  j print_result

potencia:
  # Realiza a potenciação dos dois números
  j print_result

print_result:
  li $v0, 4
  la $a0, response_msg
  syscall

  move $a0, $t4
  li $v0, 1
  syscall

  li $v0, 4
  la $a0, blank_line
  syscall

  j while

exit:
  li $v0, 4
  la $a0, exit_msg
  syscall

  li $v0, 10
  syscall
