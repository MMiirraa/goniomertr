
;**************************************************
  		;*** GONEOMETR ***
;*************************************************
 		;контроллер С8051F020 *
;**************************************************

$include (c8051f120.inc)
 
;* КОНСТАНТЫ *
STEK		EQU	0B0H
MY_ADRS	EQU	3	; СДВ-2 КВ-3

BIT0		EQU	01H;
BIT1		EQU	02H;  
BIT2		EQU	04H;
BIT3		EQU	08H;
BIT4		EQU	10H;
BIT5		EQU	20H;
BIT6		EQU	40H;
BIT7		EQU	80H;

     ;*** СИГНАЛЫ УПРАВЛЕНИЯ ***


F_A		EQU		P0.5	;
KN1		EQU		P0.6	;
NAPR		EQU		P0.7	;
;UPR_REL1	EQU		P4.0	;
;UPR_REL2	EQU		P4.1	;
;UR_REL	EQU		P4.2	;
KN2		EQU		p4.3	;
;SCL		EQU	P0.3	; ДИСТ/МЕСТН.
;LOG1		EQU	P0.4	; управл. коммутацией
;LOG2		EQU	P0.5	; датчиков температуры
;X1		EQU	P0.6	; ********************
;X2		EQU	P0.7	; ********************

RG_YP		EQU	P4
UPR_REL1	EQU	1
UPR_REL2	EQU	2
UPR_REL	EQU	4

SW_DST1	EQU	0EFH	; шаблон флага Р4.4	
SW_MESIN	EQU	0DFH	; шаблон флага Р4.5

KL0		EQU	1

KONTR_P_HH_R1	EQU	1
KONTR_P_KZ_R1	EQU	2
KONTR_P_HH_R2	EQU	4
KONTR_P_KZ_R2	EQU	8

;*** РАСПРЕДЕЛЕНИЕ РАБОЧЕЙ ПАМЯТИ ***

;R7	сч-к принятых батов UART0

CNT_PIT	EQU	08H	; 
CNT1		EQU	09H	; 
YGOL1H	EQU	0AH	; ЗНАЧЕНИЕ УГЛА В ГРАД 
YGOL1L	EQU	0BH	; 
NMBH		EQU	0CH	; принятое зн-ние 
NMBL		EQU	0DH	; угла
MY_ADR	EQU	0EH	; рабочий счетчик
CNT_TS	EQU	0FH	; сч-к байтов при приеме сообщения
UART0B	equ	10H
;RABH		EQU	11H	; Индекс записи во флеш-память
OTVT		EQU	12H
;***** rezerv 5 byte ****

IND_RS	equ	018h	; ст байт
INDG		equ	019h	
CNTDY		equ	01Ah
OBRKZ		EQU	01BH
IND_OTV	EQU	01CH
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;****** БИТОВАЯ ПАМЯТЬ (ФЛАГИ) 20H-2FH ********
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;*** общий регистр флагов (20H) ***
Fcomn    EQU  20H

Fzpre		BIT	20H.0		; есть зарос состояния
Fmdy		BIT	20H.1		; была передача состояния
Fprd		BIT	20H.2		; идет передача параметров
Fbe		BIT	20H.3		; есть новое зн-ние параметра
Fmin		EQU	20H.4
Fdyk		BIT	20H.5		; ЦИКЛ ОПРСА ПЕРЕКЛ
Fyno		BIT	20H.6		; НУЖЕН ОТВЕТ Y|N
Fyn1		BIT	20H.7

;*** ФЛАГИ КАНАЛА СВЯЗИ ***

BFprm		EQU	21H		; байт флагов UART0
Frsp		BIT	21H.0		; идет прием сообщения
Fzprs		BIT	21H.1
Ferrs		EQU	21h.2		; есть ошика приема


BFrel		EQU	22H		; Ф-ГИ СОСТ. РЕЛЕ
Fin1		BIT	22H.0		; СОСТОЯНИЕ ПЕРЕКЛ."ДИСТ/МЕСТН"
Kk8		EQU	22H.1		; реле круг/8

BFY		EQU	23H		; прием флагов от ВУ
Krel		EQU	23H.1		; реле круг/8

Fnkod		EQU	23H.2		;	флаги нкодера
Fenk		EQU	23H.3
Fm1		EQU	23H.4
Fm2		EQU	23H.5
Fizm		EQU	23H.6
Ffront	EQU	23H.7
F90		EQU	24H.0
F901		EQU	24H.1
F902		EQU	24H.2
Fplus90	EQU	24H.3
Fmk1		EQU	24H.4
Fmk2		EQU	24H.5
Fizmk		EQU	24H.6
Fobsluj	EQU	24H.7

F_n_kl	EQU	25H.0

BFprd		EQU	26H		; ф-ги для передачи на ВУ
Fprd1		BIT	26H.1		; ИДЕТ ПЕРЕДАЧА
Fprd2		BIT	26H.2
Fprd3		BIT	26H.3
Fprd4		BIT	26H.4

;***************************************

;*** РАБОЧАЯ ПАМЯТЬ - ЧАСТЬ 2 (30Н-7FH)

OTVET		EQU	40H
OTVT1		EQU	41H
OTVT2		EQU	42H
OTVT3		EQU	43H
OTVT4		EQU	44H
KS_CRC	EQU	45H


CNT8L		EQU	50H
CNT8H		EQU	51H

R2S		EQU	52H
R3S		EQU	53H
R4S		EQU	54H
R5S		EQU	55H

UGOLPLUS90m	EQU	56H
ST200		EQU	57H
;**** Распределение внешней памяти ***


;******** Interrupt***********

;MOV XBR0,05H		;
;MOV	XBR1,06H		;
;MOV	XBR2,40H		;
;MOV	TCON,03H		;




;**************************************
;******** Interrupt Vectors ***********
;**************************************
          CSEG

      LJMP   START
     ;*******************
      ORG   03H     ; INTO
      ;JMP   INT_INT0
      RETI
      org   0BH     ; переполнение Т0
      JMP   INT_TMR0
      reti
      org   13H     ; INT1
      RETI
      org   1BH     ; переполнение Т1
      RETI
      org   23H     ; ПОСЛ. КАНАЛ UART0
      JMP   INT_UART0
	reti  
      org   2BH     ; переполнение Т2
      RETI
      org   33H     ; SPI
      RETI
      org   3BH     ; SMBus
	;JMP	SMBus_ISR
      RETI
      org   43H     ; ADC0
      RETI       
      org   4BH     ; PCA
      RETI
      org   53H     ; задн.фронт компарат.0
      RETI
      org   5BH     ; передн.фронт компарат.0
      RETI
      org   63H     ; задн.фронт компарат.1
      RETI
      org   6BH     ; передн.фронт компарат.1
      RETI
      org   73H     ; переполнение Т3
      ;LJMP  TIMER3
      RETI
      org   7BH   ; заверш.преобр. ADC0
      ;LJMP  ADC0_INT
      RETI
      org   83H   ; переполнение Т4
      RETI
      org   8BH   ; заверш.преобр. ADC1
      RETI
      org   93H   ; Внешнее перрывание 6
      RETI
      org   9BH   ; Внешнее перрывание 7
      RETI
      org   0A3H  ; UART1
      ;JMP   INT_UART1  ; ПОСЛ. КАНАЛ  
      RETI
      org   0ABH   ; готовн. кварцев. генератора
      RETI

;************* 
TBL_GRD:DB	0,0F0H,0FFH,0	;0
		;DB	0,070H,0FCH,0	;1
		DB	0,0A0H,3,0	;1
		DB	0,0A0H,3,0	;2
		DB	0,020H,3,0	;3
		DB	0,0E0H,2,0	;4
		DB	0,0A0H,2,0	;5
		DB	0,070H,2,0	;6
		DB	0,050H,2,0	;7
		DB	0,020H,2,0	;8
		DB	0,000H,2,0	;9
		DB	0,0E0H,1,0	;10
		DB	0,0D0H,1,0	;11
		DB	0,0B0H,1,0	;12
		DB	0,0A0H,1,0	;13
		DB	1,090H,1,0	;14
		DB	1,080H,1,0	;15
		DB	1,070H,1,0	;16
		DB	1,060H,1,0	;17
		DB	1,040H,1,0	;18
		DB	1,030H,1,0	;19
		DB	1,030H,1,0	;20
		DB	1,020H,1,0	;21
		DB	1,010H,1,0	;22
		DB	1,000H,1,0	;23
		DB	2,000H,1,0	;24
		DB	2,0F0H,0,0	;25
		DB	2,0E0H,0,0	;26
		DB	2,0E0H,0,0	;27
		DB	2,0D0H,0,0	;28
		DB	2,0C0H,0,0	;29
		DB	2,0C0H,0,0	;30
		DB	3,0C0H,0,0	;31
		DB	3,0B0H,0,0	;32
		DB	3,0B0H,0,0	;33
		DB	3,0A0H,0,0	;34
		DB	4,0A0H,0,0	;35
		DB	4,0A0H,0,0	;36
		DB	4,090H,0,0	;37
		DB	4,080H,0,0	;38
		DB	4,080H,0,0	;39
		DB	5,080H,0,0	;40
		DB	5,070H,0,0	;41
		DB	5,070H,0,0	;42
		DB	6,070H,0,0	;43
		DB	6,070H,0,0	;44
		DB	6,060H,0,0	;45
;***************************************
		DB	007,060H,0,0	;46
		DB	007,060H,0,0	;47
		DB	007,050H,0,0	;48
		DB	007,050H,0,0	;49
		DB	008,050H,0,0	;50
		DB	008,040H,0,0	;51
		DB	008,040H,0,0	;52
		DB	009,040H,0,0	;53
		DB	0AH,040H,0,0	;54
		DB	0AH,040H,0,0	;55
		DB	0AH,030H,0,0	;56
		DB	0BH,030H,0,0	;57
		DB	0BH,030H,0,0	;58
		DB	0CH,030H,0,0	;59
		DB	0CH,020H,0,0	;60
		DB	0CH,020H,0,0	;61
		DB	0DH,020H,0,0	;62
		DB	0EH,020H,0,0	;63
		DB	0EH,020H,0,0	;64
		DB	0FH,020H,0,0	;65
		DB	10H,020H,0,0	;66
		DB	10H,010H,0,0	;67
		DB	11H,010H,0,0	;68
		DB	12H,010H,0,0	;69
		DB	13H,010H,0,0	;70
		DB	13H,010H,0,0	;71
		DB	14H,010H,0,0	;72
		DB	16H,010H,0,0	;73
		DB	17H,010H,0,0	;74
		DB	18H,010H,0,0	;75
		DB	19H,010H,0,0	;76
		DB	1AH,0,0,0		;77
		DB	1BH,0,0,0		;78
		DB	1DH,0,0,0		;79
		DB	1EH,0,0,0		;80
		DB	20H,0,0,0		;81
		DB	22H,0,0,0		;82
		DB	25H,0,0,0		;83
		DB	27H,0,0,0		;84
		DB	2AH,0,0,0		;85
		DB	2EH,0,0,0		;86
		DB	32H,0,0,0		;87
		DB	3AH,0,0,0		;88
		DB	3AH,0,0,0		;88
		DB	0C7H,0FH,0,0	;89
;		;DB	0FFH,0FH,0,0	;90
		DB	0FeH,0FH,0,0	;90

;**************************************
;* Инициализация блока после вкл пит.**
;**************************************
          org   300H ; 
;*** Start of program
START:	mov	WDTCN, #0DEh ;отключаем WDT
		mov	WDTCN, #0ADh
  ;**** общие настройки ***	
		MOV	SP,#STEK
		MOV	A,#0FFH
		mov	P0,A
		MOV   P1,A			; порты с исходн
		MOV   P2,A			; порты с исходн
		MOV   P3,A			; состояние
			;

		MOV   SFRPAGE,#0Fh  	; номер страницы
		;MOV   P0MDOUT,#01H
		MOV	P4,A
;		MOV 	XBR0,#05H		;
;MOV	XBR1,06H		;
;		MOV	XBR2,#40H		;
		
		MOV	SFRPAGE,#00h
;		MOV	TCON,#03H		;
		MOV   P0MDOUT,#01H


  ;** режимы работы портов ОИ(0) или обычный (1)
START1:
            MOV   SFRPAGE,#0Fh  	; номер страницы	
  ;*** настройка тактового генератора
  		MOV	OSCICN,#83h
;		MOV	SFRPAGE,#00h
		clr	a
		mov	b,a
sikal1:	djnz	ACC,$
		djnz	b,sikal1
OSC_WT:	MOV	A,OSCICN
		JNB	ACC.6,OSC_WT	; ждем готовность внутр. ген-ра
		MOV   SFRPAGE,#0h		; номер страницы
;****** настройка	портов **********
		MOV	P0MDOUT,#1H
		MOV	P1MDOUT,#0FFH
		MOV	P2MDOUT,#0FFH
		MOV   P3MDOUT,#0FFH		
;******* настройка таймера T1 *******
		MOV   TMOD,#22H		; T0-реж2
		MOV   TCON,#50H		; включили T0 
		MOV   TH0,#048h		; (24,5/12/44) ~20mks 
		MOV	TH1,#098H		; для скор 19200
		ORL	CKCON,#10H		; T0/12 T1-sysclk
		;ORL	PCON,#80H
;*** настройка таймера ТМ2 для UART0
		MOV   RCAP2H,#0FFH
		MOV   RCAP2L,#061H	; для скорости 9600
		MOV   TMR2CF,#8H		; на вход подаем SYSCLK/8 
		MOV   TMR2CN,#4H		; включаем таймер2
;*** настройка последовательных портов ***
		MOV	SCON0,#0D0H		; посл.кан0. реж-3
		MOV	SSTA0,#015H		; UART0 от таймера2
;****** настройка прерываний **********
		SETB	ET0			; TM0
		SETB	ES0			; UART0
		SETB	PT0			; высший приоритет ТМ0
;****** настройка Crossbar **********
		MOV   SFRPAGE,#0Fh  	; номер страницы
		ORL   XBR0,#4					; Tx0+Rx0 
		ORL   XBR2,#040H		; включили
		MOV   SFRPAGE,#0h		; номер страницы


;** ОЧИЩАЕМ РАБОЧУЮ ПАМЯТЬ ****
		MOV   R1,#254
		MOV   R0,#2H
		CLR   A
STR1:		MOV   @R0,A
		INC   R0
		DJNZ  R1,STR1    		; очистили память
		MOV   R0,A       		; 0
 ;* ОЧИЩАЕМ ВНЕШНЮЮ ПАМЯТЬ 2Kb ******
		MOV   DPTR,#0H
		MOV   R2,#8
		CLR   A
INI0:		MOV   R3,A
INIB:		MOVX  @DPTR,A
		INC   DPTR
		DJNZ  R3,INIB
		DJNZ  R2,INI0
 ;****** НАСТРОЙКИ ************
 		MOV	MY_ADR,#MY_ADRS
		MOV	R1,#80H
		MOV   SFRPAGE,#0Fh  	; номер страницы
		MOV	A,P5			; ЧИТАЕМ СОСТОЯНИЕ
		MOV   SFRPAGE,#0h  	; номер страницы	
		MOV	C,ACC.0		; ПЕРЕКЛ. "ДИСТ/МЕСТН"
		CPL	C
		MOV	Fin1,C
	;************************
OSN:		SETB  IE.7			; разрешаем прерывания
		SETB	Krel			; после старта круг
		MOV   SFRPAGE,#0Fh  	; номер страницы
		ANL	P4,#0FBH		; UPR_REL=0
		MOV	A,P7
		ANL	A,#0FH
		MOV	OBRKZ,A
		MOV   SFRPAGE,#0h  	; номер страницы
;		CALL	ANLZ_MD
		CLR	C
		JMP	MAIN			; начинаем работу в штатном режиме
	;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   ;******** ОБРАБОТКА ПРЕРЫВАНИЙ ************
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	;*** пр-ние таймера Т0 100 мкс***

INT_TMR0:
;********** КРУГ или ЛРУГ/ГНМ **********
            PUSH	PSW
		PUSH	ACC

;********** ОПРОС КНОПКИ +90 ***********
	MOV	A,p0
	JB	F_n_kl,M3P
	JB	ACC.6,INT_TMR001
	DJNZ	ST200,INT_TMR001
	SETB	F_n_kl
	MOV	ST200,#200
M3P:
	JNB	ACC.6,INT_TMR001
	DJNZ	ST200,INT_TMR001
	SETB	Fizmk
	MOV 	ST200,#200
	CLR	F_n_kl

INT_TMR001:
;************* ОПРОС НКОДЕРА *************
	MOV	C,F_A				; Fm1=F_A
	MOV	Fm1,C
	CLR	C
	JB	F_A,SRABOTALA		; F_A=1?
	MOV	C,Fm1				; No
	MOV	Fm2,C
	CLR	C
	LJMP	TMR0E
							;
SRABOTALA:					; Yse
	JB	Fm2,INT_TMR2		; Fm2=1?
	SETB	Fizm				; нет и Fизм = 1
	SETB	Fenk
	MOV	C,Fm1				; No
	MOV	Fm2,C
	CLR	C
TMR0E:     
;********** СЧЕТЧИК ***********
		DJNZ	CNT_TS,INT_TMR2	; сч-к цикла (256)
		;CPL	P0.7
		SETB	Fdyk			; ЦИКЛ ОПРСА ПЕРЕКЛ
INT_TMR2:
INT_TMRE:
		POP	ACC
		POP	PSW
	RETI

;*******************************************************
  ;*** ОБР-КА ПР-НИЙ ПОСЛЕДОВАТЕЛЬНОГО КАНАЛА UART0  ***
;*******************************************************
INT_UART0:	PUSH	PSW
		PUSH	ACC
		JNB	TI0,UART0_RX
		JMP	UART0_TX		; ПЕРЕДАТЧИК
  ;***** ПРИЕМНИК ЧИТАЕМ БАЙТ в А (всегда)*****
UART0_RX:	MOV	A,SBUF0		; Прочитали принят. байт 
		CLR	RI0			; Сбросили флаг приема 
		MOV	UART0B,A		; НЕТ. сохраняем
		JB	Frsp,UART0_RXP	; идет прием сообщения? ДА
		JNB	RB80,UART0_END	; адрес? НЕТ
UART0_RX1:	CJNE	A,#MY_ADRS,UART0_END1; мой адрес? НЕТ
		MOV	BFprm,#0		; сброс флагов приема
		SETB	Frsp			; ф-г "идет прием сообщения"
		MOV	R7,#4			; К-ВО ПРИНИМАЕМЫХ БАЙТОВ
		MOV	OTVT,#0
UART0_END:	POP	ACC
		POP	PSW
		RETI
UART0_END1:	CLR	Frsp
		POP	ACC
		POP	PSW
		RETI
;***** ПРИЕМ СООБЩЕНИЯ **************
UART0_RXP:	JB	RB80,UART0_RX1
		MOV	A,#LOW(PRM_PRIEM)	; ВЫХОД В ПП 
		PUSH	ACC			; ПРИЕМА СООБШЕНИЯ  
		MOV	A,#HIGH(PRM_PRIEM) 
		PUSH	ACC                 
		RETI
;**************************************************************
  ;***  ОТ ПЕРЕДАТЧИКА  ***
;**************************************************************
UART0_TX:	CLR	TI0
		JNB	Fprd,UART0_EN	; передан последний байт? ДА
		PUSH	0			; НЕТ
		MOV	R0,IND_OTV		; индекс пакета передачи
		MOV	A,@R0			; читаем байт для передачи
		INC	IND_OTV		; индекс ++
		POP	0
		DJNZ	R6,UART0_TXE	; сч-к передачи --. конец передачи? НЕТ
		CLR	Fprd			; сброс ф-га передачи
UART0_TXE:	CLR	TB80
 		MOV	SBUF0,A		; БАЙТ ДЛЯ ПЕРЕДАЧИ
		POP	ACC
		POP	PSW
		RETI
UART0_EN:	CLR	Fprd1			; сброс ф-га передачи
		POP	ACC
		POP	PSW
		RETI

;*******************************************************
;* ПЕРЕДАЧА ТЕКУЩЕГО ЗНАЧЕНИЯ СОСТОЯНИЯ ПЕРЕКЛЮЧАТЕЛЕЙ
;*******************************************************
ZAP_SOST:	PUSH	PSW
		PUSH	ACC
		MOV   SFRPAGE,#0Fh  	; номер страницы
		MOV	A,P5	
		MOV	C,ACC.0		; МЕСТН/ДИСТ
		CPL	C
		MOV	Fin1,C
		MOV	A,P7		;OBRKZ
		ANL	A,#0FH
		MOV   SFRPAGE,#0h  	; номер страницы
		CLR	C
		RLC	A
		RLC	A
		MOV	B,A
		MOV	A,BFrel
		ANL	A,#3
		ORL	A,B
		MOV	BFrel,A
		JB	Fyn1,ZAP_YN
;*** запустить передачу значения состояния
		SETB	TB80
		MOV	SBUF0,#1		;ПЕРЕДАЕМ АДРЕС
		setb	Fprd
		setb	Fprd1
		MOV	OTVET,#MY_ADRS
		MOV	OTVET+1,OTVT
		MOV	OTVET+2,BFrel
		MOV	OTVET+3,NMBH
		MOV	OTVET+4,NMBL
		MOV	OTVET+5,#3
		MOV	IND_OTV,#OTVET
		MOV	R6,#6
		POP	ACC
		POP	PSW
		RET
;***** запустить передачу *****
ZAP_YN:	SETB	TB80
		MOV	SBUF0,#1		;ПЕРЕДАЕМ АДРЕС
		CLR	Fyn1
		setb	Fprd
		setb	Fprd1
		MOV	OTVET,MY_ADR
		MOV	OTVET+1,OTVT
		MOV	OTVET+2,BFrel
		MOV	OTVET+3,#3
		MOV	IND_OTV,#OTVET
		MOV	R6,#4
		RET
;####################################

;****** ПРИЕМ ПАРАМЕТРА ************
PRM_PRIEM:	MOV	A,UART0B
		CJNE	R7,#4,PRM_PRIEM1	; ПРИНЯТ 1ый байт ПАКЕТА? НЕТ	
		CJNE	A,#'?',PRM_PRM1A	; ДА. ЗАПРОС СОСТОЯНИЯ? НЕТ 
		MOV	OTVT,#040H		; АСС.6=1 - ответ на запрос
		JMP	PRM_PRMEN0		; ДА. ВЫХОД
PRM_PRM1A:	CJNE	A,#'!',PRM_PRM1A1	; ПРОВЕРКА СЕТИ? НЕТ
		SETB	Fyno			; ДА. Ф-Г "ПЕРЕДАТЬ ПОДТВЕРЖД.
		MOV	OTVT,#21H
		JMP	PRM_PRMEN0		; ВЫХОД
PRM_PRM1A1:	CJNE	A,#'C',PRM_PRMER0	; задание угла? НЕТ
		JMP	PRM_PRMEN1
	;******************************
PRM_PRIEM1:	CJNE	R7,#3,PRM_PRIEM2	; ПРИНЯТ 2ой БАЙТ ПАКЕТА? НЕТ
		MOV	BFY,UART0B		; приняли байт флагов
		JMP	PRM_PRMEN1		; ВЫХОД
	;******************************
PRM_PRIEM2:	CJNE	R7,#2,PRM_PRIEM3	; ПРИНЯТ 3ий БАЙТ ПАКЕТА? НЕТ
		JZ	PRM_PRM11
		CJNE	A,#1,PRM_PRM12	; ст. байт зн. угла <=1
PRM_PRM11:	MOV	NMBH,A
		JMP	PRM_PRMEN1
PRM_PRM12:	MOV	OTVT,#2		; код ошибки
		SETB	Ferrs
		JMP	PRM_PRMEN0			
PRM_PRIEM3:	MOV	NMBL,UART0B		; ПРИНЯТ 4ый БАЙТ ПАКЕТА 
;***** ПРИЕМ ПАРАМЕТРА ЗАКОНЧЕН *****
		JB	Ferrs,PRM_PRMER	; ДА. есть ошибка приема? ДА
		MOV	YGOL1H,NMBH		;
		MOV	YGOL1L,NMBL
PRM_PRMER:	SETB	Fbe
;************************************
PRM_PRMEN0:	SETB	Fzpre 		; ЕСТЬ 
		CLR	Frsp			; сброс ф-га "есть прием"
PRM_PRMEN1:	DEC	R7
		POP   ACC
		POP   PSW
		RET
PRM_PRMER0:	MOV	OTVT,#1		; код ошибки
		SETB	Ferrs
		JMP	PRM_PRMEN0

;***** УПРАВЛЕНИЕ******


VNESHNEE_SOBITEE:

		
OPRED_NAPR:	
	JNB		NAPR,YPR_NKOD		; - или +
UGLH_UP:						; прибавление
	MOV		A,YGOL1H			; >255?
	JZ		NKOD_PLUS			; NET
	MOV		A,YGOL1L			; 
	CJNE		A,#067H,NKODH_PLUS	; >360?
	MOV		YGOL1H,#00H			; 00
	MOV		YGOL1L,#00H			; 0
	JMP     VbIHOD

NKODH_PLUS:
	INC		YGOL1L				;
	JMP     VbIHOD

NKOD_PLUS:
;	MOV		A,YGOL1L
;	JC		NKODH_PLUS
	MOV		A,YGOL1L
	INC		YGOL1L
	ADD		A,#1
	JNC		VbIHOD
	INC		YGOL1H
	JMP     VbIHOD

YPR_NKOD:						; вычитание	
	MOV		A,YGOL1H			; >255?
	JZ		UGL_DAWN			; NET
	JMP		UGLL_DAWNMLAD
UGL_DAWN:
	MOV		A,YGOL1L
	JZ		PEREHOD
	DEC		YGOL1L
	SUBB		A,#1
	JZ		PEREHOD		; 
	JMP     	VbIHOD
UGLL_DAWNMLAD:
	MOV		A,YGOL1L
	DEC		YGOL1L
	SUBB		A,#1
	JZ		PEREHOD	;
	JMP    	VbIHOD

PEREHOD:
	MOV		A,YGOL1H
	JZ		PEREHOD1
	JMP		NKODH_MINUS
PEREHOD1:
	MOV		YGOL1H,#01H			; 359
	MOV		YGOL1L,#67H			; 
	JMP     	VbIHOD

NKODH_MINUS:
	DEC		YGOL1H
;	MOV		YGOL1L,#FFH					;>255!
	DEC		YGOL1L	;
	JMP     	VbIHOD

;TMR0EM:
;		DJNZ	CNT_TS,INT_TMR2M	; сч-к цикла (256)
		;CPL	P0.7
;		SETB	Fdyk			; ЦИКЛ ОПРСА ПЕРЕКЛ
VbIHOD:

RET

;*********** УПРАВЛЕНИЕ КНОПКОЙ KN1 +90 **************

KNOPKAPLUS90:
	MOV	A,YGOL1H	; >255
	JZ	MENSHE255	;NET
	MOV	A,YGOL1L	;DA
	CLR	C
	ADDC	A,#5AH
	MOV	UGOLPLUS90m,A
	SUBB	A,#067H
	JC	VbIVODUGLA3
	MOV	YGOL1H,#00H
	MOV	A,UGOLPLUS90m
	SUBB	A,#067H
	JMP	VbIVODUGLA1
MENSHE255:
	MOV	A,YGOL1L
	CLR	C
	ADDC	A,#5AH
	JNC	VbIVODUGLA1
	MOV	YGOL1H,#01H
	CLR	C
	MOV	YGOL1L,#00H
	MOV	YGOL1L,A
	JMP	VbIHOD1
VbIVODUGLA2:
	DEC	YGOL1H
	MOV	YGOL1L,A
	JMP	VbIHOD1
VbIVODUGLA3:	
	MOV	YGOL1L,UGOLPLUS90m
	JMP	VbIHOD1
VbIVODUGLA1:
	MOV	YGOL1L,A
VbIHOD1:
;SETB	Fbe
RET
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;***** УПРАВЛЕНИЕ КОММУТАТОРОМ ******

YPR_COMYT:	PUSH	B
		;SETB	Fmin
		MOV	A,YGOL1H		; УГОЛ > 255g
		JZ	YPR_COMT2		; нет
		MOV	A,YGOL1L		; ДА
		CJNE	A,#0EH,YPR_COMT0	; 
YPR_COMT0:	JC	YPR_COMT0A		; >=270g ? НЕТ
		MOV   SFRPAGE,#0Fh  	; ДА
		ANL	RG_YP,#~UPR_REL2	; -
		ORL	RG_YP,#UPR_REL1	; +
		MOV   SFRPAGE,#0h  	; номер страницы
		MOV	B,#68H
		JMP	YPR_COMTG
YPR_COMT0A:	MOV	A,#4CH
		ADD	A,YGOL1L
		MOV   SFRPAGE,#0Fh  	; номер страницы
		ANL	RG_YP,#~UPR_REL2	; 3
		ANL	RG_YP,#~UPR_REL1
		MOV   SFRPAGE,#0h  	; номер страницы
		JMP	YPR_COMTG1
;************************************
YPR_COMT2:	MOV	A,YGOL1L
		CJNE	A,#0B4H,YPR_COMT21; УГОЛ > 180g
		JMP	YPR_COMT22
		;CLR	Fmin
		MOV   SFRPAGE,#0Fh  	; номер страницы
		;ANL	RG_YP,#~UPR_REL2	; 3
		;ANL	RG_YP,#~UPR_REL1
		MOV   SFRPAGE,#0h  	; номер страницы
;************************************			
YPR_COMT21:	JC	YPR_COMT22		; ДА
		MOV	B,#0B4H
		MOV   SFRPAGE,#0Fh  	; номер страницы
		ANL	RG_YP,#~UPR_REL2	; -
		ANL	RG_YP,#~UPR_REL1	; -
		MOV   SFRPAGE,#00h  	; номер страницы
		JMP	YPR_COMTG
	;******************************
YPR_COMT22:	CLR	Fmin
		CJNE	A,#5AH,YPR_COMT23	; НЕТ УГОЛ > 90g	
YPR_COMT23:	JC	YPR_COMT3		; НЕТ
		MOV   SFRPAGE,#0Fh  	; ДА 
		ANL	RG_YP,#~UPR_REL1	; -
		ORL	RG_YP,#UPR_REL2	; +
		MOV   SFRPAGE,#0h  	; номер страницы
		MOV	B,#0B4H
		JMP	YPR_COMTG
YPR_COMT3:	MOV   SFRPAGE,#0Fh  	; номер страницы
		ORL	RG_YP,#UPR_REL1
		ORL	RG_YP,#UPR_REL2		;0
		MOV   SFRPAGE,#0h  	; номер страницы
		MOV	B,#0H
;************************************
YPR_COMTG:	CLR	C			; ВЫБОР ЗАПИСИ В ТАБЛИЦЕ
		MOV	A,YGOL1L
		SUBB	A,B
		JNC	YPR_COMTGA
		CPL	A
		INC	A
YPR_COMTGA:	ANL	A,#7FH		; 0 - 128
	;* РАБОТА С ТАБЛИЦЕЙ КОММУТАЦИИ *	
YPR_COMTG1:	MOV	DPTR,#TBL_GRD
		CLR	C
		RLC	A
		JNC	YPR_COMTG2
		INC	DPH
YPR_COMTG2:	CLR	C
		RLC	A
		JNC	YPR_COMTG3
		INC	DPH
YPR_COMTG3:	MOV	INDG,A
		MOVC	A,@A+DPTR
		INC	INDG
	;	CPL	A
		MOV	P1,A
		MOV	A,INDG
		MOVC	A,@A+DPTR
		INC	INDG
	;	CPL	A
		MOV	P2,A
		MOV	A,INDG
		MOVC	A,@A+DPTR
	;	INC	INDG
	;	CPL	A
		MOV	P3,A
		POP	B
		RET
;************************************

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;*** анализ состояния перекл. M|D ***
;ANLZ_MD:	
;		MOV   SFRPAGE,#0Fh  	; номер страницы
;		MOV	A,P5			; местн/дистанц
;		MOV	B,P7			; флаги обрыв и кз рамка1 и 2 (4)
;		ANL	B,#0FH		
;		MOV   SFRPAGE,#0h  	; номер страницы	
;		ANL	A,#1			; бит ф-га местн/дистанц
;		JZ	ANLZ_MD1		; переключатель в ДУ? ДА
;		JB	Fin1,ANLZ_MDE	; НЕТ(=1). Ф-Г УЖЕ УСТАНОВЛЕН ? ДА
;		SETB	Fin1			; НЕТ. Запоминаем новое состояние
;		MOV   SFRPAGE,#0Fh  	; номер страницы
;		ORL	P4,#30H		; ПЕРЕКЛ. СВЕТОДИОДЫ
;		ANL	P4,#0DFH
;		MOV   SFRPAGE,#0h  	; номер страницы
;		CLR	C
;		JB	Fmdy,ANLZ_MDE	; ДА. сброс ф-га.
;		SETB	Fmdy
;		SETB	C			; есть изменение
;		RET
;		JMP	ANLZ_MDE
;ANLZ_MD1:	CLR	C
;		JNB	Fin1,ANLZ_MDE
;		CLR	Fin1
;		MOV   SFRPAGE,#0Fh  	; номер страницы
;		ORL	P4,#30H		; ПЕРЕКЛ. СВЕТОДИОДЫ
;		ANL	P4,#0EFH
;		MOV   SFRPAGE,#0h  	; номер страницы	
;		JNB	Fmdy,ANLZ_MDE	; ДА. сброс ф-га.
;		CLR	Fmdy
;		SETB	C
;		RET
;ANLZ_MDE:	MOV	A,B
;		;CJNE	A,OBRKZ,ANLZ_MDE1
;		JMP	ANLZ_MDEN
;ANLZ_MDE1:	MOV	OBRKZ,A
;		SETB	Fin1
;		SETB	C
;ANLZ_MDEN:
;		RET
		
;####################################


MAIN:
;*****************	КРУГ/ГНМ	****************
MOV	SFRPAGE,#0FH
MOV	A,p4
JB	ACC.3,MAINKRUG
ANL	A,#0FBH
MOV	p4,A
JMP	MAINNKOD
MAINKRUG:
MOV	SFRPAGE,#0FH
MOV	A,p4
ORL	A,#04H
;*****************
MAINNKOD:
MOV	SFRPAGE,#0H
		JNB	Fenk,MAINplus90
		CLR	Fenk
		CALL	VNESHNEE_SOBITEE
		SETB	Fbe
MAINplus90:	
		JNB	Fizmk,MAINB1
		CLR	Fizmk
		CALL	KNOPKAPLUS90
		SETB	Fbe
MAINB1:
		JNB	Fyno,MAINA1		; НУЖНО ПОДТВЕРЖДЕНИЕ ПРИЕМА? НЕТ.
		CLR	Fyno
		SETB	Fyn1
		CALL	ZAP_SOST
MAINA1:	JNB	Fbe,MAIN1		;есть новое зн-ние пар-ра ? НЕТ
		CLR	Fbe			; ДА.
		CLR	Fobsluj
	;** анализ флага реле O|8 ***
	;	JB	Krel,MAINA
	;	MOV   SFRPAGE,#0Fh  	; номер страницы
	;	ORL	P4,#4			; ПЕРЕКЛ. СВЕТОДИОДЫ
	;	MOV   SFRPAGE,#0h  	; номер страницы
	;	SETB	Kk8	
		JMP	MAINB
;MAINA:	MOV   SFRPAGE,#0Fh  	; номер страницы
;		ANL	P4,#0FBH		; UPR_REL=0
;		MOV   SFRPAGE,#0h  	; номер страницы
;		CLR	Kk8	
	;************************
MAINB:	CALL	YPR_COMYT		; ПЕРЕНАСТРОЙКА КОММУТАТОРА
	;************************
MAIN1:	JNB	Fzpre,MAIN1A	; БЫЛ ЗАПРОС
		CLR	Fzpre
		CALL	ZAP_SOST
	;************************
MAIN1A:	JNB	Fdyk,MAIN11		; Ф-Г ШАГА ОПРОСА ПЕРЕКЛ.
		JB	Fprd1,MAIN11		; ИДЕТ ПЕРЕДАЧА ? ДА
		CLR	Fdyk
	;*** анализ состояния перекл. M|D 
;		CALL	ANLZ_MD
;		JNC	MAIN11		; есть изменения ? НЕТ	
;		CLR	C			; ДА
;		MOV	OTVT,#080H
;		CALL	ZAP_SOST		; послать сообщение CPU
	;******************************		
MAIN11:	
MAINWS1:	jmp   MAIN
;####################################
CRC8:		MOV	CNT8L,DPL
		MOV	ACC,DPH
		SUBB	A,#2
		MOV	CNT8H,ACC
		MOV	DPTR,#300H
		CLR	A
		MOVC	A,@A+DPTR
		INC	DPTR
		MOV	B,A
SIKLCRC:	CLR	A
		MOVC	A,@A+DPTR
		INC	DPTR
		MOV	R0,#8
SIKLCR8:	RLC	A			; C <- BIT SOOB
		XCH	A,B			; A <-> POLINOM
		RLC	A			; C <- A <-C
		JNC	SIKLCR82
		CPL	ACC.0
		CPL	ACC.4
		CPL	ACC.5
SIKLCR82:	XCH	A,B
		DJNZ	R0,SIKLCR8

		DJNZ	CNT8L,SIKLCRC
		DJNZ	CNT8H,SIKLCRC
		MOV	KS_CRC,B
		RET
;***********************************
CRCENS:	POP	DPH
		POP	DPL
		PUSH	DPL
		PUSH	DPH
		INC	DPTR
		INC	DPTR	
		RET	
;***********************************
CRCEND:	CALL  CRCENS
		RET
DB		0
;****************************************
		end


