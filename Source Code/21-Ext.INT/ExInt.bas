' ******************************************************************************
' * Title         : ExtInt.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 03.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Place the SWs Jumber to GND
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[Ext INTs Configuration]
Config Int4 = Rising : On Int4 Int4_isr : Enable Int4
Config Int5 = Falling : On Int5 Int5_isr : Enable Int5
Config Int6 = Change : On Int6 Int6_isr : Enable Int6
Config Int7 = Low Level : On Int7 Int7_isr : Enable Int7

'Porte = &B11110000
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Enable Interrupts
Print "Start"
Do
   nop
Loop Until Inkey() = 27
Print "Exit!"
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[INT4 ISR]
Int4_isr:
   Print "Int4 Occurred at the Rising Edge!"
Return
'-----------------------
'--->[INT5 ISR]
Int5_isr:
   Print "Int5 Occurred at the Falling Edge!"
Return
'-----------------------
'--->[INT6 ISR]
Int6_isr:
   Print "Int6 Occurred at the Change of Edge!"
Return
'-----------------------
'--->[INT7 ISR]
Int7_isr:
   'Disable Int7
   Print "Int7 Occurred at the Low Level!"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
