RCC 			EQU 	0x40023800
RCC_AHB1ENR 	EQU 	(RCC+0x30)

GPIOF 			EQU 	0x40021400
GPIOF_BSRR 		EQU 	(GPIOF+0x18)
GPIOF_MODER 	EQU 	(GPIOF+0x00)
GPIOF_OTYPER 	EQU 	(GPIOF+0x04)
GPIOF_OSPEEDR 	EQU 	(GPIOF+0x08)
GPIOF_ODR 		EQU 	(GPIOF+0x14)
	
	
	AREA LAB, CODE, READONLY
	EXPORT beepInit
	EXPORT beepOn
	EXPORT beepOff
	ENTRY
	
	
beepInit
	;外设时钟使能
	LDR	R0,	=RCC_AHB1ENR
	LDR R1, [R0]
	ORR R1,	#0x24
	STR R1,	[R0]
	
	;设置通用模式
	LDR	R0, =GPIOF_MODER
	LDR	R1,	=0x110000
	STR R1,	[R0]

	;设置推挽输出
	LDR R0,	=GPIOF_OTYPER
	LDR R1,	=0xFFFFFAFF
	STR R1, [R0]

	;设置中速
	LDR R0,	=GPIOF_OSPEEDR
	LDR R1, =0x110000
	STR R1,	[R0]

	;复位
	LDR R0, =GPIOF_BSRR
	MOV R1, #0
	STR R1,	[R0]
	;初始化完成

beepOn
	LDR R0,	=GPIOF_ODR
	LDR R1, =0X100
	STR R1,	[R0]
	BX 	lr
	ENDP

beepOff
	LDR R0,	=GPIOF_ODR
	LDR R1, =0	;TODO
	STR R1,	[R0]
	BX 	lr
	ENDP
