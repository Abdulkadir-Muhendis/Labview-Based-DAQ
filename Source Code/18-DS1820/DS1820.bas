' ******************************************************************************
' * Title         : NTC.bas                                                    *
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
' Set Switch NTC at PORTF
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[1-wire Configuration]
Config 1wire = Portd.7
'-----------------------
'-----------------------[Single Variable Configuration]
Config Single = Scientific , Digits = 2
'-----------------------
'-----------------------[Variables]
Dim I As Byte                                               ' Index
Dim Crc As Byte                                             ' DS1820 CRC
Dim Serial_num(8) As Byte                                   ' Serial Number of DS1820 Device
Dim Uart_var As String * 2 , Sdata As Byte , S_r As Byte
Dim Temperature As Integer , Stat_buf As Byte
Dim 1w_count As Word , Family_code As Byte
Dim Cel_frac_bit As Byte
Dim W As Word , Minus As Bit , F As Byte , Temp As Word

Dim Memory_map(9) As Byte
'Memory_map(1)                           'Temperature LSB
'Memory_map(2)                           'Temperature MSB
'Memory_map(3)                           'TH/user byte 1
'Memory_map(4)                           'TL/user byte 2
'Memory_map(5)                           'config  x R1 R0 1 1 1 1 1
'Memory_map(6)                           'res
'Memory_map(7)                           'res
'Memory_map(8)                           'res
'Memory_map(9)                           '8 CRC
'-----------------------
'-----------------------[Constants]
'>DS18B20 ROM Commands
Const Read_rom = &H33
Const Skip_rom = &HCC
Const Match_rom = &H55
Const Search_rom = &HF0
Const Alarm_search = &HEC
'>DS18B20 Function Commands
Const Convert = &H44
Const Read_ram = &HBE
Const Copy_ram = &H48
Const Write_ram = &H4E
Const Recall_ee = &HB8
Const Read_power = &HB4

Const Ds18x20_fracconv = 625
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "start"
Do
   If Ischarwaiting() = 1 Then
      Uart_var = Inkey()
      Select Case Uart_var
         Case "1" : Gosub Count_1wire_devices
         Case "2" : Gosub Search_1wire_devices
         Case "3" : Gosub Verify_1wire_id
         Case "4" : Gosub Measure
      End Select
   End If
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Reads the number of 1-wire devices attached to the bus]
Count_1wire_devices:
   1w_count = 1wirecount() : Print 1w_count
Return
'-----------------------
'--->[Reads the Devices ID from the 1-wire bus]
Search_1wire_devices:
   Serial_num(1) = 1wsearchfirst()
   For I = 1 To 8 : Print Hex(serial_num(i)) ; : Next
   Print
   If Serial_num(8) = Crc8(serial_num(1) , 7) Then
      Print "CRC is OK!"
   Else
      Print "CRC is Wrong!"
   End If
   Print

   If 1w_count > 1 Then
      Do
         Serial_num(1) = 1wsearchnext()
         For I = 1 To 8 : Print Hex(serial_num(i)) ; : Next
         Print
      Loop Until Err = 1
   End If
Return
'-----------------------
'--->[Verifies if an ID is available on the 1-wire bus]
Verify_1wire_id:
   1wverify Serial_num(1)
   If Err = 0 Then Print "OK!" Else Print "No Device!"
Return
'-----------------------
'--->[ ]
Measure:
   Gosub Convert_temp : Waitms 1000
   1wverify Serial_num(1)
   If Err = 1 Then
      Print "Sensor is not on bus"
   Elseif Err = 0 Then
      Print "Sensor is ok"
      Gosub Get_temp
   End If
Return
'-----------------------
'--->[ ]
Ds18b20_configuration:

Return
'-----------------------
'--->[ ]
Convert_temp:
   1wreset
   1wwrite Skip_rom
   1wwrite Convert
   Print "Done"
Return
'-----------------------
'--->[Get Temperature]
Get_temp:
   '1wreset
   1wwrite Read_ram
   Memory_map(1) = 1wread(9)
   For I = 1 To 9 : Print Hex(memory_map(i)) : Next I
   If Memory_map(9) = Crc8(memory_map(1) , 8) Then
      Temperature = Makeint(memory_map(1) , Memory_map(2))
      Print "CRC is ok"

      Shift Temperature , Right , 4
      Cel_frac_bit = Temperature And &HF


      Temp = Cel_frac_bit * Ds18x20_fracconv

      Temp = Temp / 1000
      Temperature = Temperature * 10
      Temp = Temp + Temperature
      W = Temp / 10
      F = Temp Mod 10
      Print W ; "." ; F ; " C"
 End If
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~