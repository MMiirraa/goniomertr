#ifndef BUTTONS_H
#define BUTTONS_H

#include "MDR1986VE1T.h"

/* коды клавиш */
#define	kl0_press 0xFE 
#define	kl1_press	0xFD 
#define	kl2_press	0xFB 
#define	kl3_press	0xF7 
#define	kl4_press	0xEF 
#define	kl5_press 0xDF
#define	kl6_press 0xBF
#define	kl7_press 0x7F

/*  */
unsigned char Button_Press(void);
unsigned char Button_funk(unsigned char btn);		
void	ButtonsInit(void);
extern void ygol_pl(uint32_t stp);

#endif /* BUTTONS_H */
		