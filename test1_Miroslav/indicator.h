#ifndef INDICATOR_H
#define INDICATOR_H

#include <stdint.h>
#include <math.h>

enum { Freq = 0xff };
typedef enum 
{
	Razr0 = 8,
	Razr1 = 7,
	Razr2 = 6
} Razrs;

typedef enum 
{
	Zero = 0x44,
	One = 0x5F,
	Two = 0x26,
	Tree = 0x0E,
	Four = 0x1D,
	Five = 0x8C,
	Six = 0x84,
	Seven = 0x5E,
	Eight = 0x04,
	Nine = 0x0C,
	None = 0xFF
} Numbers;

extern Numbers NextNumber(Numbers curr);
extern void IndicatorInit(void);
extern void Indicate(void);
extern void ygol_pl(uint32_t stp);

extern int *Digits(int num, int *res);
extern Numbers Number(int num);
extern Numbers NextNumber(Numbers curr);

#endif /* INDICATOR_H */