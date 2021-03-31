//#include <stdio.h>
#include "MDR1986VE1T.h"
#include "timer.h"
#include "buttons.h"
#include "indicator.h"
#include "commytat.h"

unsigned char flg1,flg2,a,b,klv_press,Fcom;
char smvl1=0,smvl2=0,smvl3=0,Fkryg;
unsigned int cnt_klv;

uint32_t ygol,stp;

int main (void)
{				
	My_Init();
	//MDR_PORTA->RXTX=0xFFDF;
	//MDR_PORTB->RXTX=0xFF00;
	klv_press=Button_Press();
	while(1) // osnovnoy sikl
	{ //****** meandr 1kGz PC13 (Pin 72) *********
		if(flg1){ flg1=0;
			if(flg2) // meandr
				{flg2=0;  MDR_PORTC->RXTX=0xDFFF; } //   -|_
			else {flg2++;  MDR_PORTC->RXTX=0xFFFF; } // _|-
		//***** step opros buttons ***** 	
		if(cnt_klv>=20) {cnt_klv=0; 
			klv_press=Button_Press(); 
			if(klv_press !=0 ) // est klavisha on ?
			{a=Button_funk(klv_press); //nomer fynksii
			  if(a==3) // perekl. kryg/8
						{if(Fkryg) { Fkryg=0; ygol_pl(0);} 
						 else {Fkryg=1; smvl1=smvl2=smvl3=0xff; }}} 
		Indicate();
		if(Fcom){Fcom=0; YprCommyt();} }
		}
	}
}

