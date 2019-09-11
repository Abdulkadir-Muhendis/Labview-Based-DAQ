' ******************************************************************************
' * Title         : RTC.bas                                                    *
' * Version       : 1.0                                                        *
' * Last Updated  : 18.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : RTC Unit                                                   *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Place a 32KHz Crystal
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[LCD Configurations]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'-----------------------[RTC Configurations]
Config Clock = Soft
Config Date = Dmy , Separator = /
'-----------------------
'-----------------------[Variables]
Dim Last_sec As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Enable Interrupts : Cls : Cursor Off
Time$ = "16:59:00"                                          'Initial Time
Date$ = "14/04/08"                                          'Initial Date

Do
   If _sec <> Last_sec Then
      Last_sec = _sec
      Locate 1 , 1 : Lcd "Time: " ; Time$
      Locate 2 , 1 : Lcd "Date: " ; Date$
   End If
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'Input "Enter the time(hh:mm:ss):" , Time$
'Input "Enter the time(DD:MM:YY):" , Date$