' ******************************************************************************
' * Title         : Encoder.bas                                                *
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
' Place the Encoder Jumbers
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[GPIO Configuration]
Config Pind.0 = Input : Portd.0 = 1
Config Pind.1 = Input : Portd.1 = 1
Config Pind.2 = Input : Sw_center Alias Pind.2 : Portd.2 = 1

Config Pine.5 = Input : Sw_up Alias Pine.5 : Porte.5 = 1    'PU Internal Resistor
Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 1
Config Pine.7 = Input : Sw_down Alias Pine.7 : Porte.7 = 1
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 1
'-----------------------
'-----------------------[Variables]
Dim Encoder_val As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "Encoder Test"
Do
   Encoder_val = Encoder(pind.0 , Pind.1 , En_left , En_right , 0)

   If Sw_up = 0 Then Print "Switch Up!"
   If Sw_left = 0 Then Print "Switch Left!"
   If Sw_down = 0 Then Print "Switch Down!"
   If Sw_right = 0 Then Print "Switch Right!"
   If Sw_center = 0 Then Print "Switch Center!"
   Waitms 100
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Turn to Left]
En_left:
   Print "Left rotation< " ; Encoder_val
Return
'-----------------------
'--->[Turn to Right]
En_right:
   Print "Right rotation> " ; Encoder_val
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~