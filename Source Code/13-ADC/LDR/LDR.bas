' ******************************************************************************
' * Title         : LDR.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch LDR at PORTF
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configuration]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[ADC Configuration]
Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Ldr As Word , Ldr_v As Single
'-----------------------
'-----------------------[Constants]
Const V_ref = 5
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Do
   Gosub Read_adc : Gosub Calc_lux : Gosub Display_lux : Wait 2
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read ADC Input Values]
Read_adc:
   Ldr = Getadc(5)
Return
'-----------------------
'--->[Calculate LUX]
'Vo = 5 * Rl /(rl + 3.3) > Lux =(2500 / Vo - 500) / 3.3
Calc_lux:
   Ldr_v = Ldr * V_ref : Ldr_v = Ldr_v / 1024
Return
'-----------------------
'--->[Display LUX]
Display_lux:
   Cls
   Locate 1 , 1 : Lcd "LDR Vol: " ; Ldr_v ; " V"
   Locate 2 , 1 : Lcd "LUX    : " ; "    " ; " L"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
