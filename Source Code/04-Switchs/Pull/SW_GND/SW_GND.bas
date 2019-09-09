' ******************************************************************************
' * Title         : SW_GND.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 18.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GPIOs as Input; Active Low                                 *
' ******************************************************************************
' Set the Jumbers: SW to GND       (Active Low)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[GPIO Configurations]
Config Debounce = 50

Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 1  'PU Internal Resistor
Config Pine.5 = Input : Sw_up Alias Pine.5 : Porte.5 = 1
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 1
Config Pine.7 = Input : Sw_down Alias Pine.7 : Porte.7 = 1
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   If Sw_up = 0 Then Gosub Sw_u
   If Sw_left = 0 Then Gosub Sw_l
   If Sw_down = 0 Then Gosub Sw_d
   If Sw_right = 0 Then Gosub Sw_r
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Print]
Sw_l:
   Print "Switch Left is Pressed!"
Return

Sw_u:
   Print "Switch Up is Pressed!"
Return

Sw_r:
   Print "Switch Right is Pressed!"
Return

Sw_d:
   Print "Switch Down is Pressed!"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~