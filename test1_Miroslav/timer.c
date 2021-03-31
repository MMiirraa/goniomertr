#include "timer.h"
//#include "per.h"
//#include "indicator.h"

extern unsigned char flg1;
extern unsigned int	cnt_klv;
//void TimerIRQClock();

void SysTick_Handler()
{
	flg1++; cnt_klv++;
	return;
}
/* void TIMER1_Handler()
{
	static int i = 0;
	if(++i < 0x1ff) return;
	else i = 0;

	static int dig[3];
	static int pos = 2;
	static Razrs razr = Razr2;
	Digits(Degree, dig);
	
	for(int i = 0; i < 0xff; ++i){
		Indicate(dig[pos--], razr++);
	
		if(pos < 0) {	
			//Clear();
			pos = 2;
			razr = Razr2;
		}
	}
	
	Degree = rand() % 200;
	
	return;
		
}*/