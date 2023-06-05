.data 
	menu_msg: .asciiz "Esse será o texto do menu"
  response_msg: .asciiz "O resultado da operação é: "
  exit_msg: .asciiz "Obrigado por usar a calculadora"

.text
.globl main

main:
  j while

while:
  # Aqui será o laço que roda o programa
  # O usuário escolhe a operação que deseja realizar
  # O usuário escolhe os dois números que deseja realizar a operação
  # O programa chama a função da operação escolhida

soma:
  # Realiza a soma dos dois números
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

  li $v0, 1
  syscall

  j while

exit:
  li $v0, 4
  la $a0, exit_msg
  syscall

  li $v0, 10
  syscall
