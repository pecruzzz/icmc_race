CARRINHOPosition : var #1

CARRINHO : var #16
  static CARRINHO + #0, #6 ;   
  static CARRINHO + #1, #9 ;   
  static CARRINHO + #2, #11 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #3, #9 ;   
  static CARRINHO + #4, #6 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #5, #7 ;   
  static CARRINHO + #6, #8 ;   
  static CARRINHO + #7, #14 ;   
  static CARRINHO + #8, #15 ;   
  static CARRINHO + #9, #12 ;   
  static CARRINHO + #10, #6 ;   
  ;35  espacos para o proximo caractere
  static CARRINHO + #11, #6 ;   
  static CARRINHO + #12, #10 ;   
  static CARRINHO + #13, #13 ;   
  ;2  espacos para o proximo caractere
  static CARRINHO + #14, #10 ;   
  static CARRINHO + #15, #6 ;   

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
