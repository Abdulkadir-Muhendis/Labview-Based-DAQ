' ******************************************************************************
' * Title         : GLCD.bas                                                   *
' * Version       : 1.0                                                        *
' * Last Updated  : 26.07.2011                                                 *
' * Target Board  : Phoenix - REV 1.00                                         *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Walid Balid                                                *
' * IDE           : BASCOM AVR 2.0.7.0                                         *
' * Peripherals   : Pull-Up Resistors                                          *
' * Description   : GLCD                                                       *
' ******************************************************************************
' Set GLCD SWitch on (Backlight)
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
$regfile = "m128def.dat"
$crystal = 8000000
$lib "glcdKS108.lib"
'-----------------------
'-----------------------[LCD Configurations]
Config Graphlcd = 128 * 64sed , Dataport = Portc , Controlport = Porta , Ce = 3 , Ce2 = 4 , Cd = 5 , Rd = 6 , Reset = 2 , Enable = 7
'-----------------------
'-----------------------[Variables]
Dim X As Byte , Y As Byte
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]
Do
   Cls
   Gosub Font_size_1 : Gosub Font_size_2 : Gosub Font_size_3 : Gosub Font_size_4
   Gosub Draw_lines : Gosub Draw_pixles : Gosub Draw_circles : Gosub Draw_boxes
   Gosub Draw_images

   Glcdcmd &H3E , 1 : Glcdcmd &H3E , 2                      'Both DSPs off
   Waitms 1500
   Glcdcmd &H3F , 1 : Glcdcmd &H3F , 2                      'Both DSPs off
Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Set Text Font Size - 5.Pixel(X) x 8.Pixel(Y)]
'5 x 8 Font >> If GLCD = 64 x 128 Then >> 8-Row(Y) x 25-Col(X)
Font_size_1:
   Setfont Font5x8
   Lcdat 1 , 1 , ">5x8 LINE1" : Wait 1
   Lcdat 2 , 1 , ">5x8 LINE2" : Wait 1
Return
'-----------------------
'--->[Set Text Font Size - 6.Pixel(X) x 8.Pixel(Y)]
'5 x 8 Font >> If GLCD = 64 x 128 Then >> 8-Row(Y) x 21-Col(X)
Font_size_2:
   Setfont Font6x8
   Lcdat 3 , 1 , ">6x8 LINE3" : Wait 1
   Lcdat 4 , 1 , ">6x8 LINE4" : Wait 1
Return
'-----------------------
'--->[Set Text Font Size - 8.Pixel(X) x 8.Pixel(Y)]
'8 x 8 Font >> If GLCD = 64 x 128 Then >> 8-Row(Y) x 16-Col(X)
Font_size_3:
   Setfont Font8x8
   Lcdat 5 , 1 , ">8x8 LINE5" : Wait 1
   Lcdat 6 , 1 , ">8x8 LINE6" : Wait 1
Return
'-----------------------
'--->[Set Text Font Size - 16.Pixel(X) x 16.Pixel(Y)]
'16 x 16 Font >> If GLCD = 64 x 128 Then >> 4-Row(Y) x 8-Col(X)
Font_size_4:
   Setfont Font16x16 : Cls
   Lcdat 1 , 1 , "16x16 L1" : Wait 1
   Lcdat 3 , 1 , "16x16 L2" : Wait 1
   Lcdat 5 , 1 , "16x16 L3" : Wait 1
   Lcdat 7 , 1 , "16x16 L4" : Wait 1
Return
'-----------------------
'--->[Drawing Lines on the GLCD]
Draw_lines:
   Setfont Font8x8 : Lcdat 4 , 11 , "Drawing Lines" : Wait 2 : Cls Text
   Line(0 , 0) -(127 , 0) , 255 : Wait 1                    '[X = 0 > X = 127 | Y = 00.00]
   Line(0 , 63) -(127 , 63) , 255 : Wait 1                  '[X = 0 > X = 127 | Y = 63.63]
   Line(0 , 0) -(0 , 63) , 255 : Wait 1                     '[Y = 0 > Y = 63  | X = 127.63]
   Line(127 , 0) -(127 , 63) , 255 : Wait 1                 '[Y = 0 > Y = 63  | X = 00.63]
   Line(0 , 0) -(127 , 63) , 255 : Wait 1
   Cls Graph
Return
'-----------------------
'--->[Drawing Pixels on the GLCD]
Draw_pixles:
   Lcdat 4 , 11 , "SET/RST Pixel" : Wait 2 : Cls Text

   For X = 0 To 127
      Pset X , 20 , 255 : Pset X , 43 , 255 : Waitms 25
   Next X

   For Y = 0 To 63
      Pset 42 , Y , 255 : Pset 86 , Y , 255 : Waitms 25
   Next Y

   For X = 127 To 0 Step -1
      Pset X , 20 , 0 : Pset X , 43 , 0 : Waitms 25
   Next X

   For Y = 63 To 0 Step -1
      Pset 42 , Y , 0 : Pset 86 , Y , 0 : Waitms 25
   Next X
   Cls Graph
Return
'-----------------------
'--->[Drawing Circles on the GLCD]
Draw_circles:
   Lcdat 4 , 11 , "Drawing Circle" : Wait 2 : Cls Text

   For X = 1 To 31
      Circle(63 , 31) , X , 255 : Waitms 50 : Circle(63 , 31) , X , 0
   Next X
   Cls Graph
Return
'-----------------------
'--->[Drawing Boxes on the GLCD]
Draw_boxes:
   Box(10 , 10) -(117 , 53) , 255 : Wait 2
   Boxfill(15 , 15) -(112 , 48) , 255 : Wait 2
   Boxfill(25 , 25) -(102 , 38) , 0 : Wait 2
Return
'-----------------------
'--->[Drawing Images on the GLCD]
Draw_images:
   Showpic 0 , 0 , Smiley1 : Wait 2 : Cls Graph
   Showpic 0 , 0 , Smiley2 : Wait 2 : Cls Graph
   Showpic 0 , 0 , Smiley3 : Wait 2 : Cls Graph
   Showpic 0 , 0 , Smiley4 : Wait 2
Return
'-----------------------
'--->[Include Fonts from Extrnal Font Files]
$include "Font5x8.font"
$include "Font6x8.font"
$include "Font8x8.font"
$include "Font16x16.font"
'-----------------------
'--->[Include Images from Extrnal Image Data Files]
Smiley1:
$bgf "Smiley1.bgf"

Smiley2:
$bgf "Smiley2.bgf"

Smiley3:
$bgf "Smiley3.bgf"

Smiley4:
$bgf "Smiley4.bgf"
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

