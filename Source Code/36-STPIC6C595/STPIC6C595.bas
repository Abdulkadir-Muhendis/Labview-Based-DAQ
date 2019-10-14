' ******************************************************************************
' * Title         : Ladder.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 26.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GPIOs as Input; Active High                                *
' ******************************************************************************
' Place a Capacitor in the RC header
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
Config Portf.0 = Output : Sr_sck Alias Portf.0
Config Porte.2 = Output : Sr_sdi Alias Porte.2
Config Porte.3 = Output : Sr_rck Alias Porte.3
'-----------------------[Variables]
Dim I As Byte , Value As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Cls : Value = 255
Do
   'For I = 0 To 255
      'Value = 2 ^ I
      If Value = 255 Then Value = 0 Else Value = 255
      Shiftout Sr_sdi , Sr_sck , Value , 0 , 8 , 100
      Set Sr_rck : Waitms 10 : Reset Sr_rck
      Waitms 1000
   'Next I
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
