#include "init.h"
#include "MDR1986VE1T.h"

void My_Init()
{	
  //MDR_EEPROM->CMD = 0x0000018; //Delay = 3
	
	MDR_RST_CLK->HS_CONTROL = 0x01;                   // 1 - on HSE ( PLL )
	while( (MDR_RST_CLK->CLOCK_STATUS & 0x04) == 0);	// HSE ON ?
	MDR_RST_CLK->PLL_CONTROL = ( (1 << 2)  | (8<<8)); // 9 - umnozenie na 10 // 4 - on PLL CPU
	while( (MDR_RST_CLK->CLOCK_STATUS & 0x02) == 0);   // PLL CPU ON
  MDR_RST_CLK->CPU_CLOCK = 0x106;										//  CPU_C3, PLLCPU0 and HSE
	//**** zapusk CPU na 144 mGz ********************
	MDR_RST_CLK->CPU_CLOCK = 0x106;
	MDR_RST_CLK->PER_CLOCK = 0x23e00810;
	//*********************************************** 
	MDR_PORTA->OE = 0xFBC8;
	MDR_PORTA->ANALOG = 0xFFFF;
	//MDR_PORTA->PULL = 0x3800;
	MDR_PORTA->PWR = 0x55555540;
	MDR_PORTA->RXTX = 0xFDF0;
	//*************************
	MDR_PORTB->OE = 0xFF;
	 //MDR_PORTB->PULL = 0xFF00;
	MDR_PORTB->ANALOG = 0xFFFF;
	MDR_PORTB->PWR = 0x5555;	
	MDR_PORTB->RXTX = 0xf0;
	//*************************
	MDR_PORTC->OE = 0x2000;
	MDR_PORTC->ANALOG = 0xFFFF;
	//MDR_PORTA->PULL = 0x3800;
	MDR_PORTC->PWR = 0xC000000;
	MDR_PORTC->RXTX = 0xFFFF;
	//*********** sistem timer **********************
	SysTick->LOAD = 0x23280;	// step
	SysTick->CTRL |= 0x7;			//CLKSOURCE|TCKINT|ENABLE;
}
