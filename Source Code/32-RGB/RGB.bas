' ******************************************************************************
' * Title         : RGB.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   :                                               *
' ******************************************************************************
' Set RGB LED Jumbers
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
Config Porte.3 = Output
Config Porte.4 = Output
Config Porte.5 = Output

Config Timer3 = Pwm , Prescale = 1 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up , Compare C Pwm = Clear Up , Pwm = 8 , Prescale = 8
'Tccr3a.0 = 1                                                'WGM10
'Tccr3a.1 = 1                                                'WGM11
'Tccr3b.3 = 1                                                'WGM12
'Tccr3b.4 = 0                                                'WGM13

'-----------------------
'-----------------------[GPIO Configurations]
Config Pine.7 = Input : Sw_left Alias Pine.7 : Porte.7 = 1  'PU Internal Resistor
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 1
'-----------------------[Single Variable Configuration]
'Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Last_ocr As Word , Per As Single
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Cls
Compare3a = 255
Compare3b = 101
Compare3c = 135
Do



   If Sw_right = 0 Then Incr Compare3a
   If Sw_left = 0 Then Incr Compare3b
      'Incr Pwm1a : Incr Pwm1b
   'Elseif Sw_left = 0 Then
      'Decr Compare1a : Decr Compare1b
   'End If

   'If Ocr1a <> Last_ocr Then Gosub Display_ocr
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Display OCR Value]
Display_ocr:
'   Cls : Last_ocr = Ocr1a
'   Locate 1 , 1 : Lcd "OCR = " ; Pwm1a
'   Per = Pwm1b / 10.24 : Locate 2 , 1 : Lcd "Per = " ; Per ; " %"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
