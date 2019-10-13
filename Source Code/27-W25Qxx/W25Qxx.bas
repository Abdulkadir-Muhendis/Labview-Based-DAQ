' ******************************************************************************
' * Title         : W25Qxxx.bas                                                *
' * Version       : 1.0                                                        *
' * Last Updated  : 13.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch  - Place the SF.En Jumber
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-----------------------
'-----------------------[SPI Configuration]
Config Spi = Hard , Interrupt = Off , Data Order = Msb , Master = Yes , Polarity = Low , Phase = 0 , Clockrate = 16 , Noss = None , Spiin = 0
Config Portb.4 = Output : W25q_ss Alias Portb.4 : Set W25q_ss       'Active Low
Config Portb.5 = Output : W25q_wp Alias Portb.5 : Set W25q_wp       'Active Low
Spiinit
'-----------------------
'-----------------------[Variables]
Dim Spi_cmd As Byte , Spi_data(256) As Byte , Spi_add(3) As Byte
Dim Cmd As Byte , Addr(3) As Byte , I As Byte , Serial_cmd As Byte , Byte_num As Byte
'-----------------------[Constants]
Const Wr_en = &H06
Const Wr_ds = &H04
Const Rd_sr = &H05
Const Rd_db = &H03
Const Wr_db = &H02
Const Bl_er = &HD8
Const Se_er = &H20
Const Ch_er = &H60
Const Mf_id = &H90
Const Jedec = &H9F
Const Pw_dn = &HB9
Const Pw_up = &HAB
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Print "START"
Do
   If Ischarwaiting() = 1 Then
      Serial_cmd = Inkey()
      Select Case Serial_cmd
         Case "A" : Gosub Write_enable
         Case "B" : Gosub Write_disable
         Case "C" : Gosub Read_status_register
         Case "D" : Gosub Sector_erase
         Case "E" : Gosub Block_erase
         Case "F" : Gosub Chip_erase
         Case "G" : Gosub Power_down
         Case "H" : Gosub Power_up
         Case "I" : Gosub Mfr_device_id
         Case "J" : Gosub Jedec_id
         Case "K" : Gosub Read_data
         Case "L" : Gosub Page_program
      End Select
   End If
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[CMD=&H06]
Write_enable:
   Spi_cmd = Wr_en
   Reset W25q_ss : Spiout Spi_cmd , 1 : Set W25q_ss
Return
'-----------------------
'--->[CMD=&H04]
Write_disable:
   Spi_cmd = Wr_ds
   Reset W25q_ss : Spiout Spi_cmd , 1 : Set W25q_ss
Return
'-----------------------
'--->[CMD=&H05]
Read_status_register:
   Spi_cmd = Rd_sr
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiin Spi_data(1) , 1 : Printbin Spi_data(1) ; 1
   Set W25q_ss
Return
'-----------------------
'--->[CMD=&H20]
Sector_erase:
   Gosub Write_enable : Waitms 1
   Spi_cmd = Se_er
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiout Spi_add(1) , 3
   Set W25q_ss
   Do
      Gosub Read_status_register
   Loop Until Spi_data(1) = 0
Return
'-----------------------
'--->[CMD=&HD8]
Block_erase:
   Gosub Write_enable : Waitms 1
   Spi_cmd = Bl_er
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiout Spi_add(1) , 3
   Set W25q_ss
   Do
      Gosub Read_status_register
   Loop Until Spi_data(1) = 0
Return
'-----------------------
'--->[CMD=&H60]
Chip_erase:
   Gosub Write_enable : Waitms 1
   Spi_cmd = Ch_er
   Reset W25q_ss : Spiout Spi_cmd , 1 : Set W25q_ss
   Do
      Gosub Read_status_register
   Loop Until Spi_data(1) = 0
Return
'-----------------------
'--->[CMD=&HB9]
Power_down:
   Spi_cmd = Pw_dn
   Reset W25q_ss : Spiout Spi_cmd , 1 : Set W25q_ss
Return
'-----------------------
'--->[CMD=&HAB]
Power_up:
   Spi_cmd = Pw_up
   Reset W25q_ss : Spiout Spi_cmd , 1 : Set W25q_ss
Return
'-----------------------
'--->[CMD=&H90]
Mfr_device_id:
   Spi_cmd = Mf_id
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiout Spi_add(1) , 3
      Spiin Spi_data(1) , 2 : Printbin Spi_data(1) ; 2
   Set W25q_ss
Return
'-----------------------
'--->[CMD=&H9F]
Jedec_id:
   Spi_cmd = Jedec
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiin Spi_data(1) , 3 : Printbin Spi_data(1) ; 3
   Set W25q_ss
Return
'-----------------------
'--->[CMD=&H03]
Read_data:
   Spi_cmd = Rd_db : Byte_num = 255
   Spi_add(1) = 0 : Spi_add(2) = 0 : Spi_add(3) = 0
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiout Spi_add(1) , 3
      For I = 1 To Byte_num
         Spiin Spi_data(i) , 1
      Next I
      For I = 1 To Byte_num : Printbin Spi_data(i) ; 1 : Next I
   Set W25q_ss
Return
'-----------------------
'--->[CMD=&H02]
Page_program:
   Gosub Write_enable : Waitms 1
   Spi_cmd = Wr_db : Byte_num = 255
   For I = 1 To Byte_num : Spi_data(i) = I : Next I
   Spi_add(1) = 0 : Spi_add(2) = 0 : Spi_add(3) = 0
   Reset W25q_ss
      Spiout Spi_cmd , 1
      Spiout Spi_add(1) , 3
      For I = 1 To Byte_num
         Spiout Spi_data(i) , 1
      Next I
   Set W25q_ss
   Do
      Gosub Read_status_register
   Loop Until Spi_data(1) = 0
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
