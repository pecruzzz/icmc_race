CARRINHOPosition: var #1
carrofederupaPosition : var #1
loadn R4, #40 ; N° de colunas

msgPontuacao: string "metros"
msgLose: string "Seu carro bateu em alta velocidade, seu bração!                                                                                        Deseja jogar novamente?                         [s]/[n]"


main:

  loadn r1, #0			; Contador do vetor de posições de objetos
  loadn r2, #0			; Contador da pontuação
  loadn r3, #2000		; Limite da pontuação	

  call ApagaTela
  call ImprimeMenu
  call ImprimePista
  call LoadVector
  
  loadn R0, #521 ;posicao inicial do carrinho 
  store CARRINHOPosition, r0    ; inicia o carrinho na posicao



  loop:
    call Delay
    call printaPontuacao
    inc r2
    cmp r2, r3
    jeq main
    call printObj
    call MoveCarrinho
    jmp loop

halt


;----------------------------------------------

;********************************************************
;                      FUNÇÔES CARRRINHO
;********************************************************

;carrinho
  CARRINHO : var #16
  static CARRINHO + #0, #2854 ;   
  static CARRINHO + #1, #2857 ;   
  static CARRINHO + #2, #2859 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #3, #2857 ;   
  static CARRINHO + #4, #2854 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #5, #2855 ;   
  static CARRINHO + #6, #2856 ;   
  static CARRINHO + #7, #2862 ;   
  static CARRINHO + #8, #2863 ;   
  static CARRINHO + #9, #2860 ;   
  static CARRINHO + #10, #2854 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #11, #2854 ;   
  static CARRINHO + #12, #2858 ;   
  static CARRINHO + #13, #2861 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #14, #2858 ;   
  static CARRINHO + #15, #2854 ;   

CARRINHOGaps : var #16
  static CARRINHOGaps + #0, #0
  static CARRINHOGaps + #1, #0
  static CARRINHOGaps + #2, #0
  static CARRINHOGaps + #3, #1
  static CARRINHOGaps + #4, #0
  static CARRINHOGaps + #5, #34
  static CARRINHOGaps + #6, #0
  static CARRINHOGaps + #7, #0
  static CARRINHOGaps + #8, #0
  static CARRINHOGaps + #9, #0
  static CARRINHOGaps + #10, #0
  static CARRINHOGaps + #11, #34
  static CARRINHOGaps + #12, #0
  static CARRINHOGaps + #13, #0
  static CARRINHOGaps + #14, #1
  static CARRINHOGaps + #15, #0

printCARRINHO:
  push R0
  push R1
  push R2
  push R3
  push R4
  push R5
  push R6

  loadn R0, #CARRINHO
  loadn R1, #CARRINHOGaps
  load R2, CARRINHOPosition
  loadn R3, #16 ;tamanho CARRINHO
  loadn R4, #0 ;incremetador

  printCARRINHOLoop:
    add R5,R0,R4
    loadi R5, R5

    add R6,R1,R4
    loadi R6, R6

    add R2, R2, R6

    outchar R5, R2

    inc R2
     inc R4
     cmp R3, R4
    jne printCARRINHOLoop

  pop R6
  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  pop R0
  rts

apagarCARRINHO:
  push R0
  push R1
  push R2
  push R3
  push R4
  push R5

  loadn R0, #3967
  loadn R1, #CARRINHOGaps
  load R2, CARRINHOPosition
  loadn R3, #16 ;tamanho CARRINHO
  loadn R4, #0 ;incremetador

  apagarCARRINHOLoop:
    add R5,R1,R4
    loadi R5, R5

    add R2,R2,R5
    outchar R0, R2

    inc R2
     inc R4
     cmp R3, R4
    jne apagarCARRINHOLoop

  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  pop R0
  
  rts

  MoveCarrinho:

	push r1 
	push r2
	push r3

  loadn r2, #'w'
  loadn r3, #'s'
  
  call printCARRINHO

  inchar r1
  cmp r1, r2
  ceq MoveCarrinhoUp
  cmp r1, r3
  ceq MoveCarrinhoDown

  pop r3
  pop r2
  pop r1

rts 

MoveCarrinhoUp:
  push r1
  push r2

  loadn r1, #40
  div r1, r0, r1
  loadn r2, #6
  cmp r2, r1
  jeq NaoMove
  call apagarCARRINHO
  sub r0, r0, r4
  store CARRINHOPosition, r0
  call printCARRINHO

  pop r2
  pop r1

rts

MoveCarrinhoDown:
  push r1
  push r2

  loadn r1, #40
  div r1, r0, r1
  loadn r2, #21
  cmp r2, r1  
  jeq NaoMove
  call apagarCARRINHO

  add r0, r0, r4
  store CARRINHOPosition, r0
  call printCARRINHO

  pop r2
  pop r1

rts

NaoMove:
  pop r2
  pop r1
rts


;********************************************************
;                      FUNÇÕES OBJETOS
;********************************************************

rand: var #80				; Vetor de posições aleatórias dos objetos
	static rand + #0, #559
	static rand + #1, #519
	static rand + #2, #479
	static rand + #3, #599
	static rand + #4, #558
	static rand + #5, #557
	static rand + #6, #559
	static rand + #7, #598
	static rand + #8, #478
	static rand + #9, #559
	static rand + #10, #559
	static rand + #11, #639
	static rand + #12, #559
	static rand + #13, #479
	static rand + #14, #559
	static rand + #15, #559
	static rand + #16, #439
	static rand + #17, #559
	static rand + #18, #637
	static rand + #19, #559
	static rand + #20, #559
	static rand + #21, #559
	static rand + #22, #559
	static rand + #23, #559
	static rand + #24, #559
	static rand + #25, #559
	static rand + #26, #559
	static rand + #27, #559
	static rand + #28, #559
	static rand + #29, #559
	static rand + #30, #559
	static rand + #31, #559
	static rand + #32, #559
	static rand + #33, #559
	static rand + #34, #559
	static rand + #35, #559
	static rand + #36, #559
	static rand + #37, #559
	static rand + #38, #559
	static rand + #39, #559
	static rand + #40, #559
	static rand + #41, #559
	static rand + #42, #559
	static rand + #43, #559
	static rand + #44, #559
	static rand + #45, #559
	static rand + #46, #559
	static rand + #47, #559
	static rand + #48, #559
	static rand + #49, #559
	static rand + #50, #559
	static rand + #51, #559
	static rand + #52, #559
	static rand + #53, #559
	static rand + #54, #559
	static rand + #55, #559
	static rand + #56, #559
	static rand + #57, #559
	static rand + #58, #559
	static rand + #59, #559
	static rand + #60, #559
	static rand + #61, #559
	static rand + #62, #559
	static rand + #63, #559
	static rand + #64, #559
	static rand + #65, #559
	static rand + #66, #559
	static rand + #67, #559
	static rand + #68, #559
	static rand + #69, #559
	static rand + #70, #559
	static rand + #71, #559
	static rand + #72, #559
	static rand + #73, #559
	static rand + #74, #559
	static rand + #75, #559
	static rand + #76, #559
	static rand + #77, #559
	static rand + #78, #559
	static rand + #79, #559

objs: var #10				; Vetor que armazena os 10 objetos simultâneos na tela
	static objs + #0, #0
	static objs + #1, #0
	static objs + #2, #0
	static objs + #3, #0
	static objs + #4, #0	
	static objs + #5, #0	
	static objs + #6, #0	
	static objs + #7, #0	
	static objs + #8, #0	
	static objs + #9, #0

LoadVector:				; Funcao que carrega o vetor de 15 objetos

	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r2, #rand			; Carrega r2 com a posicao inicial do vetor de posicoes
	add r2, r2, r1			; Soma com o indice para saber a partir de qual deve-se armazenar
	
	loadn r3, #0			; Inicia o iterador int i
	loadn r4, #10			; Limite do iterador
	loadn r5, #objs			; Armazena a posicao inicial do vetor de objetos

IncLoadVector:

	inc r1
	inc r3            ; i ++
	loadi r6, r2			; Carrega r6 com o valor apontado por r2
	inc r2				; Incrementa r2 para andar com o ponteiro
	storei r5, r6			; Armazena o valor de r6 no vetor de objetos
	inc r5				; Incrementa r5 para andar com o ponteiro
	cmp r3, r4			; Compara se iterador chegou ao fim
	jne IncLoadVector		; Se não, volta para o loop
	
	loadn r2, #80			; Posicao final do vetor de posicoes
	cmp r1, r2			; Comprara com o contador de index
	ceq Reset			; Se for igual, reseta o contador de index
	
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
rts

Reset:
	loadn r1, #0			; Reseta o index para a primeira posicao
rts

printObj:						; Funcao que imprime os objetos
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r1, #0			  ; Inicia o iterador
	loadn r2, #10			  ; Limite do iterador
	loadn r3, #objs			; Armazena o index inicial do vetor de objetos
	loadn r5, #')'			; Armazena o caractere ')' para impressão
	loadn r6, #1			  ; Armazena 1 para decremento
	loadn r7, #' '			; Armazena espaço para apagar objeto
	
incCountPrintObj:
  	call Delay
	loadi r4, r3				; Carrega o valor da posicao de r3 para r4
	call ShouldIEraseOrShouldINot		; Funcao que verifica se o objeto ainda esta na tela
	sub r4, r4, r6				; Subtrai 1 a posicao do objeto
	call ShouldIPrintOrShouldINot		; Funcao que verifica se o objeto ainda esta na tela
	cmp r4, r0				; Compara a ponteiro do objeto com o carro, para saber se houve colisao
	jeq Lose				; Se houve colisao, pula para Lose
	storei r3, r4				; Armazena o novo valor da posicao do objeto
	inc r3					; Incrementa posicao do vetor
	inc r1					; Incrementa iterador
	cmp r1, r2				; Compara se iterador chegou ao fim
	jne incCountPrintObj
	
	loadn r1, #40
	div r2, r4, r1
	sub r4, r4, r6
	div r4, r4, r1
	cmp r4, r2			; Compara se o ultimo objeto chegou ao fim da tela
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	cne LoadVector			; Se chegou, chama a função que carrega o vetor de objetos
rts

ShouldIPrintOrShouldINot:		; Verifica se o objeto ultrapassou a tela, se não, imprime
	push r0
	push r1
  	push r2
  	loadn r1, #40
  	div r0, r3, r1
  	div r1, r4, r1
  	cmp r1, r0
  	jle NotPrint
  	outchar r5, r4
NotPrint:
	pop r2
	pop r1
  	pop r0
rts

ShouldIEraseOrShouldINot: 		; Verifica se o objeto ultrapassou a tela, se não, apaga
  push r0
  push r1
  push r2
  loadn r1, #40
  div r0, r3, r1
  div r1, r4, r1
  cmp r1, r0
  jle NotErase
  outchar r7, r4
NotErase:
  pop r2
  pop r1
  pop r0
rts

;-------------------------------------------------------
;********************************************************
;                       IMPRIME STR
;********************************************************	

Imprimestr:			;  Rotina de Impresao de Mensagens:    
				; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
				; r1 = endereco onde comeca a mensagem
				; r2 = cor da mensagem
				; Obs: a mensagem sera' impressa ate' encontrar "/0"
				
				; Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor				
	push r0			; Posicao da tela que o primeiro caractere da mensagem sera' impresso
	push r1			; endereco onde comeca a mensagem
	push r2			; cor da mensagem
	push r3			; Criterio de parada
	push r4			; Recebe o codigo do caractere da Mensagem
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
	cmp r4, r3		; compara o codigo do caractere buscado com o criterio de parada
	jeq ImprimestrSai	; goto Final da rotina
	add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
	outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
	inc r0			; incrementa a posicao que o proximo caractere sera' escrito na tela
	inc r1			; incrementa o ponteiro para a mensagem na memoria
	jmp ImprimestrLoop	; goto Loop
	
ImprimestrSai:			; Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha

	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
rts

;-------------------------------------------------------

;********************************************************
;                       IMPRIME PONTUAÇÃO
;********************************************************	

printaPontuacao:			 	; Imprime valor do score
	push r0	
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r0, #45     		;Posicao do print na tela
	loadn r1, #10
	loadn r4, #'0'
 	loadn r5, #2816;cor do obj
	
LoopPrintaPontua:
	mod r3, r2, r1
	add r3, r3, r4
	add r3, r3, r5
	outchar r3, r0
	dec r0
	jz StopPrintaPontua
	div r2, r2, r1
	jnz LoopPrintaPontua
	
StopPrintaPontua:
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
rts

printScore:				; Imprime o mensagem de score
	loadn r0, #0
	loadn r1, #msgPontuacao
	loadn r2, #0	
	call Imprimestr
rts

;-------------------------------------------------------

;********************************************************
;                       IMPRIME TELAS
;********************************************************	

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING2
;********************************************************
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
   		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;                       IMPRIME MENU
;********************************************************	

ImprimeMenu:
  push r1
  push r2
  push r3
  push r4

  loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2560  			; cor lima
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

  loadn R1, #tela5Linha0
  loadn r2, #0
  loadn r3, #' '

  call ImprimeTela2

  loopMenu:
  inchar r4

  cmp r4, r3
  jne loopMenu

  call ApagaTela

  pop r4
  pop r3
  pop r2
  pop r1
  rts

;--------------------------------------------------------

;********************************************************
;                       IMPRIME PISTA
;********************************************************	

ImprimePista:

  push r1
  push r2

  loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2560  			; cor lima
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

  loadn R1, #tela2Linha0
  loadn r2, #0

  call ImprimeTela2

  pop r2
  pop r1
  rts



Delay:
  push r0 
	push r2 
	
	loadn r2, #10  ; a
	
  loopi:				; (dois loops de decremento conforme dicas de jogos)
		loadn r0, #3000	; b
  loopj: 
		dec r0 			 
		jnz loopj	
		dec r2
		jnz loopi
	
	pop r2
	pop r0
	
	rts
;********************************************************
;                       FIM DE JOGO
;********************************************************
Lose:
  halt



;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts




;telas
tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha1  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha2  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha3  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha4  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha5  : string "                                        "
tela1Linha6  : string "                                        "
tela1Linha7  : string "                                        "
tela1Linha8  : string "                                        "
tela1Linha9  : string "                                        "
tela1Linha10 : string "                                        "
tela1Linha11 : string "                                        "
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "                                        "
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "                                        "
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "                                        "
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha26 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha27 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha28 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha29 : string "(((((((((((((((((((((((((((((((((((((((("

tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "########################################"
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                                        "
tela2Linha18 : string "                                        "
tela2Linha19 : string "                                        "
tela2Linha20 : string "                                        "
tela2Linha21 : string "                                        "
tela2Linha22 : string "                                        "
tela2Linha23 : string "                                        "
tela2Linha24 : string "########################################"
tela2Linha25 : string "                                        "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "

; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha1  : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha2  : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha3  : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha4  : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha5  : string "########################################"
tela3Linha6  : string "                                        "
tela3Linha7  : string "                                        "
tela3Linha8  : string "                                        "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "                                        "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                                        "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                                        "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "########################################"
tela3Linha25 : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha26 : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha27 : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha28 : string "(((((((((((((((((((((((((((((((((((((((("
tela3Linha29 : string "(((((((((((((((((((((((((((((((((((((((("

; Declara e preenche tela linha por linha (40 caracteres):
tela4Linha0  : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha1  : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha2  : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha3  : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha4  : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha5  : string "########################################"
tela4Linha6  : string "                                     (  "
tela4Linha7  : string "                                    (   "
tela4Linha8  : string "                                     (  "
tela4Linha9  : string "                                    (   "
tela4Linha10 : string "                                     (  "
tela4Linha11 : string "                                    (   "
tela4Linha12 : string "                                     (  "
tela4Linha13 : string "                                    (   "
tela4Linha14 : string "                                     (  "
tela4Linha15 : string "                                    (   "
tela4Linha16 : string "                                     (  "
tela4Linha17 : string "                                    (   "
tela4Linha18 : string "                                     (  "
tela4Linha19 : string "                                    (   "
tela4Linha20 : string "                                     (  "
tela4Linha21 : string "                                    (   "
tela4Linha22 : string "                                     (  "
tela4Linha23 : string "                                    (   "
tela4Linha24 : string "########################################"
tela4Linha25 : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha26 : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha27 : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha28 : string "(((((((((((((((((((((((((((((((((((((((("
tela4Linha29 : string "(((((((((((((((((((((((((((((((((((((((("

; Declara e preenche tela linha por linha (40 caracteres):

tela5Linha0  : string "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
tela5Linha1  : string "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
tela5Linha2  : string "@@                                    @@"
tela5Linha3  : string "@@                                    @@"
tela5Linha4  : string "@@                                    @@"
tela5Linha6  : string "@@                                    @@"
tela5Linha5  : string "@@     <<<<   <<<   <     <   <<<     @@"
tela5Linha7  : string "@@     <<<<  <<<<<  <<   <<  <<<<<    @@"
tela5Linha8  : string "@@      <<  <<  <<  <<< <<< <<  <<    @@"
tela5Linha9  : string "@@      <<  <<      <<<<<<< <<        @@"
tela5Linha10 : string "@@      <<  <<      << < << <<        @@"
tela5Linha11 : string "@@      <<  <<  <<  <<   << <<  <<    @@"
tela5Linha12 : string "@@     <<<<  <<<<<  <<   <<  <<<<<    @@"
tela5Linha13 : string "@@     <<<<   <<<   <<   <<   <<<     @@"
tela5Linha14 : string "@@                                    @@"
tela5Linha15 : string "@@                                    @@"
tela5Linha16 : string "@@                                    @@"
tela5Linha17 : string "@@   ;;;;;;                           @@"
tela5Linha18 : string "@@   ;;   ;;  ;;;;   ;;;;   ;;;;      @@"
tela5Linha19 : string "@@   ;;   ;;     ;; ;;  ;; ;;  ;;     @@"
tela5Linha20 : string "@@   ;;  ;;;  ;;;;; ;;     ;;  ;;     @@"
tela5Linha21 : string "@@   ;;;;;   ;;  ;; ;;     ;;;;;      @@"
tela5Linha22 : string "@@   ;; ;;;  ;;  ;; ;;  ;; ;;         @@"
tela5Linha23 : string "@@   ;;  ;;;  ;;;;   ;;;;   ;;;;      @@"
tela5Linha24 : string "@@                                    @@"
tela5Linha25 : string "@@                                    @@"
tela5Linha26 : string "@@           Aperte Espaco            @@"
tela5Linha27 : string "@@                                    @@"
tela5Linha28 : string "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
tela5Linha29 : string "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

carrofederupa : var #16
  static carrofederupa + #0, #2342 ;   &
  static carrofederupa + #1, #2345 ;   )
  static carrofederupa + #2, #2347 ;   +
  ;2  espacos para o proximo caractere
  static carrofederupa + #3, #2345 ;   )
  static carrofederupa + #4, #2342 ;   &
  ;35  espacos para o proximo caractere
  static carrofederupa + #5, #2343 ;   '
  static carrofederupa + #6, #2344 ;   (
  static carrofederupa + #7, #2350 ;   .
  static carrofederupa + #8, #2351 ;   /
  static carrofederupa + #9, #2348 ;   ,
  static carrofederupa + #10, #2342 ;   &
  ;35  espacos para o proximo caractere
  static carrofederupa + #11, #2342 ;   &
  static carrofederupa + #12, #2346 ;   *
  static carrofederupa + #13, #2349 ;   -
  ;2  espacos para o proximo caractere
  static carrofederupa + #14, #2346 ;   *
  static carrofederupa + #15, #2342 ;   &

carrofederupaGaps : var #16
  static carrofederupaGaps + #0, #0
  static carrofederupaGaps + #1, #0
  static carrofederupaGaps + #2, #0
  static carrofederupaGaps + #3, #1
  static carrofederupaGaps + #4, #0
  static carrofederupaGaps + #5, #34
  static carrofederupaGaps + #6, #0
  static carrofederupaGaps + #7, #0
  static carrofederupaGaps + #8, #0
  static carrofederupaGaps + #9, #0
  static carrofederupaGaps + #10, #0
  static carrofederupaGaps + #11, #34
  static carrofederupaGaps + #12, #0
  static carrofederupaGaps + #13, #0
  static carrofederupaGaps + #14, #1
  static carrofederupaGaps + #15, #0

printcarrofederupa:
  push R0
  push R1
  push R2
  push R3
  push R4
  push R5
  push R6

  loadn R0, #carrofederupa
  loadn R1, #carrofederupaGaps
  load R2, carrofederupaPosition
  loadn R3, #16 ;tamanho carrofederupa
  loadn R4, #0 ;incremetador

  printcarrofederupaLoop:
    add R5,R0,R4
    loadi R5, R5

    add R6,R1,R4
    loadi R6, R6

    add R2, R2, R6

    outchar R5, R2

    inc R2
     inc R4
     cmp R3, R4
    jne printcarrofederupaLoop

  pop R6
  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  pop R0
  rts

apagarcarrofederupa:
  push R0
  push R1
  push R2
  push R3
  push R4
  push R5

  loadn R0, #3967
  loadn R1, #carrofederupaGaps
  load R2, carrofederupaPosition
  loadn R3, #16 ;tamanho carrofederupa
  loadn R4, #0 ;incremetador

  apagarcarrofederupaLoop:
    add R5,R1,R4
    loadi R5, R5

    add R2,R2,R5
    outchar R0, R2

    inc R2
     inc R4
     cmp R3, R4
    jne apagarcarrofederupaLoop

  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  pop R0
  rts

