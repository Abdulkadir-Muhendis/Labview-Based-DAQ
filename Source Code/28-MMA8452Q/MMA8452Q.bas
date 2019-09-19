' ******************************************************************************
' * Title         : MMA8452Q.bas                                               *
' * Version       : 1.0                                                        *
' * Last Updated  : 08.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' Set LCD SWitch on (Backlight)
' Set Switch SDA, SCL, INTA, INTB
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
'------------------------[I2C]
Config Sda = Portd.1
Config Scl = Portd.0
Config Twi = 100000
I2cinit
'-----------------------
'------------------------[INT2 | INT3]
Config Pind.2 = Input
Config Int2 = Falling
On Int2 Int2_isr

Config Pind.3 = Input
Config Int3 = Falling
On Int3 Int3_isr
'-----------------------
'-----------------------[Variables]
Dim X_msb As Byte , X_lsb As Byte , X_axis As Word
Dim Y_msb As Byte , Y_lsb As Byte , Y_axis As Word
Dim Z_msb As Byte , Z_lsb As Byte , Z_axis As Word
Dim Cutoffvalue As Byte , Ctrl_reg1 As Byte
Dim X_axis_s As String * 1 , Y_axis_s As String * 1 , Z_axis_s As String * 1
'-----------------------
'-----------------------[Constants]
Const Mma8452w = &H38
Const Mma8452r = &H39
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Cursor Off Noblink
Waitms 1000
Gosub Mma845x_active
Do
   Gosub Mma845x_read_xyz : Gosub Display_xyz               ': Gosub Mma845x_standby
   Wait 1
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[INT2 > MMA8452Q INA]
Int2_isr:
   Print "INTA"
Return
'-----------------------
'--->[INT3 > MMA8452Q INB]
Int3_isr:
   Print "INTB"
Return
'-----------------------
'--->[ ]
'
Mma845x_read_xyz:
   I2cstart
   I2cwbyte Mma8452w
   I2cwbyte 1

   I2cstart
   I2cwbyte Mma8452r

   I2crbyte X_msb , Ack
   I2crbyte X_lsb , Ack
   I2crbyte Y_msb , Ack
   I2crbyte Y_lsb , Ack
   I2crbyte Z_msb , Ack
   I2crbyte Z_lsb , Nack

   I2cstop
Return
'-----------------------
'--->[Standby Mode]
'Read current value of CTRL_REG1 [&H2A]; sensor in Standby Mode > Active = 0 (B0)
Mma845x_standby:
   'change B0[0], CTRL_REG1 [&H2A]
   I2cstart
   I2cwbyte Mma8452w
   I2cwbyte &H2A

   I2cstart
   I2cwbyte Mma8452r

   I2crbyte Ctrl_reg1 , Nack
   I2cstop

   Print Bin(ctrl_reg1)
Return
'-----------------------
'--->[Active Mode]
'CTRL_REG1 [&H2A]; sensor in active Mode > Active = 1 (B0)
Mma845x_active:
   'change B0[1], CTRL_REG1 [&H2A]
   I2cstart
   I2cwbyte Mma8452w
   I2cwbyte &H2A
   I2cwbyte &B00000001
   I2cstop
Return
'-----------------------
'--->[2g,4g,8g Active Mode]
'XYZ_DATA_CFG Register [&H0E], ±2g > FS0 = 0 (B0) & FS1 = 0 (B1)
Mma845x_scale:
   Gosub Mma845x_standby
   'change B0,1[00], XYZ_DATA_CFG Register [&H0E]
   Gosub Mma845x_active
Return
'-----------------------
'--->[Setting the Data Rate]
'CTRL_REG1 [&H2A]; DR = 000 (B5,B4,B3), 800 Hz
Mma845x_datarate:
   Gosub Mma845x_standby
   'change B3,4,5[000], CTRL_REG1 [&H2A]
   Gosub Mma845x_active
Return
'-----------------------
'--->[Setting the Oversampling Mode]
'CTRL_REG2 [&H2B]; Oversampling Mode: Normal MODS=00 (B0,B1)
Mma845x_:
   Gosub Mma845x_standby
   'change B0,1[00], CTRL_REG2 [&H2B]
   Gosub Mma845x_active
Return
'-----------------------
'--->[Setting the High Pass Filter Cut-off Frequency]
'HP_FILTER_CUTOFF register [&H0F]
Mma845x_oversampling:
   Gosub Mma845x_standby
   Cutoffvalue = 2
   'change B0,1[11], HP_FILTER_CUTOFF [&H0F]
   Gosub Mma845x_active
Return
'-----------------------
'--->[ ]
'
Mma845x_1:

Return
'-----------------------

'--->[ ]
Display_xyz:
   X_axis = Makeint(x_lsb , X_msb)                          ': Shift X_axis , Right , 2       ', Signed
   Y_axis = Makeint(y_lsb , Y_msb)                          ': Shift Y_axis , Right , 2       ', Signed
   Z_axis = Makeint(z_lsb , Z_msb)                          ': Shift Z_axis , Right , 2       ', Signed

   If X_msb > &B01111111 Then
      X_axis_s = "-" : X_axis = Not X_axis : X_axis = X_axis + 1
   Else
      X_axis_s = "+"
   End If
   Shift X_axis , Right , 4

   If Y_msb > &B01111111 Then
      Y_axis_s = "-" : Y_axis = Not Y_axis : Y_axis = Y_axis + 1
   Else
      Y_axis_s = "+"
   End If
   Shift Y_axis , Right , 4

   If Z_msb > &B01111111 Then
      Z_axis_s = "-" : Z_axis = Not Z_axis : Z_axis = Z_axis + 1
   Else
      Z_axis_s = "+"
   End If
   Shift Z_axis , Right , 4

   Print X_axis_s ; X_axis
   Print Y_axis_s ; Y_axis
   Print Z_axis_s ; Z_axis
   Print "---------"
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~