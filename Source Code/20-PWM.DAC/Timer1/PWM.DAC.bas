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
Config Timer1 = Pwm , Prescale = 1 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up , Pwm = 10
Tccr1a.0 = 1                                                'WGM10
Tccr1a.1 = 1                                                'WGM11
Tccr1b.3 = 1                                                'WGM12
Tccr1b.4 = 0                                                'WGM13
'-----------------------
'-----------------------[GPIO Configurations]
Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 1  'PU Internal Resistor
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 1
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim Last_ocr As Word , Per As Single
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Cls : Ocr1a = 0 : Last_ocr = 1
Do
   If Sw_right = 0 Then
      Incr Pwm1a : Incr Pwm1b
   Elseif Sw_left = 0 Then
      Decr Compare1a : Decr Compare1b
   End If

   If Ocr1a <> Last_ocr Then Gosub Display_ocr
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Display OC2 Value]
Display_ocr:
   Cls : Last_ocr = Ocr1a
   Locate 1 , 1 : Lcd "OCR = " ; Pwm1a
   Per = Pwm1b / 10.24 : Locate 2 , 1 : Lcd "Per = " ; Per ; " %"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
