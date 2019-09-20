' ******************************************************************************
' * Title         : L298.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   :                                               *
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
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[ADC Configuration]
Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim 4sw As Word , Voltage As Single , Sw As String * 1
'-----------------------
'-----------------------[Constants]
Const V_ref = 5
'-----------------------
'-----------------------[PWM Configuration]
'ENA > OC3A | ENB > OC3B
Config Timer3 = Pwm , Pwm = 8 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up , Prescale = 256
'-----------------------
'-----------------------[GPIO Configurations]
Config Pinb.4 = Output : L298_in1 Alias Portb.4 : Reset L298_in1
Config Pinb.5 = Output : L298_in2 Alias Portb.5 : Reset L298_in2

Config Pinb.6 = Output : L298_in3 Alias Portb.6 : Reset L298_in3
Config Pinb.7 = Output : L298_in4 Alias Portb.7 : Reset L298_in4

Config Pine.3 = Output : L298_e1 Alias Porte.3 : Set L298_e1
Config Pine.4 = Output : L298_e2 Alias Porte.4 : Set L298_e2

'-----------------------
'-----------------------[Constants]

'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]

Cursor Off : Cls

Do

   Gosub Read_adc : Gosub Calc_v

   Select Case Voltage
      Case 1 To 1.9 : Gosub Increase_motor_speed
      Case 2 To 2.9 : Gosub Decrease_motor_speed
      Case 3 To 3.9 : Gosub Turn_motor_right
      Case 4 To 4.6 : Gosub Turn_motor_left
   End Select

   Waitms 50

Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------
'--->[ ]
Increase_motor_speed:
   If Pwm3a >= 254 Then Pwm3a = 254 Else Incr Pwm3a
   If Pwm3b >= 254 Then Pwm3b = 254 Else Incr Pwm3b
   Cls : Lcd Pwm3a ; " - " ; Pwm3b
   Waitms 25
Return
'-----------------------
'--->[ ]
Decrease_motor_speed:
   If Pwm3a = 0 Then Pwm3a = 0 Else Decr Pwm3a
   If Pwm3b = 0 Then Pwm3b = 0 Else Decr Pwm3b
   Cls : Lcd Pwm3a ; " - " ; Pwm3b
   Waitms 25
Return
'-----------------------
'--->[ ]
Turn_motor_right:
   Set L298_in1 : Reset L298_in2
   Set L298_in3 : Reset L298_in4
   Waitms 100
Return
'-----------------------
'--->[ ]
Turn_motor_left:
   Reset L298_in1 : Set L298_in2
   Reset L298_in3 : Set L298_in4
   Waitms 100
Return
'-----------------------
'--->[ ]
Calc_speed:

Return
'-----------------------
'--->[ ]
Read_adc:
   4sw = Getadc(7)
Return
'-----------------------
'--->[Calculate Voltage]
Calc_v:
   Voltage = 4sw * V_ref : Voltage = Voltage / 1024
Return
'-----------------------
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~