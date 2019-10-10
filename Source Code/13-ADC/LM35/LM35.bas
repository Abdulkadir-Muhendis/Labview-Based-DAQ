' ******************************************************************************
' * Title         : LM35.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch LM35_P and LM35_N at PORTF
' ADC(Val) = (Vin x 1024) / Vref
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
Config Adc = Single , Prescaler = Auto , Reference = Internal
Start Adc
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Lm35_p As Word , Lm35_n As Word
Dim Temperature_c As Single , Temperature_f As Single
'-----------------------[Constants]
Const V_ref = 2.56
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Do
   Gosub Read_adc : Gosub Calc_temp : Gosub Display_temp : Wait 2
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read ADC Input Values]
Read_adc:
   Lm35_p = Getadc(3) : Lm35_n = Getadc(2)
Return
'-----------------------
'--->[Calculate Temperature]
Calc_temp:
   Temperature_c = Lm35_p - Lm35_n : Temperature_c = Temperature_c / 4
Return
'-----------------------
'--->[Display Temperature]
Display_temp:
   Gosub C_to_f : Cls
   Locate 1 , 1 : Lcd "Temp is: " ; Temperature_c ; " C"
   Locate 2 , 1 : Lcd "Temp is: " ; Temperature_f ; " f"
Return
'-----------------------
'--->[Convert C > F] Fahrenheit = 1.8*(Celsius) + 32
C_to_f:
   Temperature_f = 1.8 * Temperature_c : Temperature_f = Temperature_f + 32
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
