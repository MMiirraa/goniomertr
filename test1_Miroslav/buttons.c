#include "buttons.h"
#include "MDR1986VE1T.h"

extern unsigned char Fcom;

void ButtonsInit() {
	/*PORTB->FUNC &= 
					~((0x03 << (2 * 8)) |
					 (0x03 << (2 * 9))  |
					 (0x03 << (2 * 10)) |
					 (0x03 << (2 * 11)) |
					 (0x03 << (2 * 12)) |
					 (0x03 << (2 * 13)) |
					 (0x03 << (2 * 14)) |
	         (0x03 << (2 * 15)));
	PORTB->OE &= ~((1 << 8) | (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << 13) | (1 << 14) | (1 << 15));

	PORTB->ANALOG |= (1 << 8) | (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << 13) | (1 << 14) | (1 << 15);

	PORTB->PWR |= 
					~((0x03 << (2 * 8)) |
					 (0x03 << (2 * 9))  |
					 (0x03 << (2 * 10)) |
					 (0x03 << (2 * 11)) |
					 (0x03 << (2 * 12)) |
					 (0x03 << (2 * 13)) |
					 (0x03 << (2 * 14)) |
	         (0x03 << (2 * 15))); */
}

unsigned char Button_Press()
{static unsigned char but_memory,buttons;
	if(but_memory != (buttons=(MDR_PORTB->RXTX >> 8)))
		{but_memory=buttons;
		 return buttons;}
	else return 0;}
	
unsigned char Button_funk(unsigned char btn)	
{	unsigned char ret;	
	switch (btn) {
	case kl7_press:
									ret=8; break;
	case kl6_press:
									ret=7; break;
	case kl5_press:
									ret=6; break;
	case kl4_press:
									ret=5; break;
	case kl3_press:
									ygol_pl(90);	ret=4; Fcom++; break;
	case kl2_press:
									ret=3; break;
	case kl1_press:
									ygol_pl(10); ret=2; Fcom++; break;
	case kl0_press:
									ygol_pl(1);	ret=1; Fcom++; break;
	default:
									ret=0;}
	return ret; }
	
	
	
	
	