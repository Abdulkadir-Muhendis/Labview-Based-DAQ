' ******************************************************************************
' * Title         : MTS6219.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
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
$baud = 9600
'-----------------------
'-----------------------[LCD Configuration]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0
Config Lcd = 16 * 2
'-----------------------
'-----------------------[PWM Configuration]
Config Timer3 = Pwm , Pwm = 8 , Compare A Pwm = Clear Down , Compare B Pwm = Clear Down , Prescale = 64
'-----------------------
'-----------------------[GPIO Configurations]
Config Pinb.5 = Output : L6219_i01 Alias Portb.5 : Set L6219_i01       'Set High > No corrent
Config Pinb.4 = Output : L6219_i11 Alias Portb.4 : Set L6219_i11

'Config Pine.3 = Output : M1_phase Alias Porte.3

Config Pinb.7 = Output : L6219_i02 Alias Portb.7 : Set L6219_i02       'Set High > No corrent
Config Pinb.6 = Output : L6219_i12 Alias Portb.6 : Set L6219_i12

'Config Pine.4 = Output : M2_phase Alias Porte.4
'-----------------------
'-----------------------[Variables]
Dim Serial_cmd As Byte
'-----------------------
'-----------------------[Constants]
Const Pwm_threshold = 255                                   '8-bit PWM
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "START"
Do
   If Ischarwaiting() = 1 Then
      Serial_cmd = Inkey()
      Select Case Serial_cmd
         Case "A" : Gosub Run_m1
         Case "B" : Gosub Stop_m1
         Case "C" : Gosub Run_m2
         Case "D" : Gosub Stop_m2
         Case "E" : Gosub M1_speed_incr
         Case "F" : Gosub M1_speed_decr
      End Select
   End If
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[ ]
Run_m1:
   Reset L6219_i01 : Reset L6219_i11
Return
'-----------------------
'--->[ ]
Stop_m1:
   Set L6219_i01 : Set L6219_i11
Return
'-----------------------
'--->[ ]
Run_m2:
   Reset L6219_i01 : Reset L6219_i11
Return
'-----------------------
'--->[ ]
Stop_m2:
   Set L6219_i01 : Set L6219_i11
Return
'-----------------------
'--->[ ]
M1_speed_incr:
   If Pwm3a < Pwm_threshold Then Pwm3a = Pwm3a + 5
  'Set M1_phase
Return
'-----------------------
'--->[ ]
M1_speed_decr:
   If Pwm3a > 0 Then Pwm1a = Pwm3a - 5
   'Reset M1_phase
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~