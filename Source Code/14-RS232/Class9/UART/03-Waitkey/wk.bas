$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
'Dim Inchar As String * 1
Dim Inchar As Byte
'----------------------
Do
   Inchar = Waitkey()
   Print Inchar
Loop Until Inchar = " "
Print "END..."
End
'----------------------

