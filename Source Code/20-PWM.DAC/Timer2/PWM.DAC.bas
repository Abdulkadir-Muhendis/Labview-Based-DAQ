' ******************************************************************************
' * Title         : PWM.DAC.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configuration]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[PWM Configuration]
Config Timer2 = Pwm , Prescale = 1 , Compare = Toggle , Pwm = On , Compare Pwm = Clear Up
Tccr2.3 = 1                                                 'WGM21    "Fast PWM"
Tccr2.6 = 1                                                 'WGM20
Config Pinb.7 = Output
'-----------------------
'-----------------------[GPIO Configurations]
Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 1  'PU Internal Resistor
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 1
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Last_ocr2 As Byte , Per As Single
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Cls : Ocr2 = 0 : Last_ocr2 = 1
Do
   If Sw_right = 0 Then Incr Ocr2
   If Sw_left = 0 Then Decr Ocr2

   If Ocr2 <> Last_ocr2 Then Gosub Display_ocr2
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Display OC2 Value]
Display_ocr2:
   Cls : Last_ocr2 = Ocr2
   Locate 1 , 1 : Lcd "OCR2 = " ; Ocr2
   Per = Ocr2 / 2.55 : Locate 2 , 1 : Lcd "Pers = " ; Per ; " %"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
