; -----------------------------------------------
; TESTE INTRUÇÕES
; -----------------------------------------------
; Neste código são testadas diversas instruções de uma arquitetura do processador do ICMC. 
; O objetivo é verificar o comportamento e funcionamento das operações aritméticas, lógicas e de controle, como:
; - Carregamento e armazenamento de valores em registradores e memória (load, store, loadn, storei, loadi)
; - Execução de operações aritméticas (add, sub, mul, div)
; - Operações lógicas (and, or, xor)
; - Controle de fluxo (cmp, jgr, jmp, call, rts)
; - Manipulação de pilha (push, pop)
;
; O código testa a execução dessas instruções sequencialmente, exibindo resultados quando for rodado no Simple Simulator
; OBS: mais informações podem ser obtidas em link documentação
; 
; -----------------------------------------------
; -> INICIO DOS TESTES
; -----------------------------------------------

; 	TESTE LOADN 
; 	Descrição: O valor #0 é carregado em r0, e o valor ASCII de 'A' é carregado em r1, que é então exibido na tela.
	loadn r0, #0		
	loadn r1, #'A'		
	outchar r1, r0	
	
	
	; TESTE LOAD 
	; Carrega o valor 2 no registrador r0 (linha de saída). O valor armazenado em "Dado" é carregado no registrador r1 e exibido na tela
	loadn r0, #2
	load r1, Dado
	outchar r1, r0
	
	; TESTE STORE  
	; O valor 'C' é carregado em r1 e armazenado na variável "Dado". O valor armazenado em "Dado" é carregado em r2 e exibido.
	loadn r1, #'C'
	store Dado, r1
	load r2, Dado
	loadn r0, #4
	outchar r2, r0
	
	; TESTE STOREI, LOADI (dar uma olhada melhor)
	; O endereço de memória de "Dado" é carregado em r1, o valor ASCII de 'D' no registrador r0 e o valor de r0 ('D') é carregado em r2 e exibido.

	loadn r1, #Dado
	loadn r0, #'D'
	storei r1, r0
	loadi r2, r1
	loadn r0, #6
	outchar r2, r0
	
	; TESTE MOVE  
	; Carregamos 'E' em r1, movemos o valor de r1 para r2. Ccarregamos o valor 8 no r0 e o valor de r2 ('E')é enviado para a saída na linha 8.
	loadn r1, #'E'
	mov r2, r1
	loadn r0, #8
	outchar r2, r0
	
	; TESTE ADD  
	;Carrega o valor ASCII de 'E' no registrador r1 e o valor 1 em r2. Somamos r1 + r2 e armazenamos em r3
	loadn r1, #'E' 		; ascii de E é 69
	loadn r2, #1	
	add r3, r1, r2 		; o resultado será 70
	loadn r0, #10
	outchar r3, r0		; Printa F na linha 10
	
	; TESTE SUB  
	; similar à add
	loadn r1, #'H'
	loadn r2, #1
	sub r3, r1, r2
	loadn r0, #12
	outchar r3, r0		; Printa G na linha 12

	; TESTE MULT  ( ver melhor dps)
	loadn r1, #3        ; Carrega o valor 3 no registrador r1.
	loadn r2, #2        ; Carrega o valor 2 no registrador r2.
	mul r3, r1, r2      ; Multiplica os valores de r1 e r2 (3 * 2 = 6) e armazena o resultado em r3.
	loadn r4, #'B'      ; Carrega o valor ASCII de 'B' em r4.
	add r3, r4, r3      ; Soma o valor de r4 ('B' = 66) com o resultado da multiplicação (6), resultando em 72.
	loadn r0, #14       ; Carrega o valor 14 no registrador r0 (linha de saída).
	outchar r3, r0      ; Envia o valor de r3 (72 -> 'H') para a saída na linha 14.

	; Teste do Div
	loadn r1, #6        ; Carrega o valor 6 no registrador r1.
	loadn r2, #2        ; Carrega o valor 2 no registrador r2.
	div r3, r1, r2      ; Divide r1 por r2 (6 / 2 = 3) e armazena o resultado em r3.
	loadn r4, #'F'      ; Carrega o valor ASCII de 'F' em r4.
	add r3, r4, r3      ; Soma o valor de r4 ('F' = 70) com o resultado da divisão (3), resultando em 73.
	loadn r0, #16       ; Carrega o valor 16 no registrador r0 (linha de saída).
	outchar r3, r0      ; Envia o valor de r3 (73 -> 'I') para a saída na linha 16.

	; Teste do Inc / Dec
	loadn r0, #18       ; Carrega o valor 18 no registrador r0 (linha de saída).
	loadn r3, #'K'      ; Carrega o valor ASCII de 'K' no registrador r3.
	inc r3              ; Incrementa o valor de r3 ('K' = 75) para 76 ('L').
	dec r3              ; Decrementa o valor de r3 (76 -> 75, 'K').
	dec r3              ; Decrementa novamente (75 -> 74, 'J').
	outchar r3, r0      ; Envia o valor de r3 (74 -> 'J') para a saída na linha 18.

	; Teste do And
	loadn r1, #254      ; Carrega o valor 254 no registrador r1.
	loadn r2, #5        ; Carrega o valor 5 no registrador r2.
	and r3, r1, r2      ; Faz a operação lógica AND entre r1 e r2 (254 & 5 = 4) e armazena em r3.
	loadn r4, #'G'      ; Carrega o valor ASCII de 'G' em r4.
	add r3, r4, r3      ; Soma o valor de r4 ('G' = 71) com o resultado da operação AND (4), resultando em 75.
	loadn r0, #20       ; Carrega o valor 20 no registrador r0 (linha de saída).
	outchar r3, r0      ; Envia o valor de r3 (75 -> 'K') para a saída na linha 20.

	; Teste do Or
	loadn r1, #4        ; Carrega o valor 4 no registrador r1.
	loadn r2, #3        ; Carrega o valor 3 no registrador r2.
	or r3, r1, r2       ; Faz a operação lógica OR entre r1 e r2 (4 | 3 = 7) e armazena em r3.
	loadn r4, #'E'      ; Carrega o valor ASCII de 'E' em r4.
	add r3, r4, r3      ; Soma o valor de r4 ('E' = 69) com o resultado da operação OR (7), resultando em 76.
	loadn r0, #22       ; Carrega o valor 22 no registrador r0 (linha de saída).
	outchar r3, r0      ; Envia o valor de r3 (76 -> 'L') para a saída na linha 22.

	; Teste do Xor
	loadn r1, #5        ; Carrega o valor 5 no registrador r1.
	loadn r2, #3        ; Carrega o valor 3 no registrador r2.
	xor r3, r1, r2      ; Faz a operação lógica XOR entre r1 e r2 (5 ^ 3 = 6) e armazena em r3.
	loadn r4, #'G'      ; Carrega o valor ASCII de 'G' em r4.
	add r3, r4, r3      ; Soma o valor de r4 ('G' = 71) com o resultado da operação XOR (6), resultando em 77.
	loadn r0, #24       ; Carrega o valor 24 no registrador r0 (linha de saída).
	outchar r3, r0      ; Envia o valor de r3 (77 -> 'M') para a saída na linha 24.
	
	; Teste do CMP e JMP
	loadn r0, #26       ; Carrega o valor 26 no registrador r0 (linha de saída).
	loadn r1, #5        ; Carrega o valor 5 no registrador r1.
	loadn r2, #3        ; Carrega o valor 3 no registrador r2.
	loadn r3, #'X'      ; Carrega o valor ASCII de 'X' no registrador r3.
	loadn r4, #'N'      ; Carrega o valor ASCII de 'N' no registrador r4.
	cmp r1, r2          ; Compara os valores de r1 e r2.
	jgr Maior           ; Se r1 > r2, pula para a etiqueta Maior.
	outchar r3, r0      ; Caso contrário, imprime 'X' na linha 26.
	jmp SaiJMP          ; Pula para a etiqueta SaiJMP.

	Maior:
	outchar r4, r0      ; Imprime 'N' na linha 26 se r1 > r2.
	jmp SaiJMP          ; Pula para a etiqueta SaiJMP.

	SaiJMP:

	; TESTE CALL e RTS  
	loadn r0, #28         ; Carrega o valor 28 (linha onde será exibido o caractere) no registrador r0
	loadn r1, #5          ; Carrega o valor 5 no registrador r1
	loadn r2, #3          ; Carrega o valor 3 no registrador r2
	loadn r3, #'O'        ; Carrega o caractere 'O' no registrador r3 (será impresso em CallMaior)
	loadn r4, #'X'        ; Carrega o caractere 'X' no registrador r4 (será impresso em CallMenorIgual)

	cmp r1, r2            ; Compara os valores de r1 e r2
	cgr CallMaior         ; Se r1 > r2, vai para o label CallMaior
	cel CallMenorIgual    ; Se r1 <= r2, vai para o label CallMenorIgual

	jmp CallSai           ; Se nenhum dos testes foi verdadeiro, pula para CallSai
	
CallMaior: 
	outchar r3, r0        ; Imprime o valor de r3 ('O') na linha 28
	rts                   ; Retorna da sub-rotina e volta para o ponto de chamada

CallMenorIgual:
	outchar r4, r0        ; Imprime o valor de r4 ('X') na linha 28
	rts                   ; Retorna da sub-rotina e volta para o ponto de chamada

CallSai:

	; TESTE PUSH e POP   
	loadn r0, #30         ; Carrega o valor 30 (linha onde será impresso o caractere) no registrador r0
	loadn r1, #'P'        ; Carrega o caractere 'P' no registrador r1
	push r1               ; Empilha o valor de r1 (caractere 'P')

	pop r2                ; Desempilha o valor da pilha e coloca em r2
	outchar r2, r0        ; Imprime o valor de r2 (caractere 'P') na linha 30
		
	
Fim:	
	halt

	
Dado : var #1  ; O comando VAR aloca bytes de memoria e associa o primeiro byte ao LABEL
static Dado + #0, #'B'

	
	
;4 Perguntas ao implemantar as instrucoes: TIRAR? 
;	1) O Que preciso fazer para esta instrucao?
;	2) Onde Comeca: Pegargcc o que tem que fazer e ir voltando ate' chegar em um registrador (ie. PC)
;	3) Qual e' a Sequencia de Operacoes: Descrever todos os comandos que tem que dar nos cilos de Dec e Exec
;	4) Ja' terminou??? Cumpriu o que tinha que fazer??? O PC esta' pronto para a proxima instrucao (cuidado com Load, Loadn, Store, Jmp, Call)