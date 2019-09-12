$regfile = "m8def.dat"
$crystal = 4000000
$baud = 9600
'----------------------
Enable Urxc                                                 'Serial RX complete interrupt
Disable Utxc                                                'Serial TX complete interrupt
Disable Udre                                                'Serial data register empty interrupt

On Urxc Getchar
On Utxc Finish
On Udre Empty

Enable Interrupts
'----------------------
Dim Inchar(10) As Byte , Flag As Bit
'----------------------
Do
   nop
Loop Until Flag = 1
End
'----------------------

Getchar:
   Disable Urxc
   Enable Udre : Enable Utxc

   Inputbin Inchar(1) , 10

   Printbin Inchar(1) ; 10
Return
'----------------------
Finish:
   Disable Utxc : Set Flag
   Print "Serial TX complete interrupt!"
Return
'----------------------
Empty:
   Disable Udre : Print ""
   Print "UART Register is Empty!"
Return