' ******************************************************************************
' * Title         : L298.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 01.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
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
'-----------------------[GPIO Configurations]
Config Pinb.4 = Output : L298_in1 Alias Portb.4 : Reset L298_in1
Config Pinb.5 = Output : L298_in2 Alias Portb.5 : Reset L298_in2

Config Pinb.6 = Output : L298_in3 Alias Portb.6 : Reset L298_in3
Config Pinb.7 = Output : L298_in4 Alias Portb.7 : Reset L298_in4

Config Pine.3 = Output : L298_ena Alias Porte.3 : Reset L298_ena
Config Pine.4 = Output : L298_enb Alias Porte.4 : Reset L298_enb
'-----------------------
'-----------------------[GPIO Configurations]
Config Debounce = 100
'Config Pine.4 = Input : Turn_left Alias Pine.4 : Porte.4 = 1       'PU Internal Resistor
Config Pine.6 = Input : Turn_right Alias Pine.6 : Porte.6 = 1

Config Pine.5 = Input : Speed_up Alias Pine.5 : Porte.5 = 1
Config Pine.7 = Input : Speed_down Alias Pine.7 : Porte.7 = 1

Config Pind.2 = Input : On_off Alias Pind.2 : Portd.2 = 1
'-----------------------
'-----------------------[Variables]
Dim Toggle_bit As Bit
Dim N As Word                                               'Lenght of index
Dim I As Word                                               'Cycles ratio
Dim Direct As Byte                                          'Variable direction' 1-left, any num keys right
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "START" : Set Toggle_bit
Do
   Direct = 0 : N = 0
   Input "Insert direction 1-left, any num keys right:=" , Direct
   Input "Insert steep cycles:= " , N
   Set L298_ena : Set L298_enb
   If Direct = 1 Then
      For I = 1 To N                                        'If 1-key was pressed call steep_left subroutine
         gosub Step_left
      Next I
   Else
      For I = 1 To N                                        'Otherwise call steep_right subroutine
         Gosub Step_right
      Next I
   End If
   Reset L298_ena : Reset L298_enb
'   Debounce On_off , 0 , Motor_on_off , Sub

'   If Speed_up = 0 Then Gosub Increase_motor_speed
'   If Speed_down = 0 Then Gosub Decrease_motor_speed

   'Debounce Turn_left , 0 , Turn_motor_left , Sub
   'Debounce Turn_right , 0 , Turn_motor_right , Sub
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[ ]
Motor_on_off:
   If Toggle_bit = 0 Then
      Set Toggle_bit : Reset L298_ena : Reset L298_enb
   Else
      Reset Toggle_bit : Set L298_ena : Set L298_enb
   End If
   Waitms 100
Return
'-----------------------
'--->[ ]
Step_right:
'   Set L298_in1 : Reset L298_in2 : Reset L298_in3 : Reset L298_in4
'   Waitms 10
'   Reset L298_in1 : Set L298_in2 : Reset L298_in3 : Reset L298_in4
'   Waitms 10
'   Reset L298_in1 : Reset L298_in2 : Set L298_in3 : Reset L298_in4
'   Waitms 10
'   Reset L298_in1 : Reset L298_in2 : Reset L298_in3 : Set L298_in4
'   Waitms 10
   Reset L298_in1 : Set L298_in2 : Set L298_in3 : Set L298_in4
   Waitms 10
   Set L298_in1 : Reset L298_in2 : Set L298_in3 : Set L298_in4
   Waitms 10
   Set L298_in1 : Set L298_in2 : Reset L298_in3 : Set L298_in4
   Waitms 10
   Set L298_in1 : Set L298_in2 : Set L298_in3 : Reset L298_in4
   Waitms 10
Return
'-----------------------
'--->[ ]
Step_left:
'   Reset L298_in1 : Reset L298_in2 : Reset L298_in3 : Set L298_in4
'   Waitms 10
'   Reset L298_in1 : Reset L298_in2 : Set L298_in3 : Reset L298_in4
'   Waitms 10
'   Reset L298_in1 : Set L298_in2 : Reset L298_in3 : Reset L298_in4
'   Waitms 10
'   Set L298_in1 : Reset L298_in2 : Reset L298_in3 : Reset L298_in4
'   Waitms 10
   Set L298_in1 : Set L298_in2 : Set L298_in3 : Reset L298_in4
   Waitms 10
   Set L298_in1 : Set L298_in2 : Reset L298_in3 : Set L298_in4
   Waitms 10
   Set L298_in1 : Reset L298_in2 : Set L298_in3 : Set L298_in4
   Waitms 10
   Reset L298_in1 : Set L298_in2 : Set L298_in3 : Set L298_in4
   Waitms 10
Return
'-----------------------
'--->[ ]
Calc_step:

Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
