# Lendo uma string

# read_string: $v0 = 8
# $a0 = endereço do buffer onde estará a string
# $a1 = tamanho máximo da string no buffer
# buffer é uma área de memória reservada para armazenar temporáriamente dados

.data
	buffer: .space 64
	msg: .asciiz "Digite uma string: " 
	resp: .asciiz "A string digitada é: "

.text 
.globl main
	
main:
	la $a0, msg
	li $v0, 4
	syscall
	
	la $a0, buffer
	li $a1, 64
	li $v0, 8
	syscall
	
	la $a0, resp
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, buffer
	syscall 
	
	li $v0, 10
	syscall
