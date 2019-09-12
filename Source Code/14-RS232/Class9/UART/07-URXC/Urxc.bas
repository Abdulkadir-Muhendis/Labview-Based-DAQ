$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Enable Urxc
On Urxc Getchar
Enable Interrupts
'----------------------
Dim Inchar As String * 1
'Dim Inchar As Byte
'----------------------
Do
   nop
Loop Until Inchar = " "
End
'----------------------

Getchar:
   Inchar = Inkey()
   Print Inchar
Return
'----------------------