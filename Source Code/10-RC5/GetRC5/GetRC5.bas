' ******************************************************************************
' * Title         : GetRC5.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 26.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : RC5 Receiver; LCD                                          *
' * Description   : RC5 Code with 4bit LCD Mode                                *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Place the
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
'-----------------------
'-----------------------[LCD Configurations]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[RC5 Receiver Configurations]
Config Rc5 = Pind.4 , Wait = 2000
'-----------------------
'-----------------------[Variables]
Dim Rc5_address As Byte , Rc5_command As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Enable Interrupts : Cls
Do
   Gosub Read_rc5 : Waitms 100
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Read RC5 Code]
Read_rc5:
   Getrc5(rc5_address , Rc5_command)
   If Rc5_address <> 255 Then
      Rc5_command = Rc5_command And &B01111111
      Cls
      Locate 1 , 1 : Lcd "Address is: " ; Rc5_address
      Locate 2 , 1 : Lcd "Command is: " ; Rc5_command
   End If
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~