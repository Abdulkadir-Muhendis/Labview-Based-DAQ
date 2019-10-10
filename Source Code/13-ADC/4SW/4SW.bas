' ******************************************************************************
' * Title         : 4SW.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch 4SW at PORTF
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
Dim 4sw As Word , Voltage As Single , Sw As String * 1
'-----------------------
'-----------------------[Constants]
Const V_ref = 5
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Do
   Gosub Read_adc : Gosub Calc_v : Cls : Gosub Display_v : Wait 1
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read ADC Input Values]
Read_adc:
   4sw = Getadc(7)
Return
'-----------------------
'--->[Calculate Voltage]
Calc_v:
   Voltage = 4sw * V_ref : Voltage = Voltage / 1024
Return
'-----------------------
'--->[Display the Pressed SW]
Display_v:
   Select Case Voltage
      Case 1 To 1.9 : Sw = "1"
      Case 2 To 2.9 : Sw = "2"
      Case 3 To 3.9 : Sw = "3"
      Case 4 To 4.9 : Sw = "4"
      Case Else : Sw = "?"
   End Select

   Locate 1 , 1 : Lcd "ADC Vol: " ; Voltage ; " V"
   Locate 2 , 1 : Lcd "Switch NO. " ; Sw
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
