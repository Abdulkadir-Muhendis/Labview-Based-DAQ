' ******************************************************************************
' * Title         : GLCD-TS.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 13.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GLCD, Touch-screen                                         *
' ******************************************************************************
' Set GLCD SWitch on (Backlight)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$lib "glcdKS108.lib"
$baud = 9600
'-----------------------
'-----------------------[LCD Configurations]
Config Graphlcd = 128 * 64sed , Dataport = Portc , Controlport = Porta , Ce = 3 , Ce2 = 4 , Cd = 5 , Rd = 6 , Reset = 2 , Enable = 7
'-----------------------
'-----------------------[ADC Configurations]
Config Adc = Single , Prescaler = Auto , Reference = Avcc
Ddrf.6 = 0 : Ddrf.7 = 0                                     'Set PinF.6 & PinF.7 as Input
'-----------------------
Config Portf.5 = Output : Drive_a Alias Portf.5             'Set PinF.5 as Output
Config Portf.4 = Output : Drive_b Alias Portf.4             'Set PinF.4 as Output
'-----------------------[Variables]
Dim X As Dword , Y As Dword , Button As String * 1
Dim X_coord128 As Dword , Y_coord64 As Dword
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]

Waitms 1000 : Cls : Gosub Show_image
Do
   Gosub Read_touch : Gosub Calc_coord
   Waitms 100                                             '150
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[]
Read_touch:
   '--->Read X
   Set Drive_a                                              'Driver-A [LEFT drive on, RIGHT drive on, TOP drive off]
   Reset Drive_b                                            'Driver-B [BOTTOM drive off]
   Waitms 5
   X = Getadc(6)                                            'Read X-axis coordinate [BOTTOM]
   'Print "ADC X : " ; X

   '--->Read Y
   Reset Drive_a                                            'Driver-A [LEFT drive off, RIGHT drive off, TOP drive on]
   Set Drive_b                                              'Driver-B [BOTTOM drive on]
   Waitms 5
   Y = Getadc(7)                                            'Read the Y-axis coordinate [LEFT]
   'Print "ADC Y : " ; Y
Return
'-----------------------
'--->[Claculating the Coordinations]
Calc_coord:
   X = X * 128 : X_coord128 = X / 1024                      'X_coord128 = (X * 128) / 1024
   Y = Y * 64 : Y = Y / 1024 : Y_coord64 = 64 - Y           'Y_coord064 = 64 - ((Y * 64) / 1024)

  'Print "X: " ; X_coord128
  'Print "Y: " ; Y_coord64

   If X_coord128 > 16 And X_coord128 < 40 Then
      If Y_coord64 > 15 And Y_coord64 < 30 Then Button = "A"
      If Y_coord64 > 40 And Y_coord64 < 55 Then Button = "D"
   Elseif X_coord128 > 52 And X_coord128 < 76 Then
      If Y_coord64 > 15 And Y_coord64 < 30 Then Button = "B"
      If Y_coord64 > 40 And Y_coord64 < 55 Then Button = "E"
   Elseif X_coord128 > 90 And X_coord128 < 114 Then
      If Y_coord64 > 15 And Y_coord64 < 30 Then Button = "C"
      If Y_coord64 > 40 And Y_coord64 < 55 Then Button = "F"
   End If

   If X_coord128 > 0 Then Print "The Button is: " ; Button
   Button = "?"
Return
'-----------------------
'--->[Drawing Images on the GLCD]
Show_image:
   Showpic 0 , 0 , Image
Return
'-----------------------
'--->[Include Fonts from Extrnal Font Files]
$include "Font8x8.font"
'-----------------------
'--->[Include Images from Extrnal Image Data Files]
Image:
$bgf "Interface.bgf"
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
''-----------------------------' Y
'| '-----'   '-----'   '-----' | 15
'| |  A  |   |  B  |   |  C  | |
'| '-----'   '-----'   '-----' | 30
'|                             |
'| '-----'   '-----'   '-----' | 40
'| |  D  |   |  E  |   |  F  | |
'| '-----'   '-----'   '-----' | 55
''-----------------------------'
'X:16 > 40   52 > 76   90 > 114
