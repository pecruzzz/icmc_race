CARRINHOPosition: var #1
carrofederupaPosition : var #1
loadn R4, #40 ; N° de colunas

msgPontuacao: string "metros"

loadn r3, #1100		; Limite da pontuação	

main:

  call ApagaTela
  call ImprimeMenu
  call ImprimePista
  
  loadn r2, #0			; Contador da pontuação
  loadn R0, #521 ;posicao inicial do carrinho 
  store CARRINHOPosition, r0    ; inicia o carrinho na posicao


  loop:
    call Delay
    call printaPontuacao
    inc r2
    cmp r2, r3
    jeq main
    call MoveCarrinho
    jmp loop

halt


;----------------------------------------------

;********************************************************
;                          FUNÇÔES CARRRINHO
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

