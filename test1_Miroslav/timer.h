#ifndef TIMER_H
#define TIMER_H

//#include <stdint.h>
//#include "startup.h"
//#include "per.h"
//#include <stdlib.h>

static int Degree = 0;

extern void SysTick_Handler(void);
/*
#define TIMER1_RST_CLK 24
#define TIMER2_RST_CLK 25
#define TIMER3_RST_CLK 26
#define TIMER4_RST_CLK 26

#define TIMER1_RST_CLK_EN (RST_CLK->TIM_CLOCK |= (0x1 << TIMER1_RST_CLK))
#define TIMER2_RST_CLK_EN (RST_CLK->TIM_CLOCK |= (0x1 << TIMER2_RST_CLK))
#define TIMER3_RST_CLK_EN (RST_CLK->TIM_CLOCK |= (0x1 << TIMER3_RST_CLK))
#define TIMER4_RST_CLK_EN (RST_CLK->UART_CLOCK |= (0x1 << TIMER4_RST_CLK))

#define TIMER1_PER_CLOCK 14
#define TIMER2_PER_CLOCK 15
#define TIMER3_PER_CLOCK 16

#define TIMER1_PER_CLOCK_EN (RST_CLK->PER_CLOCK |= (0x1 << TIMER1_PER_CLOCK))
#define TIMER2_PER_CLOCK_EN (RST_CLK->PER_CLOCK |= (0x1 << TIMER2_PER_CLOCK))
#define TIMER3_PER_CLOCK_EN (RST_CLK->PER_CLOCK |= (0x1 << TIMER3_PER_CLOCK))
#define TIMER4_PER_CLOCK_EN (RST_CLK->PER_CLOCK |= (0x1 << TIMER4_PER_CLOCK))

static unsigned int Timer1CurrentValue = 0U;

#define TIMER_INIT(tmr, start, div, base)\
	do{\
		tmr##_PER_CLOCK_EN;\
		(tmr)->CNTRL = 0x0;\
		(tmr)->CNT = (start);\
		(tmr)->PSG = (div);\
		(tmr)->ARR = (base);\
		(tmr)->IE = 0x2;\
		(tmr)->CNTRL = (0x1);\
		tmr##_RST_CLK_EN;\
	} while(0)

#define TIMER_START(tmr) do { *NVIC_ISER |= (0x1 << tmr##_IRQn); } while(0)
#define TIMER_STOP(tmr) do { *NVIC_ICER |= (0x1 << tmr##_IRQn); } while(0)

extern void TIMER1_Handler(void); */

#endif  /* TIMER_H */
