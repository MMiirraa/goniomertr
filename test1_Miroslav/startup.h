#ifndef STARTUP_H
#define STARTUP_H

/* номера прерываний */
typedef enum nvic_vector_num
{
  NonMaskableInt_IRQn         = -14,    /* 2 Non Maskable Interrupt           */
  HardFault_IRQn              = -13,    /* 3 Cortex-M1 Hard Fault Interrupt   */
  SVCall_IRQn                 = -5,     /* 11 Cortex-M1 SV Call Interrupt     */
  PendSV_IRQn                 = -2,     /* 14 Cortex-M1 Pend SV Interrupt     */
  SysTick_IRQn                = -1,     /* 15 Cortex-M1 System Tick Interrupt */
  MIL_STD_1553B2_IRQn         = 0,      /* MIL_STD_1553B2 Interrupt           */
  MIL_STD_1553B1_IRQn         = 1,      /* MIL_STD_1553B1 Interrupt           */
  USB_IRQn                    = 2,      /* USB Host Interrupt                 */
  CAN1_IRQn                   = 3,      /* CAN1 Interrupt                     */
  CAN2_IRQn                   = 4,      /* CAN2 Interrupt                     */
  DMA_IRQn                    = 5,      /* DMA Interrupt                      */
  UART1_IRQn                  = 6,      /* UART1 Interrupt                    */
  UART2_IRQn                  = 7,      /* UART2 Interrupt                    */
  SSP1_IRQn                   = 8,      /* SSP1 Interrupt                     */
  BUSY_IRQn                   = 9,      /* BUSY Interrupt                     */
  ARINC429R_IRQn              = 10,     /* ARINC429 Receiver Interrupt        */
  POWER_IRQn                  = 11,     /* POWER Detecor Interrupt            */
  WWDG_IRQn                   = 12,     /* Window Watchdog Interrupt          */
  TIMER4_IRQn                 = 13,     /* Timer4 Interrupt                   */
  TIMER1_IRQn                 = 14,     /* Timer1 Interrupt                   */
  TIMER2_IRQn                 = 15,     /* Timer2 Interrupt                   */
  TIMER3_IRQn                 = 16,     /* Timer3 Interrupt                   */
  ADC_IRQn                    = 17,     /* ADC Interrupt                      */
  ETHERNET_IRQn               = 18,     /* Ethernet Interrupt                 */
  SSP3_IRQn                   = 19,     /* SSP3 Interrupt                     */
  SSP2_IRQn                   = 20,     /* SSP2 Interrupt                     */
  ARINC429T1_IRQn             = 21,     /* ARINC429 Transmitter 1 Interrupt   */
  ARINC429T2_IRQn             = 22,     /* ARINC429 Transmitter 2 Interrupt   */
  ARINC429T3_IRQn             = 23,     /* ARINC429 Transmitter 3 Interrupt   */
  ARINC429T4_IRQn             = 24,     /* ARINC429 Transmitter 4 Interrupt   */
  BKP_IRQn                    = 27,     /* BACKUP Interrupt                   */
  EXT_INT1_IRQn               = 28,     /* EXT_INT1 Interrupt                 */
  EXT_INT2_IRQn               = 29,     /* EXT_INT2 Interrupt                 */
  EXT_INT3_IRQn               = 30,     /* EXT_INT3 Interrupt                 */
  EXT_INT4_IRQn               = 31      /* EXT_INT4 Interrupt                 */
} nvic_vector_num_t;

#endif /* STARTUP_H */
