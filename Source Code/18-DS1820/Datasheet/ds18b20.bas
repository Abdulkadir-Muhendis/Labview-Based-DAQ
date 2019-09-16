'*************************************************
'* Code to test DS18x20
'* The 1-wire bus pin is Port B.4
'* Tested 14th Dec 2008 with Bascom 1.11.9.1
'*
'* Will handle multiple DS18S20 or DS18B20 devices
'* Brett England
'*************************************************

$regfile = "m8def.dat"
$crystal = 8000000                                          ' we are using this frequency

Declare Sub Convallt                                        ' Convert T on ALL sensors
Declare Sub Meas_to_cel(offset As Byte)
Declare Sub Temp_to_decicel
Declare Sub Disp_temp(cnt As Byte , Offset As Byte)

' Up to 8 devices - each having an 8 byte ROMID
Const Max1wire = 8
Dim Dsid(64) As Byte                                        ' Dallas ID 64bit inc. CRC
Dim Sc(9) As Byte                                           ' scratch pad
Dim Cnt1wire As Byte                                        ' Number of 1-wire devices found

Dim Cel As Integer
Dim Cel_frac_bit As Byte
Dim Subzero As Byte
Dim Temp As Integer

'Temp variables
Dim B As Byte
Dim B1 As Byte
Dim B2 As Byte
Dim I As Byte
Dim W As Word

Const Ds18b20_conf_reg = 4

' constant to convert the fraction bits to cel*(10^-4)
Const Ds18x20_fracconv = 625

' DS18x20 ROM ID
Const Ds18s20_id = &H10
Const Ds18b20_id = &H28

' COMMANDS
Const Ds18x20_convert_t = &H44
Const Ds18x20_read = &HBE
Const Ds18x20_write = &H4E
Const Ds18x20_ee_write = &H48
Const Ds18x20_ee_recall = &HB8
Const Ds18x20_read_power_supply = &HB4

'LCD config
Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 1a

Config 1wire = Pb.4                                         ' DS1820 on Port B.4 (mega8 pin 18)

Cursor Off
Cls

Lcd "1-wire DS18x20"
Wait 1
Cls

' Gather ROM ID for all 1-wire devices
Cnt1wire = 1wirecount()
If Cnt1wire > Max1wire Then
  Cnt1wire = Max1wire
End If

B = 1
Dsid(b) = 1wsearchfirst()
For I = 1 To Cnt1wire
  B = B + 8
  Dsid(b) = 1wsearchnext()
Next

' Show what we found on the bus
B1 = 1
B2 = 8
For I = 1 To Cnt1wire
  Cls
  If Dsid(b2) = Crc8(dsid(b1) , 7) Then
    Lcd "CRC OK sensor " ; I
    Waitms 500
    Cls
    Lcd "ROM ID "
    For B = B1 To B2
      Lcd Hex(dsid(b))
    Next
  Else
    Lcd "CRC BAD sensor " ; I
  End If
  Wait 1
  B1 = B1 + 8
  B2 = B2 + 8
Next


' Monitor temperature sensors
Do
  Convallt
  Waitms 750

  B = 1
  For I = 1 To Cnt1wire

    If Dsid(b) = Ds18s20_id Or Dsid(b) = Ds18b20_id Then    ' Only process TEMP sensors
      1wverify Dsid(b)                                      'Issues the "Match ROM "
      If Err = 1 Then
        Lcd "18x20 not on bus"                              'where did it go?
      Elseif Err = 0 Then
        1wwrite Ds18x20_read
        Sc(1) = 1wread(9)
        If Sc(9) = Crc8(sc(1) , 8) Then
          Call Disp_temp(i , B)
          If I < Cnt1wire Then                              ' if more 1-wire devices.
             Wait 1
          End If
        End If
      End If
    End If

    B = B + 8
  Next

Loop

End

'Makes the Dallas "Convert T" command on the 1w-bus configured in "Config 1wire = Portb. "
'WAIT 200-750 ms after issued, internal conversion time for the sensor
'SKIPS ROM - so it makes the conversion on ALL sensors on the bus simultaniously
'When leaving this sub, NO sensor is selected, but ALL sensors has the actual
'temperature in their scratchpad ( within 750 ms )
Sub Convallt
 1wreset                                                    ' reset the bus
 1wwrite &HCC                                               ' skip rom
 1wwrite Ds18x20_convert_t
End Sub


' Display the temperature
' INPUT: temp
Sub Disp_temp(cnt As Byte , Offset As Byte)
  Call Meas_to_cel(offset)
  Call Temp_to_decicel

  Cls
  Lcd "TEMP " ; Cnt ; " "
  If Subzero = 1 Then
    Lcd "-"
  Else
    Lcd "+"
  End If

  W = Temp / 10
  B1 = Temp Mod 10
  Lcd W ; "." ; B1
  Lcd " C"
End Sub

' input:
'   - offset - in the dsid array which 1-wire are we addressing
' output:
'   - cel full celsius
'   - fractions of celsius in millicelsius*(10^-1)/625 (the 4 LS-Bits)
'   - subzero =0 positiv / 1 negativ
Sub Meas_to_cel(offset As Byte)
 Dim Meas As Word

 Meas = 0
 Meas = Makeint(sc(1) , Sc(2))

 ' 18S20 is only 9bit upscale to 12bit
 If Dsid(offset) = Ds18s20_id Then
   Meas = Meas And &HFFFE
   Shift Meas , Left , 3
   B1 = 16 - Sc(6)                                          ' sc(6) count remain
   B1 = B1 - 4
   Meas = Meas + B1
 End If

 W = Meas And &H8000
 If W = &H8000 Then
   Subzero = 1
   ' convert to +ve, (two's complement)++
   Meas = Meas Xor &HFFFF
   Incr Meas
 Else
   Subzero = 0
 End If

 If Dsid(offset) = Ds18b20_id Then
   B1 = Sc(ds18b20_conf_reg)
   ' clear undefined bit for != 12bit
   If B1.5 = 1 And B1.6 = 1 Then                            ' 12 bit
    ' nothing
   Elseif B1.6 = 1 Then                                     ' 11 bit
     Meas = Meas And &HFFFE
   Elseif B1.5 = 1 Then                                     '10 bit
     Meas = Meas And &HFFFC
   Else                                                     ' 9 bit
     Meas = Meas And &HFFF8
   End If
 End If

 Cel = Meas
 Shift Cel , Right , 4
 Cel_frac_bit = Meas And &HF
End Sub

' input: cel, cel_frac_bit, subzero
' output: temp (as decicelsius)
' ie 289 = 28.9C
Sub Temp_to_decicel
  Temp = Cel_frac_bit * Ds18x20_fracconv
  Temp = Temp / 1000
  Cel = Cel * 10
  Temp = Temp + Cel
  If Subzero = 1 Then
     Restore Rounding
     For B1 = 1 To 8
        Read B2
        If Cel_frac_bit = B2 Then
          Incr Temp
          Exit For
        End If
     Next
  End If
End Sub



Rounding:
Data 1 , 3 , 4 , 6 , 9 , 11 , 12 , 14