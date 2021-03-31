#include "startup.h"

/* определения компоновщика */
extern unsigned long __etext;                      /* конец секции кода */
extern unsigned long __data_start__, __data_end__; /* начало и конец секции данных */
extern unsigned long __bss_start__, __bss_end__;   /* начало и конец секции неиниц. данных */
extern unsigned long __StackTop;                   /* вершина стека */

static void Default_Handler(void) { while(1) {  } }
extern void Reset_Handler          (void);
extern void NMI_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void HardFault_Handler      (void) __attribute__((weak, alias("Default_Handler")));
extern void SVC_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void PendSV_Handler         (void) __attribute__((weak, alias("Default_Handler")));
extern void SysTick_Handler        (void) __attribute__((weak, alias("Default_Handler")));
extern void MIL_STD_1553B2_Handler (void) __attribute__((weak, alias("Default_Handler")));
extern void MIL_STD_1553B1_Handler (void) __attribute__((weak, alias("Default_Handler")));
extern void USB_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void CAN1_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void CAN2_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void DMA_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void UART1_Handler          (void) __attribute__((weak, alias("Default_Handler")));
extern void UART2_Handler          (void) __attribute__((weak, alias("Default_Handler")));
extern void SSP1_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void BUSY_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void ARINC429R_Handler      (void) __attribute__((weak, alias("Default_Handler")));
extern void POWER_Handler          (void) __attribute__((weak, alias("Default_Handler")));
extern void WWDG_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMER4_Handler	       (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMER1_Handler	       (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMER2_Handler         (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMER3_Handler	       (void) __attribute__((weak, alias("Default_Handler")));
extern void ADC_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void ETHERNET_Handler       (void) __attribute__((weak, alias("Default_Handler")));
extern void SSP3_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void SSP2_Handler           (void) __attribute__((weak, alias("Default_Handler")));
extern void ARINC429T1_Handler	   (void) __attribute__((weak, alias("Default_Handler")));
extern void ARINC429T2_Handler	   (void) __attribute__((weak, alias("Default_Handler")));
extern void ARINC429T3_Handler	   (void) __attribute__((weak, alias("Default_Handler")));
extern void ARINC429T4_Handler     (void) __attribute__((weak, alias("Default_Handler")));
extern void BKP_Handler            (void) __attribute__((weak, alias("Default_Handler")));
extern void EXT_INT1_Handler       (void) __attribute__((weak, alias("Default_Handler")));
extern void EXT_INT2_Handler       (void) __attribute__((weak, alias("Default_Handler")));
extern void EXT_INT3_Handler       (void) __attribute__((weak, alias("Default_Handler")));
extern void EXT_INT4_Handler       (void) __attribute__((weak, alias("Default_Handler")));

extern int main(void);

void Reset_Handler(void) {
	// Копирование данных в ОЗУ
	unsigned long *pSrc = &__etext, *pDest= &__data_start__;
	while (pDest < &__data_end__) *pDest++ = *pSrc++;

	// Очистка секции bss (в соответствии со стандартом)
	pDest = &__bss_start__;
	while (pDest < &__bss_end__) *pDest++ = 0ul;

	main();
	while(1);
}

typedef void (*nvic_vector_t)(void);

/* секция векторов прерываний */
const nvic_vector_t __Vectors[]  __attribute__((section(".isr_vector"))) = 
{
	(nvic_vector_t)&__StackTop,
	Reset_Handler,
	NMI_Handler,
	HardFault_Handler,
	0, 0, 0, 0, 0, 0, 0,
	SVC_Handler,
	0, 0,
	PendSV_Handler,
	SysTick_Handler,
	MIL_STD_1553B2_Handler,
	MIL_STD_1553B1_Handler,
	USB_Handler,
	CAN1_Handler,
	CAN2_Handler,
	DMA_Handler,
	UART1_Handler,
	UART2_Handler,
	SSP1_Handler,
	BUSY_Handler,
	ARINC429R_Handler,
	POWER_Handler,
	WWDG_Handler,
	TIMER4_Handler,
	TIMER1_Handler,
	TIMER2_Handler,
	TIMER3_Handler,
	ADC_Handler,
	ETHERNET_Handler,
	SSP3_Handler,
	SSP2_Handler,
	ARINC429T1_Handler,
	ARINC429T2_Handler,
	ARINC429T3_Handler,
	ARINC429T4_Handler,
	0, 0,
	BKP_Handler,
	EXT_INT1_Handler,
	EXT_INT2_Handler,
	EXT_INT3_Handler,
	EXT_INT4_Handler
};
