' ******************************************************************************
' * Title         : DS3232.bas                                                 *
' * Version       : 1.0                                                        *
' * Last Updated  : 02.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : RTC Unit                                                   *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$lib "i2c_twi.lbx"
'-----------------------
'-----------------------[LCD Configurations]
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
'-----------------------
'------------------------[I2C]
Config Sda = Portd.1
Config Scl = Portd.0
Config Twi = 100000

Config Clock = User
Const Ds3232w = &HD0
Const Ds3232r = &HD1
I2cinit
Config Date = Dmy , Separator = /
'-----------------------
'------------------------[INT0]
Config Int7 = Rising
On Int7 Int7_isr
Config Pine.7 = Input : Porte.7 = 1
'-----------------------
'-----------------------[Buzzer Configurations]
Config Pind.6 = Output : Buzzer Alias Portd.6 : Reset Buzzer       'Active High
'-----------------------
'-----------------------[SW Configurations]
Config Debounce = 50
Config Pine.4 = Input : Sw_left Alias Pine.4 : Porte.4 = 1  'PU Internal Resistor
'-----------------------[Variables]
Dim Dsp_flag As Bit , Weekday As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Enable Int7 : Enable Interrupts : Cls : Cursor Off
gosub Initial
Do
   If Dsp_flag = 1 Then
      Reset Dsp_flag : Gosub Getdatetime : Gosub Tic
      Locate 1 , 1 : Lcd "Time: " ; Time$
      Locate 2 , 1 : Lcd "Date: " ; Date$
   End If

   'Debounce Sw_left , 0 , Initial , Sub
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[DS3232 Initial Settings]
Initial:
   Time$ = "16:30:30"                                       'Initial Time
   Date$ = "01/08/11"                                       'Initial Date
   Gosub Dec_bcd_date : Gosub Dec_bcd_time
   Gosub Setdate : Gosub Settime : Gosub Set_sqw
Return
'-------------
'--->[INT7 - SQW]
Int7_isr:
   Set Dsp_flag
Return
'-------------
'--->[DS3232 Get Time & Date]
Getdatetime:
   I2cstart
   I2cwbyte Ds3232w
   I2cwbyte 0

   I2cstart
   I2cwbyte Ds3232r
   I2crbyte _sec , Ack
   I2crbyte _min , Ack
   I2crbyte _hour , Ack

   I2crbyte Weekday , Ack
   I2crbyte _day , Ack
   I2crbyte _month , Ack
   I2crbyte _year , Nack
   I2cstop

   Gosub Bcd_dec_date : Gosub Bcd_dec_time
Return
'-------------
'--->[DS3232 Set Date]
Setdate:
   I2cstart
   I2cwbyte Ds3232w
   I2cwbyte 4
   I2cwbyte _day
   I2cwbyte _month
   I2cwbyte _year
   I2cstop
Return
'-------------
'--->[DS3232 Set Time]
Settime:
   I2cstart
   I2cwbyte Ds3232w
   I2cwbyte 0
   I2cwbyte _sec
   I2cwbyte _min
   I2cwbyte _hour
   I2cstop
Return
'-------------
'--->[DS3232 Set Settings]
Set_sqw:
   I2cstart
   I2cwbyte Ds3232w
   I2cwbyte &H0E
   I2cwbyte &B00000000
   I2cwbyte &B00000000
   I2cstop
Return
'-------------
'--->[DEC>BCD DATE]
Dec_bcd_date:
   _day = Makebcd(_day) : _month = Makebcd(_month) : _year = Makebcd(_year)
Return
'-------------
'--->[DEC>BCD TIME]
Dec_bcd_time:
   _sec = Makebcd(_sec) : _min = Makebcd(_min) : _hour = Makebcd(_hour)
Return
'-------------
'--->[BCD>DEC DATE]
Bcd_dec_date:
   _day = Makedec(_day) : _month = Makedec(_month) : _year = Makedec(_year)
Return
'-------------
'--->[BCD>DEC TIME]
Bcd_dec_time:
   _sec = Makedec(_sec) : _min = Makedec(_min) : _hour = Makedec(_hour)
Return
'-------------
'--->[Sec Tic]
Tic:
   Set Buzzer : Waitms 25 : Reset Buzzer
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
