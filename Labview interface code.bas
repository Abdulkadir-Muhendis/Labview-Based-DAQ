' ******************************************************************************
' * Title         : Data Acquisition System for phoenix AVR Supplied with Scada*
' * Version       : 1.0                                                        *
' * Last Updated  : 30.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Abdulkadir MÜHENDİS                                        *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' ADC(Val) = (Vin x 1024) / Vref
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]-------------------------------------------
$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'-------------------------------------------------------------------------------
'-----------------------[LCD Configuration]-------------------------------------
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portg.1 , Rs = Portg.0 , Wr = Portg.2
Config Lcd = 16 * 2
 Dim I As Integer
'-------------------------------------------------------------------------------
'-----------------------[ADC Configuration]-------------------------------------
Config Adc = Single , Prescaler = Auto , Reference = Internal
Start Adc
Config Porta = Input:
Config Portb = Output
Porta = 255
Config Pind.6 = Output : Buzzer Alias Portd.6 : Reset Buzzer
'-------------------------------------------------------------------------------
'-----------------------[Variables]---------------------------------------------
Analog_sensors Alias Pinf
Digital_sensors Alias Pina
Dim Dig_input As Byte
Dim Led As Byte
Dim Mic As Word , Lm35_1 As Word , Lm35_2 As Word , Ldr As Word , Rc As Word
Dim Adc1 As String * 4 , Adc2 As String * 4 , Adc3 As String * 4 , Adc5 As String * 4 , Adc6 As String * 4
Dim Flag As Bit
Dim Temp_flag As Bit
'-------------------------------------------------------------------------------
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'------------------->[Main Program]---------------------------------------------
Cursor Off Noblink
Gosub Display_authors
Do
Waitms 200
Gosub Get_analog
Gosub Get_digital
Gosub Send
Gosub Ready
Loop
End

'----------------------<[End Main]----------------------------------------------
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'---------------------->[Display Authors]---------------------------------------
Display_authors:
Cls
Locate 1 , 1 : Lcd "DAQ+SCADA system"
Locate 2 , 1 : Lcd "Abdelkader&WALAA"
'Gosub Shift2right
'Gosub Shift2left
Return
'-------------------------------------------------------------------------------
'-----------------[Get analoge Sensor]------------------------------------------
Get_analog:
Mic = Getadc(1)
Adc1 = Str(mic )
Adc1 = Format(adc1 , "    ")
Lm35_2 = Getadc(2)
Adc2 = Str(lm35_2 )
Adc2 = Format(adc2 , "    ")
Lm35_1 = Getadc(3)
Adc3 = Str(lm35_1 )
Adc3 = Format(adc3 , "    ")
Ldr = Getadc(5)
Adc5 = Str(ldr )
Adc5 = Format(adc5 , "    ")
Rc = Getadc(6)
Adc6 = Str(rc )
Adc6 = Format(adc6 , "    ")
'-------------------------------------------------------------------------------
'-------------------------[Send Data to Labview]--------------------------------
Send:

Print Adc1 ; Adc3 ; Adc2 ; Adc5 ; Adc6 ;
Printbin Dig_input
Printbin 10
Return
'-------------------------------------------------------------------------------
'-----------------------[Read Data form Labview]--------------------------------
Ready:
Inputbin Led
Portb = Led
Flag = Led.0
If Flag = 0 Then
   Set Buzzer
   If Temp_flag = 0 Then
      Temp_flag = 1
      Cls : Lcd "     Alarm" : Lowerline : Lcd "      LDR"
   End If
Else
   Reset Buzzer
   If Temp_flag = 1 Then
      Temp_flag = 0
      Cls : Lcd "DAQ,SCADA system" : Lowerline : Lcd "Abdelkader&WALAA"
   End If
End If
Return
'-------------------------------------------------------------------------------
'-------------------------------[Digital_sensors]-------------------------------
Get_digital:
Dig_input = Digital_sensors
Return


Shift2right:
   For I = 1 To 8
      Shiftlcd Right : Waitms 500
   Next I
Return
'-------------------------------------------------------------------------------
'-------------------->[Shift LCD Char to Left]----------------------------------
Shift2left:
   For I = 1 To 8
      Shiftlcd Left : Waitms 500
   Next I
Return
'-------------------------------------------------------------------------------
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
