#include "indicator.h"
//#include "per.h"
#include "MDR1986VE1T.h"
#include "MDR32F9Qx_port.h"             // Keil::Drivers:PORT
//#include "buttons.c"

extern uint32_t ygol;
extern char smvl1,smvl2,smvl3,Fkryg;
const unsigned char segm7[10]={0x44,0x5F,0x26,0x0E,
								0x1D,0x8C,0x84,0x5E,0x04,0x0C};
/*
void IndicatorInit(void) 
{
	// Тактирование портов A и B 
	RST_CLK->PER_CLOCK |= (1 << 21) | (1 << 22) | (1 << 24);
		
	// Элементы цифр индикатора 
	PORTB->FUNC &= ~0xFF;	
	PORTB->OE |= 0xFF;
	PORTB->ANALOG |= 0xFF;
	PORTB->PWR |= (0x3 << (2 * 0)) | (0x3 << (2 * 1)) | (0x3 << (2 * 2)) | (0x3 << (2 * 3)) | (0x3 << (2 * 4)) | (0x3 << (2 * 5)) |(0x3 << (2 * 6)) |(0x3 << (2 * 7));
	
	// Элементы цифр индикатора 
	PORTD->FUNC = 0x00000000;	
	PORTD->OE |= 0xFFFFFFFF;
	PORTD->ANALOG |= (0x1 << 0);
	PORTD->PWR |= (0x3 << (2 * 0));
	
	// Разряды индикатора 
	PORTA->FUNC = 0x00000000;
	PORTA->OE |= (0x1 << Razr0) | (0x1 << Razr1) | (0x1 << Razr2);
	PORTA->ANALOG |= (0x1 << Razr0) | (0x1 << Razr1) | (0x1 << Razr2);
	PORTA->PWR |= (0x3 << (2 * Razr0)) | (0x1 << (2 * Razr1)) | (0x1 << (2 * Razr2));
}*/

void Indicate(void) 
{ static char ind_s;
	MDR_PORTA->SETTX=0x3C0;
	MDR_PORTB->CLRTX=0xFF;
	switch (ind_s) {
		case 0x0 :	MDR_PORTA->CLRTX=0x040;
			MDR_PORTB->RXTX |=segm7[smvl1];	ind_s++; break;
		case 0x1 :	MDR_PORTA->CLRTX=0x80;
			MDR_PORTB->RXTX |=segm7[smvl2];	ind_s++; break;	
		case 0x2 :	MDR_PORTA->CLRTX=0x100;
			MDR_PORTB->RXTX |=segm7[smvl3];	ind_s=0; break;	}	
	//RETURN;
}


void ygol_pl(uint32_t stp) 
{ uint32_t ygolm1,ygolm2;
	ygol += stp;
	if(ygol > 359) ygol -= 359;
	smvl1=ygol/100; ygolm1=smvl1*100;
	smvl2=(ygol - ygolm1)/10;
	smvl3=(ygol - ygolm1 - smvl2*10);
	}

Numbers NextNumber(Numbers curr) 
{
	switch(curr) 
	{
		case Zero: return One;
		case One: return Two;
		case Two: return Tree;
		case Tree: return Four;
		case Four: return Five;
		case Five: return Six;
		case Six: return Seven;
		case Seven: return Eight;
		case Eight: return Nine;
		case Nine: return Zero;
		case None: return None;
		default: return None;	
	}
}

Numbers Number(int num) 
{
	switch(num) 
	{
		case -1: return None;
		case 1: return One;
		case 2: return Two;
		case 3: return Tree;
		case 4: return Four;
		case 5: return Five;
		case 6: return Six;
		case 7: return Seven;
		case 8: return Eight;
		case 9: return Nine;
		case 0: return Zero;
		default: return None;
	}
}

