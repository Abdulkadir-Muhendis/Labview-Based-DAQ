$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Dim Num1 As Byte, Num2 As Byte, Sum As Word
'----------------------
Do
   Num1 = 0 : Num2 = 0
   Inputhex "Enter 1st Number as two-character hex-code: " , Num1
   Inputhex "Enter 2nd Number as two-character hex-code: " , Num2

   Sum = Num1 + Num2
   Print "Sum Dec:" ; Sum
   Print "Sum Hex:" ; Hex(sum)
   Print "-------------"
Loop
End
