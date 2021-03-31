
;**************************************************
  		;*** GONEOMETR ***
;*************************************************
 		;���������� �8051F020 *
;**************************************************

$include (c8051f120.inc)
 
;* ��������� *
STEK		EQU	0B0H
MY_ADRS	EQU	3	; ���-2 ��-3

BIT0		EQU	01H;
BIT1		EQU	02H;  
BIT2		EQU	04H;
BIT3		EQU	08H;
BIT4		EQU	10H;
BIT5		EQU	20H;
BIT6		EQU	40H;
BIT7		EQU	80H;

     ;*** ������� ���������� ***


F_A		EQU		P0.5	;
KN1		EQU		P0.6	;
NAPR		EQU		P0.7	;
;UPR_REL1	EQU		P4.0	;
;UPR_REL2	EQU		P4.1	;
;UR_REL	EQU		P4.2	;
KN2		EQU		p4.3	;
;SCL		EQU	P0.3	; ����/�����.
;LOG1		EQU	P0.4	; ������. �����������
;LOG2		EQU	P0.5	; �������� �����������
;X1		EQU	P0.6	; ********************
;X2		EQU	P0.7	; ********************

RG_YP		EQU	P4
UPR_REL1	EQU	1
UPR_REL2	EQU	2
UPR_REL	EQU	4

SW_DST1	EQU	0EFH	; ������ ����� �4.4	
SW_MESIN	EQU	0DFH	; ������ ����� �4.5

KL0		EQU	1

KONTR_P_HH_R1	EQU	1
KONTR_P_KZ_R1	EQU	2
KONTR_P_HH_R2	EQU	4
KONTR_P_KZ_R2	EQU	8

;*** ������������� ������� ������ ***

;R7	��-� �������� ����� UART0

CNT_PIT	EQU	08H	; 
CNT1		EQU	09H	; 
YGOL1H	EQU	0AH	; �������� ���� � ���� 
YGOL1L	EQU	0BH	; 
NMBH		EQU	0CH	; �������� ��-��� 
NMBL		EQU	0DH	; ����
MY_ADR	EQU	0EH	; ������� �������
CNT_TS	EQU	0FH	; ��-� ������ ��� ������ ���������
UART0B	equ	10H
;RABH		EQU	11H	; ������ ������ �� ����-������
OTVT		EQU	12H
;***** rezerv 5 byte ****

IND_RS	equ	018h	; �� ����
INDG		equ	019h	
CNTDY		equ	01Ah
OBRKZ		EQU	01BH
IND_OTV	EQU	01CH
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;****** ������� ������ (�����) 20H-2FH ********
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;*** ����� ������� ������ (20H) ***
Fcomn    EQU  20H

Fzpre		BIT	20H.0		; ���� ����� ���������
Fmdy		BIT	20H.1		; ���� �������� ���������
Fprd		BIT	20H.2		; ���� �������� ����������
Fbe		BIT	20H.3		; ���� ����� ��-��� ���������
Fmin		EQU	20H.4
Fdyk		BIT	20H.5		; ���� ����� ������
Fyno		BIT	20H.6		; ����� ����� Y|N
Fyn1		BIT	20H.7

;*** ����� ������ ����� ***

BFprm		EQU	21H		; ���� ������ UART0
Frsp		BIT	21H.0		; ���� ����� ���������
Fzprs		BIT	21H.1
Ferrs		EQU	21h.2		; ���� ����� ������


BFrel		EQU	22H		; �-�� ����. ����
Fin1		BIT	22H.0		; ��������� ������."����/�����"
Kk8		EQU	22H.1		; ���� ����/8

BFY		EQU	23H		; ����� ������ �� ��
Krel		EQU	23H.1		; ���� ����/8

Fnkod		EQU	23H.2		;	����� �������
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

BFprd		EQU	26H		; �-�� ��� �������� �� ��
Fprd1		BIT	26H.1		; ���� ��������
Fprd2		BIT	26H.2
Fprd3		BIT	26H.3
Fprd4		BIT	26H.4

;***************************************

;*** ������� ������ - ����� 2 (30�-7FH)

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
;**** ������������� ������� ������ ***


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
      org   0BH     ; ������������ �0
      JMP   INT_TMR0
      reti
      org   13H     ; INT1
      RETI
      org   1BH     ; ������������ �1
      RETI
      org   23H     ; ����. ����� UART0
      JMP   INT_UART0
	reti  
      org   2BH     ; ������������ �2
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
      org   53H     ; ����.����� ��������.0
      RETI
      org   5BH     ; ������.����� ��������.0
      RETI
      org   63H     ; ����.����� ��������.1
      RETI
      org   6BH     ; ������.����� ��������.1
      RETI
      org   73H     ; ������������ �3
      ;LJMP  TIMER3
      RETI
      org   7BH   ; ������.������. ADC0
      ;LJMP  ADC0_INT
      RETI
      org   83H   ; ������������ �4
      RETI
      org   8BH   ; ������.������. ADC1
      RETI
      org   93H   ; ������� ���������� 6
      RETI
      org   9BH   ; ������� ���������� 7
      RETI
      org   0A3H  ; UART1
      ;JMP   INT_UART1  ; ����. �����  
      RETI
      org   0ABH   ; ������. �������. ����������
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
;* ������������� ����� ����� ��� ���.**
;**************************************
          org   300H ; 
;*** Start of program
START:	mov	WDTCN, #0DEh ;��������� WDT
		mov	WDTCN, #0ADh
  ;**** ����� ��������� ***	
		MOV	SP,#STEK
		MOV	A,#0FFH
		mov	P0,A
		MOV   P1,A			; ����� � ������
		MOV   P2,A			; ����� � ������
		MOV   P3,A			; ���������
			;

		MOV   SFRPAGE,#0Fh  	; ����� ��������
		;MOV   P0MDOUT,#01H
		MOV	P4,A
;		MOV 	XBR0,#05H		;
;MOV	XBR1,06H		;
;		MOV	XBR2,#40H		;
		
		MOV	SFRPAGE,#00h
;		MOV	TCON,#03H		;
		MOV   P0MDOUT,#01H


  ;** ������ ������ ������ ��(0) ��� ������� (1)
START1:
            MOV   SFRPAGE,#0Fh  	; ����� ��������	
  ;*** ��������� ��������� ����������
  		MOV	OSCICN,#83h
;		MOV	SFRPAGE,#00h
		clr	a
		mov	b,a
sikal1:	djnz	ACC,$
		djnz	b,sikal1
OSC_WT:	MOV	A,OSCICN
		JNB	ACC.6,OSC_WT	; ���� ���������� �����. ���-��
		MOV   SFRPAGE,#0h		; ����� ��������
;****** ���������	������ **********
		MOV	P0MDOUT,#1H
		MOV	P1MDOUT,#0FFH
		MOV	P2MDOUT,#0FFH
		MOV   P3MDOUT,#0FFH		
;******* ��������� ������� T1 *******
		MOV   TMOD,#22H		; T0-���2
		MOV   TCON,#50H		; �������� T0 
		MOV   TH0,#048h		; (24,5/12/44) ~20mks 
		MOV	TH1,#098H		; ��� ���� 19200
		ORL	CKCON,#10H		; T0/12 T1-sysclk
		;ORL	PCON,#80H
;*** ��������� ������� ��2 ��� UART0
		MOV   RCAP2H,#0FFH
		MOV   RCAP2L,#061H	; ��� �������� 9600
		MOV   TMR2CF,#8H		; �� ���� ������ SYSCLK/8 
		MOV   TMR2CN,#4H		; �������� ������2
;*** ��������� ���������������� ������ ***
		MOV	SCON0,#0D0H		; ����.���0. ���-3
		MOV	SSTA0,#015H		; UART0 �� �������2
;****** ��������� ���������� **********
		SETB	ET0			; TM0
		SETB	ES0			; UART0
		SETB	PT0			; ������ ��������� ��0
;****** ��������� Crossbar **********
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		ORL   XBR0,#4					; Tx0+Rx0 
		ORL   XBR2,#040H		; ��������
		MOV   SFRPAGE,#0h		; ����� ��������


;** ������� ������� ������ ****
		MOV   R1,#254
		MOV   R0,#2H
		CLR   A
STR1:		MOV   @R0,A
		INC   R0
		DJNZ  R1,STR1    		; �������� ������
		MOV   R0,A       		; 0
 ;* ������� ������� ������ 2Kb ******
		MOV   DPTR,#0H
		MOV   R2,#8
		CLR   A
INI0:		MOV   R3,A
INIB:		MOVX  @DPTR,A
		INC   DPTR
		DJNZ  R3,INIB
		DJNZ  R2,INI0
 ;****** ��������� ************
 		MOV	MY_ADR,#MY_ADRS
		MOV	R1,#80H
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		MOV	A,P5			; ������ ���������
		MOV   SFRPAGE,#0h  	; ����� ��������	
		MOV	C,ACC.0		; ������. "����/�����"
		CPL	C
		MOV	Fin1,C
	;************************
OSN:		SETB  IE.7			; ��������� ����������
		SETB	Krel			; ����� ������ ����
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		ANL	P4,#0FBH		; UPR_REL=0
		MOV	A,P7
		ANL	A,#0FH
		MOV	OBRKZ,A
		MOV   SFRPAGE,#0h  	; ����� ��������
;		CALL	ANLZ_MD
		CLR	C
		JMP	MAIN			; �������� ������ � ������� ������
	;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   ;******** ��������� ���������� ************
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	;*** ��-��� ������� �0 100 ���***

INT_TMR0:
;********** ���� ��� ����/��� **********
            PUSH	PSW
		PUSH	ACC

;********** ����� ������ +90 ***********
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
;************* ����� ������� *************
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
	SETB	Fizm				; ��� � F��� = 1
	SETB	Fenk
	MOV	C,Fm1				; No
	MOV	Fm2,C
	CLR	C
TMR0E:     
;********** ������� ***********
		DJNZ	CNT_TS,INT_TMR2	; ��-� ����� (256)
		;CPL	P0.7
		SETB	Fdyk			; ���� ����� ������
INT_TMR2:
INT_TMRE:
		POP	ACC
		POP	PSW
	RETI

;*******************************************************
  ;*** ���-�� ��-��� ����������������� ������ UART0  ***
;*******************************************************
INT_UART0:	PUSH	PSW
		PUSH	ACC
		JNB	TI0,UART0_RX
		JMP	UART0_TX		; ����������
  ;***** �������� ������ ���� � � (������)*****
UART0_RX:	MOV	A,SBUF0		; ��������� ������. ���� 
		CLR	RI0			; �������� ���� ������ 
		MOV	UART0B,A		; ���. ���������
		JB	Frsp,UART0_RXP	; ���� ����� ���������? ��
		JNB	RB80,UART0_END	; �����? ���
UART0_RX1:	CJNE	A,#MY_ADRS,UART0_END1; ��� �����? ���
		MOV	BFprm,#0		; ����� ������ ������
		SETB	Frsp			; �-� "���� ����� ���������"
		MOV	R7,#4			; �-�� ����������� ������
		MOV	OTVT,#0
UART0_END:	POP	ACC
		POP	PSW
		RETI
UART0_END1:	CLR	Frsp
		POP	ACC
		POP	PSW
		RETI
;***** ����� ��������� **************
UART0_RXP:	JB	RB80,UART0_RX1
		MOV	A,#LOW(PRM_PRIEM)	; ����� � �� 
		PUSH	ACC			; ������ ���������  
		MOV	A,#HIGH(PRM_PRIEM) 
		PUSH	ACC                 
		RETI
;**************************************************************
  ;***  �� �����������  ***
;**************************************************************
UART0_TX:	CLR	TI0
		JNB	Fprd,UART0_EN	; ������� ��������� ����? ��
		PUSH	0			; ���
		MOV	R0,IND_OTV		; ������ ������ ��������
		MOV	A,@R0			; ������ ���� ��� ��������
		INC	IND_OTV		; ������ ++
		POP	0
		DJNZ	R6,UART0_TXE	; ��-� �������� --. ����� ��������? ���
		CLR	Fprd			; ����� �-�� ��������
UART0_TXE:	CLR	TB80
 		MOV	SBUF0,A		; ���� ��� ��������
		POP	ACC
		POP	PSW
		RETI
UART0_EN:	CLR	Fprd1			; ����� �-�� ��������
		POP	ACC
		POP	PSW
		RETI

;*******************************************************
;* �������� �������� �������� ��������� ��������������
;*******************************************************
ZAP_SOST:	PUSH	PSW
		PUSH	ACC
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		MOV	A,P5	
		MOV	C,ACC.0		; �����/����
		CPL	C
		MOV	Fin1,C
		MOV	A,P7		;OBRKZ
		ANL	A,#0FH
		MOV   SFRPAGE,#0h  	; ����� ��������
		CLR	C
		RLC	A
		RLC	A
		MOV	B,A
		MOV	A,BFrel
		ANL	A,#3
		ORL	A,B
		MOV	BFrel,A
		JB	Fyn1,ZAP_YN
;*** ��������� �������� �������� ���������
		SETB	TB80
		MOV	SBUF0,#1		;�������� �����
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
;***** ��������� �������� *****
ZAP_YN:	SETB	TB80
		MOV	SBUF0,#1		;�������� �����
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

;****** ����� ��������� ************
PRM_PRIEM:	MOV	A,UART0B
		CJNE	R7,#4,PRM_PRIEM1	; ������ 1�� ���� ������? ���	
		CJNE	A,#'?',PRM_PRM1A	; ��. ������ ���������? ��� 
		MOV	OTVT,#040H		; ���.6=1 - ����� �� ������
		JMP	PRM_PRMEN0		; ��. �����
PRM_PRM1A:	CJNE	A,#'!',PRM_PRM1A1	; �������� ����? ���
		SETB	Fyno			; ��. �-� "�������� ���������.
		MOV	OTVT,#21H
		JMP	PRM_PRMEN0		; �����
PRM_PRM1A1:	CJNE	A,#'C',PRM_PRMER0	; ������� ����? ���
		JMP	PRM_PRMEN1
	;******************************
PRM_PRIEM1:	CJNE	R7,#3,PRM_PRIEM2	; ������ 2�� ���� ������? ���
		MOV	BFY,UART0B		; ������� ���� ������
		JMP	PRM_PRMEN1		; �����
	;******************************
PRM_PRIEM2:	CJNE	R7,#2,PRM_PRIEM3	; ������ 3�� ���� ������? ���
		JZ	PRM_PRM11
		CJNE	A,#1,PRM_PRM12	; ��. ���� ��. ���� <=1
PRM_PRM11:	MOV	NMBH,A
		JMP	PRM_PRMEN1
PRM_PRM12:	MOV	OTVT,#2		; ��� ������
		SETB	Ferrs
		JMP	PRM_PRMEN0			
PRM_PRIEM3:	MOV	NMBL,UART0B		; ������ 4�� ���� ������ 
;***** ����� ��������� �������� *****
		JB	Ferrs,PRM_PRMER	; ��. ���� ������ ������? ��
		MOV	YGOL1H,NMBH		;
		MOV	YGOL1L,NMBL
PRM_PRMER:	SETB	Fbe
;************************************
PRM_PRMEN0:	SETB	Fzpre 		; ���� 
		CLR	Frsp			; ����� �-�� "���� �����"
PRM_PRMEN1:	DEC	R7
		POP   ACC
		POP   PSW
		RET
PRM_PRMER0:	MOV	OTVT,#1		; ��� ������
		SETB	Ferrs
		JMP	PRM_PRMEN0

;***** ����������******


VNESHNEE_SOBITEE:

		
OPRED_NAPR:	
	JNB		NAPR,YPR_NKOD		; - ��� +
UGLH_UP:						; �����������
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

YPR_NKOD:						; ���������	
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
;		DJNZ	CNT_TS,INT_TMR2M	; ��-� ����� (256)
		;CPL	P0.7
;		SETB	Fdyk			; ���� ����� ������
VbIHOD:

RET

;*********** ���������� ������� KN1 +90 **************

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
;***** ���������� ������������ ******

YPR_COMYT:	PUSH	B
		;SETB	Fmin
		MOV	A,YGOL1H		; ���� > 255g
		JZ	YPR_COMT2		; ���
		MOV	A,YGOL1L		; ��
		CJNE	A,#0EH,YPR_COMT0	; 
YPR_COMT0:	JC	YPR_COMT0A		; >=270g ? ���
		MOV   SFRPAGE,#0Fh  	; ��
		ANL	RG_YP,#~UPR_REL2	; -
		ORL	RG_YP,#UPR_REL1	; +
		MOV   SFRPAGE,#0h  	; ����� ��������
		MOV	B,#68H
		JMP	YPR_COMTG
YPR_COMT0A:	MOV	A,#4CH
		ADD	A,YGOL1L
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		ANL	RG_YP,#~UPR_REL2	; 3
		ANL	RG_YP,#~UPR_REL1
		MOV   SFRPAGE,#0h  	; ����� ��������
		JMP	YPR_COMTG1
;************************************
YPR_COMT2:	MOV	A,YGOL1L
		CJNE	A,#0B4H,YPR_COMT21; ���� > 180g
		JMP	YPR_COMT22
		;CLR	Fmin
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		;ANL	RG_YP,#~UPR_REL2	; 3
		;ANL	RG_YP,#~UPR_REL1
		MOV   SFRPAGE,#0h  	; ����� ��������
;************************************			
YPR_COMT21:	JC	YPR_COMT22		; ��
		MOV	B,#0B4H
		MOV   SFRPAGE,#0Fh  	; ����� ��������
		ANL	RG_YP,#~UPR_REL2	; -
		ANL	RG_YP,#~UPR_REL1	; -
		MOV   SFRPAGE,#00h  	; ����� ��������
		JMP	YPR_COMTG
	;******************************
YPR_COMT22:	CLR	Fmin
		CJNE	A,#5AH,YPR_COMT23	; ��� ���� > 90g	
YPR_COMT23:	JC	YPR_COMT3		; ���
		MOV   SFRPAGE,#0Fh  	; �� 
		ANL	RG_YP,#~UPR_REL1	; -
		ORL	RG_YP,#UPR_REL2	; +
		MOV   SFRPAGE,#0h  	; ����� ��������
		MOV	B,#0B4H
		JMP	YPR_COMTG
YPR_COMT3:	MOV   SFRPAGE,#0Fh  	; ����� ��������
		ORL	RG_YP,#UPR_REL1
		ORL	RG_YP,#UPR_REL2		;0
		MOV   SFRPAGE,#0h  	; ����� ��������
		MOV	B,#0H
;************************************
YPR_COMTG:	CLR	C			; ����� ������ � �������
		MOV	A,YGOL1L
		SUBB	A,B
		JNC	YPR_COMTGA
		CPL	A
		INC	A
YPR_COMTGA:	ANL	A,#7FH		; 0 - 128
	;* ������ � �������� ���������� *	
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
;*** ������ ��������� ������. M|D ***
;ANLZ_MD:	
;		MOV   SFRPAGE,#0Fh  	; ����� ��������
;		MOV	A,P5			; �����/�������
;		MOV	B,P7			; ����� ����� � �� �����1 � 2 (4)
;		ANL	B,#0FH		
;		MOV   SFRPAGE,#0h  	; ����� ��������	
;		ANL	A,#1			; ��� �-�� �����/�������
;		JZ	ANLZ_MD1		; ������������� � ��? ��
;		JB	Fin1,ANLZ_MDE	; ���(=1). �-� ��� ���������� ? ��
;		SETB	Fin1			; ���. ���������� ����� ���������
;		MOV   SFRPAGE,#0Fh  	; ����� ��������
;		ORL	P4,#30H		; ������. ����������
;		ANL	P4,#0DFH
;		MOV   SFRPAGE,#0h  	; ����� ��������
;		CLR	C
;		JB	Fmdy,ANLZ_MDE	; ��. ����� �-��.
;		SETB	Fmdy
;		SETB	C			; ���� ���������
;		RET
;		JMP	ANLZ_MDE
;ANLZ_MD1:	CLR	C
;		JNB	Fin1,ANLZ_MDE
;		CLR	Fin1
;		MOV   SFRPAGE,#0Fh  	; ����� ��������
;		ORL	P4,#30H		; ������. ����������
;		ANL	P4,#0EFH
;		MOV   SFRPAGE,#0h  	; ����� ��������	
;		JNB	Fmdy,ANLZ_MDE	; ��. ����� �-��.
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
;*****************	����/���	****************
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
		JNB	Fyno,MAINA1		; ����� ������������� ������? ���.
		CLR	Fyno
		SETB	Fyn1
		CALL	ZAP_SOST
MAINA1:	JNB	Fbe,MAIN1		;���� ����� ��-��� ���-�� ? ���
		CLR	Fbe			; ��.
		CLR	Fobsluj
	;** ������ ����� ���� O|8 ***
	;	JB	Krel,MAINA
	;	MOV   SFRPAGE,#0Fh  	; ����� ��������
	;	ORL	P4,#4			; ������. ����������
	;	MOV   SFRPAGE,#0h  	; ����� ��������
	;	SETB	Kk8	
		JMP	MAINB
;MAINA:	MOV   SFRPAGE,#0Fh  	; ����� ��������
;		ANL	P4,#0FBH		; UPR_REL=0
;		MOV   SFRPAGE,#0h  	; ����� ��������
;		CLR	Kk8	
	;************************
MAINB:	CALL	YPR_COMYT		; ������������� �����������
	;************************
MAIN1:	JNB	Fzpre,MAIN1A	; ��� ������
		CLR	Fzpre
		CALL	ZAP_SOST
	;************************
MAIN1A:	JNB	Fdyk,MAIN11		; �-� ���� ������ ������.
		JB	Fprd1,MAIN11		; ���� �������� ? ��
		CLR	Fdyk
	;*** ������ ��������� ������. M|D 
;		CALL	ANLZ_MD
;		JNC	MAIN11		; ���� ��������� ? ���	
;		CLR	C			; ��
;		MOV	OTVT,#080H
;		CALL	ZAP_SOST		; ������� ��������� CPU
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


