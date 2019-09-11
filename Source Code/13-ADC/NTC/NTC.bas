' ******************************************************************************
' * Title         : NTC.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch NTC at PORTF
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
Dim Ntc As Word , Var As Single , Temperature_c As Single , Temperature_f As Single
'-----------------------
'-----------------------[Constants]
Const V_ref = 5
Const Betta = 4250 : Const Tamp = 298 : Const Betta_tamb = Betta / Tamp       ' 14.2167
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
   Ntc = Getadc(4)
Return
'-----------------------
'--->[Calculate Temperature]
Calc_temp:
   Var = 1024 - Ntc : Var = Ntc / Var : Var = Log(var)
   Var = Var + Betta_tamb : Var = Betta / Var : Temperature_c = Var - 273
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