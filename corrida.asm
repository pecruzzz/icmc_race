; Variaveis auxiliares para movimentos
aux: var #1
aux1: var #1
aux2: var #1   

CARRINHOPosition: var #1
PosicaoAnteriorCarrinho: var #1

main:

  call ApagaTela
  loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2560  			; cor lima
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

  loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0 			; cor branca
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

  loadn r1, #327 ;posicao inicial do carrinho 
  store CARRINHOPosition, r1    ; inicia o carrinho na posicao

  call printCARRINHO

  loop:
    call MoveCarrinho
    call Delay
    call controlaCarrinho
    jmp loop

halt

;----------------------------------------------

;********************************************************
;                       FUNÇÔES CARRINHO
;********************************************************
controlaCarrinho:; checa se o carrinho se moveu

  push r0
  push r1

  load r0, CARRINHOPosition
  load r1, PosicaoAnteriorCarrinho

  cmp r0, r1
  jeq fim_controla

  ;call printtela1Screen
  call printCARRINHO

  fim_controla:

    pop r1
    pop r0

    rts
  

apagarCarrinhoDir:

  push fr
  push r0
  push r1
  push r2
  push r3
  push r4

  load r0, CARRINHOPosition
  store aux1, r0
  load r0, aux1
  loadn r1, #40
  loadn r2, #' '
  loadn r3, #0
  loadn r4, #3

  loopApagaDir:
  inc r3
  outchar r2, r0
  add r0, r0, r1
  cmp r3, r4
  jne loopApagaDir
  
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  pop fr
  rts
;-------------------------------------------------------

;********************************************************
;                       IMPRIME TELA2
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
	

;------------------------

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

MoveCarrinho:
	push r0 
	push r1 
	push r2
	push r3
	
	call Direction	
	
	jmp MoveCarrinho_End
	
	MoveCarrinho_End:
		pop r0 
		pop r1 
		pop r2
		pop r3

		rts 

	
Direction:          ;Funcao que le a direcao para qual o carrinho vai
	push fr
	push r0   ;recebe a telca (w, A, S, D)
	push r1
	push r2   ;armazena a pos. inicial do carrinho ao chamar a funcao 
	push r3   ;mudar pra cima ou pra baixo
	push r4
	push r5
	push r6
	push r7
	
	load r2, CARRINHOPosition
	loadn r3, #40     ;retira 40 para a nave ir para cima adiciona 40 para ir para baixo
	
	inchar r0
	
	Direction_Up:
		loadn r1, #'w'
		cmp r1, r0
		jne Direction_Down
		call apagarCARRINHO
		sub r2, r2, r3     ;retira 40 para a nave ir para cima
		jmp End_Direction

	Direction_Left:
		loadn r1, #'a'
		cmp r1, r0
	 	jne Direction_Down
    call apagarCARRINHO		
		dec r2             ;retira 1 para mover para esquerda
		jmp End_Direction
		
	Direction_Down:
		loadn r1, #'s'
		cmp r1, r0
		jne Direction_Right
    call apagarCARRINHO
		add r2, r2, r3      ;retira 40 para mover para baixo
		jmp End_Direction

	Direction_Right:
		loadn r1, #'d'
		cmp r1, r0
    jne End_Direction
    call apagarCARRINHO
		inc r2              ;adiciona 1 para mover para direita
		jmp End_Direction

	End_Direction:
		store aux, r2       ;Guarda a posicao do carro
		load r1, aux        ;Transfere a informacao para o r1

		loadn r3, #1
		load r2, CARRINHOPosition
		
		cmp r0, r3
		jeq End_Direction_Pops
				
		store CARRINHOPosition, r1
		
	End_Direction_Pops:       ;Apos finalizar as condicoes de movimentos, da pop

		store PosicaoAnteriorCarrinho, r2
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop fr
		
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

;carrinho
  CARRINHO : var #16
  static CARRINHO + #0, #38 ;   
  static CARRINHO + #1, #41 ;   
  static CARRINHO + #2, #42 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #3, #41 ;   
  static CARRINHO + #4, #38 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #5, #39 ;   
  static CARRINHO + #6, #40 ;   
  static CARRINHO + #7, #46 ;   
  static CARRINHO + #8, #47 ;   
  static CARRINHO + #9, #44 ;   
  static CARRINHO + #10, #38 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #11, #38 ;   
  static CARRINHO + #12, #42 ;   
  static CARRINHO + #13, #45 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #14, #42 ;   
  static CARRINHO + #15, #38 ;   

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
tela1Linha0  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha0  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha3  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha4  : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha5  : string "########################################"
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
tela1Linha24 : string "########################################"
tela1Linha25 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha26 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha27 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha28 : string "(((((((((((((((((((((((((((((((((((((((("
tela1Linha29 : string "(((((((((((((((((((((((((((((((((((((((("

tela2Linha0  : string "                                        "
tela2Linha0  : string "                                        "
tela2Linha0  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "########################################"
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "             %         %           %    "
tela2Linha9  : string "             %         %           %    "
tela2Linha10 : string "             %         %           %    "
tela2Linha11 : string "        #####$    #####$      #####$    "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "         %         %           %        "
tela2Linha18 : string "         %         %           %        "
tela2Linha19 : string "         %         %           %        "
tela2Linha20 : string "    #####$    #####$      #####$        "
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
