VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmMain 
   Caption         =   "Simple Comm Demo"
   ClientHeight    =   3525
   ClientLeft      =   225
   ClientTop       =   825
   ClientWidth     =   7935
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   3525
   ScaleWidth      =   7935
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrRxLED 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   5040
      Top             =   360
   End
   Begin VB.Timer tmrTxLED 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4500
      Top             =   360
   End
   Begin VB.Timer tmrClearError 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3960
      Top             =   360
   End
   Begin VB.Timer tmrPolledMode 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3420
      Top             =   360
   End
   Begin VB.PictureBox picInfo 
      Height          =   615
      Left            =   60
      ScaleHeight     =   555
      ScaleWidth      =   7575
      TabIndex        =   1
      Top             =   2520
      Width           =   7635
      Begin VB.PictureBox picLED 
         Height          =   275
         Left            =   6000
         ScaleHeight     =   210
         ScaleWidth      =   1305
         TabIndex        =   8
         Top             =   0
         Width           =   1365
         Begin VB.Image imgTx 
            Height          =   195
            Left            =   1080
            ToolTipText     =   "Tx"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgRx 
            Height          =   195
            Left            =   900
            ToolTipText     =   "Rx"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgDTR 
            Height          =   195
            Left            =   720
            ToolTipText     =   "DTR"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgRTS 
            Height          =   195
            Left            =   540
            ToolTipText     =   "RTS"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgDSR 
            Height          =   195
            Left            =   360
            ToolTipText     =   "DSR"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgCTS 
            Height          =   195
            Left            =   180
            ToolTipText     =   "CTS"
            Top             =   0
            Width           =   195
         End
         Begin VB.Image imgCD 
            Height          =   195
            Left            =   0
            ToolTipText     =   "CD"
            Top             =   0
            Width           =   195
         End
      End
      Begin VB.Label lblError 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblError"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   275
         Left            =   4800
         TabIndex        =   7
         Top             =   0
         Width           =   1215
      End
      Begin VB.Label lblMode 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblMode"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   275
         Left            =   2400
         TabIndex        =   5
         Top             =   0
         Width           =   1215
      End
      Begin VB.Label lblSettings 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblSettings"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   275
         Left            =   3600
         TabIndex        =   4
         Top             =   0
         Width           =   1215
      End
      Begin VB.Label lblPort 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblPort"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   275
         Left            =   0
         TabIndex        =   3
         Top             =   0
         Width           =   1215
      End
      Begin VB.Label lblOpen 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblOpen"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   275
         Left            =   1200
         TabIndex        =   2
         Top             =   0
         Width           =   1215
      End
   End
   Begin VB.Timer tmrLoopBack 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2880
      Top             =   360
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   2160
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      InputMode       =   1
   End
   Begin VB.TextBox txtTerminal 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   795
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "frmMain.frx":0442
      Top             =   0
      Width           =   1935
   End
   Begin VB.Image imgLed 
      Height          =   240
      Index           =   0
      Left            =   5880
      Picture         =   "frmMain.frx":044E
      Top             =   540
      Width           =   240
   End
   Begin VB.Image imgLed 
      Height          =   240
      Index           =   1
      Left            =   6120
      Picture         =   "frmMain.frx":0B10
      Top             =   540
      Width           =   240
   End
   Begin VB.Image imgLed 
      Height          =   240
      Index           =   2
      Left            =   6360
      Picture         =   "frmMain.frx":11D2
      Top             =   540
      Width           =   240
   End
   Begin VB.Image imgLed 
      Height          =   240
      Index           =   3
      Left            =   6600
      Picture         =   "frmMain.frx":1894
      Top             =   540
      Width           =   240
   End
   Begin VB.Label lblText 
      Caption         =   $"frmMain.frx":1F56
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   480
      TabIndex        =   6
      Top             =   1200
      Width           =   6735
   End
   Begin VB.Menu mMode 
      Caption         =   "Rx Mode"
      Begin VB.Menu mnuMode 
         Caption         =   "On Comm Event"
         Checked         =   -1  'True
         Index           =   0
      End
      Begin VB.Menu mnuMode 
         Caption         =   "Polled by Timer"
         Index           =   1
      End
      Begin VB.Menu mnuMode 
         Caption         =   "-"
         Index           =   2
      End
      Begin VB.Menu mnuMode 
         Caption         =   "Character Mode"
         Checked         =   -1  'True
         Index           =   3
      End
      Begin VB.Menu mnuMode 
         Caption         =   "Message Mode"
         Index           =   4
      End
   End
   Begin VB.Menu mOptions 
      Caption         =   "Options"
      Begin VB.Menu mnuClear 
         Caption         =   "Clear Screen"
      End
      Begin VB.Menu mnuLocalEcho 
         Caption         =   "Local Echo"
      End
      Begin VB.Menu mnuLoopBack 
         Caption         =   "Loop Back Test"
      End
      Begin VB.Menu mnuSettings 
         Caption         =   "Comm Settings"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' program logic control
Private bLocalEcho              As Boolean
Private bMessageMode            As Boolean

' constants for setting the LED images,
' used as an index for imgLED()
Private Const RedOff            As Long = 0
Private Const RedOn             As Long = 1
Private Const GreenOff          As Long = 2
Private Const GreenOn           As Long = 3


' the sendmessage API is used to write
' to the textbox to reduce flicker, this
' not required for serial communications.

' Win32 API constants
Private Const EM_GETSEL         As Long = &HB0
Private Const EM_SETSEL         As Long = &HB1
Private Const EM_GETLINECOUNT   As Long = &HBA
Private Const EM_LINEINDEX      As Long = &HBB
Private Const EM_LINELENGTH     As Long = &HC1
Private Const EM_LINEFROMCHAR   As Long = &HC9
Private Const EM_SCROLLCARET    As Long = &HB7
Private Const WM_SETREDRAW      As Long = &HB
Private Const WM_GETTEXTLENGTH  As Long = &HE

' Win32 API declarations
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
    (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Long) As Long


Private Sub Form_Load()

    ' just in case the default port won't open
    On Local Error Resume Next

    ' disply the startup message in the terminal window
    txtTerminal.Text = "Reveived data will be displayed here." & vbCrLf & _
                       "Keys will be transmitted as you press them." & vbCrLf & _
                       "If you are connected to a modem it should echo" & vbCrLf & _
                       "each key press." & vbCrLf & vbCrLf & _
                       "To change the comm settings use the OPTIONS|SETTINGS menu." & vbCrLf
    
    ' move the cursor to the end of text
    txtTerminal.SelStart = Len(txtTerminal)

    ' set the startup color for the Rx & Tx LED's
    Set imgRx.Picture = imgLed(GreenOff).Picture
    Set imgTx.Picture = imgLed(GreenOff).Picture
    
    Me.Show
    Me.Refresh
    
    ' setup the default comm port settings
    MSComm1.CommPort = 1                    ' comm port 1
    MSComm1.RThreshold = 1                  ' use 'on comm' event processing
    MSComm1.Settings = "9600,n,8,1"         ' baud, parity, data bits, stop bits
    MSComm1.SThreshold = 1                  ' allows us to track Tx LED
    MSComm1.InputMode = comInputModeBinary  ' binary mode, you can also use
                                            ' comInputModeText for text only use
    ' open the port
    MSComm1.PortOpen = True
    
    ' display status
    ShowInfo
    mnuMode_Click (0)
    mnuMode_Click (3)
    
End Sub

Private Sub Form_Resize()

    ' resize the display controls to match the form
    picInfo.Move 0, Abs(Me.Height - 1135), Abs(Width - 120), 315
    txtTerminal.Move 0, 0, Abs(Width - 120), picInfo.Top
   
End Sub

Private Sub imgDTR_Click()

    ' DTR & RTS are output lines on the comm control
    ' clicking the DTR LED will toggle the DTR line
    MSComm1.DTREnable = MSComm1.DTREnable Xor &HFFFF
    SetLEDs

End Sub

Private Sub imgRTS_Click()

    ' DTR & RTS are output lines on the comm control
    ' clicking the RTS LED will toggle the RTS line
    MSComm1.RTSEnable = MSComm1.RTSEnable Xor &HFFFF
    SetLEDs

End Sub

Private Sub mnuClear_Click()

    ' clear the terminal window
    txtTerminal.Text = ""

End Sub

Private Sub mnuLocalEcho_Click()

    ' toggle local echo, if true, keypress's
    ' will be written to the terminal window
    mnuLocalEcho.Checked = mnuLocalEcho.Checked Xor &HFFFF
    If mnuLocalEcho.Checked Then
        bLocalEcho = True
    Else
        bLocalEcho = False
    End If

End Sub

Private Sub mnuLoopBack_Click()

    ' toggle on/off a timer that will send characters out the comm port for
    ' a simple loop back test. Connect pins 2 & 3 together to see the data

    mnuLoopBack.Checked = mnuLoopBack.Checked Xor &HFFFF
    If mnuLoopBack.Checked Then
        tmrLoopBack.Enabled = True
    Else
        tmrLoopBack.Enabled = False
    End If

End Sub

Private Sub mnuMode_Click(Index As Integer)

    ' switch character receive modes, OnComm Event and Polled mode
    ' switch character buffer modes, character, and message
    
    Select Case Index
    
        Case 0
            mnuMode(1).Checked = False
            tmrPolledMode.Enabled = False
            MSComm1.RThreshold = 1
            lblMode = "Event"
            mnuMode(3).Enabled = True
            mnuMode(4).Enabled = True
            If bMessageMode Then mnuMode(4).Checked = True Else mnuMode(3).Checked = True
        
        Case 1
            mnuMode(0).Checked = False
            MSComm1.RThreshold = 0
            tmrPolledMode.Enabled = True
            lblMode = "Polled"
            mnuMode(4).Checked = False
            mnuMode(3).Checked = False
            mnuMode(3).Enabled = False
            mnuMode(4).Enabled = False
        
        Case 3
            mnuMode(4).Checked = False
            bMessageMode = False
        
        Case 4
            mnuMode(3).Checked = False
            bMessageMode = True
    
    End Select
    
    mnuMode(Index).Checked = True
    
End Sub

Private Sub mnuSettings_Click()

    Dim bLoaded     As Boolean
    Dim frm         As Form
    
    ' open the comm settings form
    frmSettings.CommSettings Me.MSComm1, "Communications Port Settings"
    
    ' wait for the settings form to unload
    ' modal is not used so multi port apps can
    ' continue while the settings form is visible.
    ' this is only required because we want to
    ' capture the new settings & display them.
    
    Do
        bLoaded = False
        For Each frm In Forms
            If frm.Name = "frmSettings" Then bLoaded = True
        Next
       DoEvents
    Loop While bLoaded
   
    ' display the new settings
    ShowInfo
    
End Sub

Private Sub MSComm1_OnComm()
   
'******************************************************************************
' Synopsis:     Handle incoming characters, 'On Comm' Event
'
' Description:  By setting MSComm1.RThreshold = 1, this event will fire for
'               each character that arrives in the comm controls input buffer.
'               Set MSComm1.RThreshold = 0 if you want to poll the control
'               yourself, either via a TImer or within program execution loop.
'
'               In most cases, OnComm Event processing shown here is the prefered
'               method of processing incoming characters.
'
'******************************************************************************

    
    Static sBuff    As String           ' buffer for holding incoming characters
    Const MTC       As String = vbCrLf  ' message terminator characters (ususally vbCrLf)
    Const LenMTC    As Long = 2         ' number of terminator characters, must match MTC
    Dim iPtr        As Long             ' pointer to terminatior character

    ' OnComm fires for multiple Events
    ' so get the Event ID & process
    Select Case MSComm1.CommEvent
        
        ' Received RThreshold # of chars, in our case 1.
        Case comEvReceive
        
            ' read all of the characters from the input buffer
            ' StrConv() is required when using MSComm in binary mode,
            ' if you set MSComm1.InputMode = comInputModeText, it's not required
            
            sBuff = sBuff & StrConv(MSComm1.Input, vbUnicode)
                        
            ' a typical application would buffer characters here waiting for
            ' an end of message sequence like vbCrLf, that's why sBuff is declared
            ' as Static and the statement above sets sBuff = sBuff & MSComm1.Input
            ' When an end of message string is received the messages are passed
            ' through a parser routine. Here, we show processing a character at
            ' time and 'message parsing' options. MEssage parsing varies depending
            ' on what you're doing but would look something like this:
            
            If bMessageMode Then
                ' in message mode we wait for the message terminator
                ' before processing. This is typcal of a command & control
                ' program that interfaces with an external device and
                ' must decode data coming from the device. Most devices will
                ' use a start / end sequennce to ID each message.  You
                ' would process the messages by calling your message parser and
                ' passing the message just like the message is passed to the
                ' PosTerminal routine below. Some device's use character count
                ' to ID messages instead of start/end characters, this method is
                ' too machine specific to be shown here.
                
                ' look for message terminator
                iPtr = InStr(sBuff, MTC)
                ' process all queued messages
                Do While iPtr
                    ' pass each message to the message parser
                    ' in our case, it just gets displayed. To decode
                    ' specific messages, you would pass the string
                    ' Mid$(sBuff, 1, iPtr + LenMTC - 1)
                    ' to a message decoder routime
                    PostTerminal Mid$(sBuff, 1, iPtr + LenMTC - 1)
                    ' remove from the message queue
                    sBuff = Mid$(sBuff, iPtr + LenMTC)
                    ' look for another message
                    iPtr = InStr(sBuff, MTC)
                Loop
            
            Else
                ' in character mode we just pass each character to
                ' the parser as it comes in. The parser is responsibe
                ' for collecting the characters and assembling any messages.
                ' For our simple terminal example, character mode works fine.
                PostTerminal sBuff
                sBuff = vbNullString
            End If
            
            
            ' flash the Rx LED
            Set imgRx.Picture = imgLed(GreenOn).Picture
            tmrRxLED.Enabled = True
     
        
        ' Change in the CD line.
        Case comEvCD
            SetLEDs
        
        ' Change in the CTS line.
        Case comEvCTS
            SetLEDs
            
        ' Change in the DSR line.
        Case comEvDSR
             SetLEDs
             
        ' Change in the Ring Indicator.
        Case comEvRing
             
        ' An EOF charater was found in the input stream
        Case comEvEOF
        
        ' There are SThreshold number of characters in the transmit  buffer.
        Case comEvSend
            Set imgTx.Picture = imgLed(GreenOn).Picture
            tmrTxLED.Enabled = True
   
        ' A Break was received.
        Case comEventBreak
            lblError = "Break"
            tmrClearError.Enabled = True
        
        ' Framing Error
        Case comEventFrame
            lblError = "Framing"
            tmrClearError.Enabled = True
        
        ' Data Lost.
        Case comEventOverrun
            lblError = "Overrun"
            tmrClearError.Enabled = True
        
        ' Receive buffer overflow.
        Case comEventRxOver
            lblError = "Overflow"
            tmrClearError.Enabled = True
        
        ' Parity Error.
        Case comEventRxParity
            lblError = "Parity"
            tmrClearError.Enabled = True
        
        ' Transmit buffer full.
        Case comEventTxFull
            lblError = "Tx Full"
            tmrClearError.Enabled = True
        
        ' Unexpected error retrieving DCB]
        Case comEventDCB
            lblError = "DCB Error"
            tmrClearError.Enabled = True
    
    End Select
    

End Sub

Public Sub PostTerminal(ByVal sNewData As String)

    ' display incoming characters in the
    ' textbox 'terminal' window. API is
    ' used only to reduce flicker.
    
    Dim lPtr    As Long

    ' this is faster and has less flicker but requires use of the Win API
    With txtTerminal
        lPtr = SendMessage(.hwnd, EM_GETLINECOUNT, 0, ByVal 0&)
        If lPtr > 550 Then
            'LockWindowUpdate .hWnd
            Call SendMessage(.hwnd, WM_SETREDRAW, False, ByVal 0&)
            lPtr = SendMessage(.hwnd, EM_LINEINDEX, 100, ByVal 0&)
            .SelStart = 0
            .SelLength = IIf(lPtr > 0, lPtr, 1000)
            .SelText = vbNullString
            Call SendMessage(.hwnd, WM_SETREDRAW, True, ByVal 0&)
            ' LockWindowUpdate 0
        End If
        .SelStart = SendMessage(.hwnd, WM_GETTEXTLENGTH, True, ByVal 0&)
        .SelText = sNewData
        .SelStart = SendMessage(.hwnd, WM_GETTEXTLENGTH, True, ByVal 0&)
    End With

End Sub

Private Sub tmrClearError_Timer()

    lblError = ""
    tmrClearError.Enabled = False

End Sub

Private Sub tmrPolledMode_Timer()

    ' example of polled mode. This is an alternative to using
    ' the MSComm1 OnComm Event for receiving characters.
    ' collect characters here when the Timer fires. See
    ' the comments in MSComm1 OnComm Event for information
    ' on more complex processing. message mode has not been
    ' implimented here, see MSComm1 OnComm Event for example
    ' of message mode operation.
    
    If MSComm1.InBufferCount Then
        PostTerminal StrConv(MSComm1.Input, vbUnicode)
        Set imgRx.Picture = imgLed(GreenOn).Picture
        tmrRxLED.Enabled = True
    End If
    
End Sub

Private Sub tmrRxLED_Timer()

    Set imgRx.Picture = imgLed(GreenOff).Picture
    tmrRxLED.Enabled = False

End Sub

Private Sub tmrTxLED_Timer()

    Set imgTx.Picture = imgLed(GreenOff).Picture
    tmrTxLED.Enabled = False

End Sub

Private Sub tmrLoopBack_Timer()

    ' use this timer to send some characters out so we can test our receive code...
    ' this is only here for the loop back demo, it is not required for communications

    If MSComm1.PortOpen Then
        MSComm1.Output = Me.Caption & Format$(Timer, " ###,##0.000") & vbCrLf
    End If
    
End Sub

Private Sub txtTerminal_KeyPress(KeyAscii As Integer)

    ' send keys out the comm port, convert vbCr to vbCrLf
    Select Case KeyAscii
        Case 13
            If MSComm1.PortOpen Then MSComm1.Output = vbCrLf
        Case Else
            If MSComm1.PortOpen Then MSComm1.Output = Chr$(KeyAscii)
    End Select
    
    If Not bLocalEcho Then KeyAscii = 0
    
End Sub

Private Sub ShowInfo()

    ' display status info
    lblSettings = UCase$(MSComm1.Settings)
    lblPort = "Port " & MSComm1.CommPort
    lblOpen = IIf(MSComm1.PortOpen, "Open", "Closed")
    lblError = ""
    
    SetLEDs
    
End Sub

Private Sub SetLEDs()

    ' set the status LED's
    Set imgCD.Picture = IIf(MSComm1.CDHolding, imgLed(RedOn).Picture, imgLed(RedOff).Picture)
    Set imgCTS.Picture = IIf(MSComm1.CTSHolding, imgLed(RedOn).Picture, imgLed(RedOff).Picture)
    Set imgDSR.Picture = IIf(MSComm1.DSRHolding, imgLed(RedOn).Picture, imgLed(RedOff).Picture)
    Set imgRTS.Picture = IIf(MSComm1.RTSEnable, imgLed(RedOn).Picture, imgLed(RedOff).Picture)
    Set imgDTR.Picture = IIf(MSComm1.DTREnable, imgLed(RedOn).Picture, imgLed(RedOff).Picture)

End Sub
