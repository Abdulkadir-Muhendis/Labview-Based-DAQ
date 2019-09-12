' ******************************************************************************
' * Title         : RS485.bas                                                  *
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : LEDs                                                       *
' * Description   : GPIOs as Outputs                                           *
' ******************************************************************************
' Set Switches: RS485.RXD, RS485.TXD
' Place Jusmber RS485.D
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
'-----------------------[RS485 Configuration]
Config Print0 = Porte.3 , Mode = Set
Config Pine.3 = Output
'-----------------------
'-----------------------[GPIO Configuration]
Config Pine.4 = Input : Sw Alias Pine.4 : Porte.4 = 1
'-----------------------
'-----------------------[Variables]
Dim Char As String * 1
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink : Cls
Do
   Debounce Sw , 0 , Sendall , Sub
   If Ischarwaiting() = 1 Then
      Char = Inkey()
      Lcd Char
   End If
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Send To RS485]
Sendall:
   Print "This is RS485 Test Program"
   Print "Based-on MAX485"
   Print "University of Aleppo-Syria"
   Print "Faculty of EEE"
   Print "Control Department"
   Print "Walid BALID"
   Print ":)"
   Waitms 200
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~