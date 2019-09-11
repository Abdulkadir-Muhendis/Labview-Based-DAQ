' ******************************************************************************
' * Title         : VAR.bas                                                    *
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
' Place Jumbers ADC0/ADC1
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configuration]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
Deflcdchar 0 , 32 , 32 , 14 , 17 , 17 , 10 , 27 , 32
'-----------------------
'-----------------------[ADC Configuration]
Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Var_r1 As Word , Var_r2 As Word , Voltage1 As Single , Voltage2 As Single
Dim R1 As Single , R2 As Single
'-----------------------
'-----------------------[Constants]
Const V_ref = 5
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Do
   Gosub Read_adc : Gosub Calc_v : Gosub Calc_r : Cls : Gosub Display_v : Wait 1
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read ADC Input Values]
Read_adc:
   Var_r1 = Getadc(0) : Var_r2 = Getadc(1)
Return
'-----------------------
'--->[Calculate Voltage]
Calc_v:
   Voltage1 = Var_r1 * V_ref : Voltage1 = Voltage1 / 1024
   Voltage2 = Var_r2 * V_ref : Voltage2 = Voltage2 / 1024
Return
'-----------------------
'--->[Calculate Resistors]
Calc_r:
   'VRb = VCC (Rb/R) > Rb = (Voltage x R) / VCC ; Rb: The R val accros the ADC
   R1 = Voltage1 * 10 : R1 = R1 / 5
   R2 = Voltage2 * 10 : R2 = R2 / 5
Return
'-----------------------
'--->[Display the Voltage Values]
Display_v:
   Locate 1 , 1 : Lcd "VR1 " ; Voltage1 ; "V" ; " " ; R1 ; "K" ; Chr(0)
   Locate 2 , 1 : Lcd "VR2 " ; Voltage2 ; "V" ; " " ; R2 ; "K" ; Chr(0)
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~