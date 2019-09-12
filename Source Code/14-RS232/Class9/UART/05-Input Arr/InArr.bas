$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Dim Num1 As Integer
Dim Num2 As Integer
Dim Sum As Integer
Dim Arr(2) As Byte
'----------------------
Do
   Num1 = 0 : Num2 = 0
   Input "Enter DEC: " , Num1 , Num2
   Sum = Num1 + Num2
   Print "Sum: " ; Sum
   Print "-----------"

   Inputhex "Enter HEX: " , Num1 , Num2
   Sum = Num1 + Num2
   Print "Sum: " ; Sum
   Print "-----------"

   Inputbin Arr(1) , 2
   Sum = Arr(1) + Arr(2)
   Print "Sum: " ; Sum
   Print "-----------"
Loop
End