' ******************************************************************************
' * Title         : AT24C.bas                                                  *
' * Version       : 1.0                                                        *
' * Last Updated  : 02.08.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : 4bit LCD Mode                                              *
' ******************************************************************************
' USB
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$lib "i2c_twi.lbx"
$baud = 9600
'-----------------------
'------------------------[I2C]
Config Sda = Portd.1
Config Scl = Portd.0
Config Twi = 100000
I2cinit

Config Pind.5 = Output : At24c_wp Alias Portd.5 : Set At24c_wp
'-----------------------
'-----------------------[Variables]
Dim Address_h As Byte , Address_l As Byte
Dim Rd_value As Byte , Wr_value As Byte
'-----------------------
'-----------------------[Constants]
Const At24cw = &HA0
Const At24cr = &HA1
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]

Do
   Input "Value to Write:" , Wr_value
   Input "Address_L:" , Address_l
   Input "Address_H:" , Address_h

   Reset At24c_wp : Waitms 10 : Gosub Write_eeprom : Waitms 10 : Set At24c_wp
   Print "Error W: " ; Err
   Print "-----OK-----"

   Gosub Read_eeprom
   Print "Rd_value: " ; Rd_value
   Print "Error R: " ; Err
   Print "-----OK-----"
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[ ]
Write_eeprom:
    I2cstart                                                'Start condition
    I2cwbyte At24cw                                         'Slave address
    I2cwbyte Address_h                                      'H address of EEPROM
    I2cwbyte Address_l                                      'L address of EEPROM
    I2cwbyte Wr_value                                       'Value to write
    I2cstop                                                 'Stop condition
Return
'-----------------------
'--->[ ]
Read_eeprom:
   I2cstart                                                 'Generate start
   I2cwbyte At24cw                                          'Slave adsress
   I2cwbyte Address_h                                       'H address of EEPROM
   I2cwbyte Address_l                                       'L address of EEPROM
   I2cstart                                                 'Repeated start
   I2cwbyte At24cr                                          'Slave address (read)
   I2crbyte Rd_value , Nack                                 'Read byte
   I2cstop                                                  'Generate stop
Return
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
