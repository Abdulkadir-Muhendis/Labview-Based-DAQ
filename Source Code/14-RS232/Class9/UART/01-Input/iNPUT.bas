$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Dim Num1 As Integer
Dim Num2 As Integer
Dim Sum As Integer
'----------------------
Do
   Num1 = 0 : Num2 = 0

   Input "Enter 1st Number: " , Num1
   Input "Enter 2nd Number: " , Num2

   Sum = Num1 + Num2
   Print "Sum: " ; Sum
   Print "-----------"
Loop
End