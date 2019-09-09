' ******************************************************************************
' * Title         : SW_VCC.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 18.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GPIOs as Input; Active High                                *
' ******************************************************************************
' Set the Jumbers: SW to VCC       (Active High)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[GPIO Configurations]
Config Debounce = 50

Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 0  'PD Internal Resistor
Config Pine.5 = Input : Sw_up Alias Pine.5 : Porte.5 = 0
Config Pine.6 = Input : Sw_right Alias Pine.6 : Porte.6 = 0
Config Pine.7 = Input : Sw_down Alias Pine.7 : Porte.7 = 0
'-----------------------
'-----------------------[Variables]
Dim I As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Bitwait Sw_up , set : Gosub Sw_u
   Bitwait Sw_left , Set : Gosub Sw_l
   Bitwait Sw_down , Set : Gosub Sw_d
   Bitwait Sw_right , Set : Gosub Sw_r
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