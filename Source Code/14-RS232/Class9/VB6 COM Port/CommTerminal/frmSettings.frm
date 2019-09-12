VERSION 5.00
Begin VB.Form frmSettings 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   2610
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6750
   Icon            =   "frmSettings.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2610
   ScaleWidth      =   6750
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame fraHandshake 
      Caption         =   "Handshaking"
      Height          =   1335
      Left            =   4260
      TabIndex        =   16
      Top             =   1140
      Width           =   1215
      Begin VB.OptionButton optHandshake 
         Caption         =   "Both"
         Height          =   195
         Index           =   3
         Left            =   180
         TabIndex        =   20
         Top             =   1020
         Width           =   795
      End
      Begin VB.OptionButton optHandshake 
         Caption         =   "RTS"
         Height          =   195
         Index           =   2
         Left            =   180
         TabIndex        =   19
         Top             =   780
         Width           =   795
      End
      Begin VB.OptionButton optHandshake 
         Caption         =   "Xon"
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   18
         Top             =   540
         Width           =   795
      End
      Begin VB.OptionButton optHandshake 
         Caption         =   "None"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   17
         Top             =   300
         Width           =   795
      End
   End
   Begin VB.CommandButton cmdAction 
      Caption         =   "Cancel"
      Height          =   375
      Index           =   1
      Left            =   5700
      TabIndex        =   15
      Top             =   720
      Width           =   855
   End
   Begin VB.CommandButton cmdAction 
      Caption         =   "OK"
      Height          =   375
      Index           =   0
      Left            =   5700
      TabIndex        =   14
      Top             =   240
      Width           =   855
   End
   Begin VB.Frame fraDataBits 
      Caption         =   "Data Bits"
      Height          =   1335
      Left            =   120
      TabIndex        =   4
      Top             =   1140
      Width           =   1215
      Begin VB.OptionButton optDataBits 
         Caption         =   "8 Bit"
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   6
         Top             =   600
         Width           =   975
      End
      Begin VB.OptionButton optDataBits 
         Caption         =   "7 Bit"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   5
         Top             =   300
         Width           =   975
      End
   End
   Begin VB.Frame fraStopBits 
      Caption         =   "Stop Bits"
      Height          =   1335
      Left            =   2880
      TabIndex        =   3
      Top             =   1140
      Width           =   1215
      Begin VB.OptionButton optStopBits 
         Caption         =   "2  Bit"
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   8
         Top             =   600
         Width           =   975
      End
      Begin VB.OptionButton optStopBits 
         Caption         =   "1 Bit"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   7
         Top             =   300
         Width           =   975
      End
   End
   Begin VB.Frame fraBaud 
      Caption         =   "Baud Rate"
      Height          =   795
      Left            =   2880
      TabIndex        =   2
      Top             =   120
      Width           =   2565
      Begin VB.ComboBox cboBaud 
         Height          =   315
         Left            =   180
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   300
         Width           =   2175
      End
   End
   Begin VB.Frame fraPort 
      Caption         =   "Comm Port"
      Height          =   795
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2625
      Begin VB.ComboBox cboPort 
         Height          =   315
         Left            =   180
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   300
         Width           =   2235
      End
   End
   Begin VB.Frame fraParity 
      Caption         =   "Parity"
      Height          =   1335
      Left            =   1500
      TabIndex        =   0
      Top             =   1140
      Width           =   1215
      Begin VB.OptionButton optParity 
         Caption         =   "None"
         Height          =   195
         Index           =   2
         Left            =   180
         TabIndex        =   11
         Top             =   900
         Width           =   975
      End
      Begin VB.OptionButton optParity 
         Caption         =   "Odd"
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   10
         Top             =   600
         Width           =   975
      End
      Begin VB.OptionButton optParity 
         Caption         =   "Even"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   9
         Top             =   300
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'******************************************************************************
' Synopsis: Form to change communications settings
'
' Usage:    main program calls the 'CommSettings' sub on this form, passing
'           the name of the communications control and an optional title.
'
' Description:
'           Scans machine for all available comm hardware and then allows user
'           to select the communications settings. Re-open port when finished
'
'******************************************************************************


Dim CommCntrl       As Control          ' the communications control
Dim PORT            As Variant          ' Comm port number
Dim Baud            As Variant          ' baud rate
Dim StopBits        As Variant          ' stop bits
Dim Parity          As Variant          ' parity
Dim DataBits        As Variant          ' data bits
Dim Handshake       As Variant          ' handshaking
Dim bNoComm         As Boolean

Private Const MAX_COMM = 32             ' max port # to check

' Win32 API
' we're using the API to scan for available harware.
' you could use the passed comm control but this is
' much faster and less prone to errors

Private Const GENERIC_READ = &H80000000
Private Const GENERIC_WRITE = &H40000000
Private Const OPEN_EXISTING = 3
Private Const FILE_FLAG_OVERLAPPED = &H40000000
Private Const INVALID_HANDLE_VALUE = -1

Private Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" _
        (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, _
        ByVal dwShareMode As Long, ByVal lpSecurityAttributes As String, _
        ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, _
        ByVal hTemplateFile As String) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long

Private Declare Function SetWindowPos Lib "user32" _
        (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, _
        ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long


Public Sub CommSettings(cntrl As Control, Optional msg As String = "Communications Settings")

'******************************************************************************
' Synopsis: Entry point for the Form
'
' Usage:    main program calls here, passing the name of the communications
'           control and an optional title. The controls settings are modified
'           per the users input.
'
'******************************************************************************
    
    Dim iCntr           As Integer      ' loop counter
    Dim sSettings()     As String       ' comm settings array
    Dim hRet            As Long         ' api return value
    Dim sCom            As String       ' comm port name
    
    On Local Error Resume Next

    ' was a control passed...
    If cntrl Is Nothing Then
        MsgBox "No serial communications control specified.", vbOKOnly + vbCritical, Me.Name
        Unload Me
        Exit Sub
    End If
        
    Set CommCntrl = cntrl
    Err = 0

    ' close the port if it's open
    If CommCntrl.PortOpen = True Then
        CommCntrl.PortOpen = False
        DoEvents
    Else
        bNoComm = True
    End If
    ' simple check for comm control
    If Err = 438 Then
        MsgBox "Passed control is not a serial communications control.", vbOKOnly + vbCritical, Me.Name
        Err = 0
        Unload Me
        Exit Sub
    End If
        
    OnTop Me, True
            
    Screen.MousePointer = vbHourglass
            
    cboPort.AddItem "<none>"
    ' scan for all possible hardware so we can
    ' display all available ports in the combo box
    ' this dynamically adjusts for PC's with addin cards
    For iCntr = 1 To MAX_COMM
        ' try to open the port
        ' \\.\ required for ports > 9, works for all ports
        sCom = "\\.\Com" & CStr(iCntr) & vbNullChar
        hRet = CreateFile(sCom, GENERIC_READ Or GENERIC_WRITE, 0, vbNullString, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, vbNullString)
      
        If hRet <> INVALID_HANDLE_VALUE Then
            hRet = CloseHandle(hRet)
            cboPort.AddItem Str(iCntr)
        Else
            ' dll error 5 = already open
            ' dll error 2 = no harware
            If Err.LastDllError = 5 Then
                cboPort.AddItem Str(iCntr) & " - Not Available"
            End If
        End If
    Next
        
    ' get all of the current settings
    If bNoComm Then PORT = 0 Else PORT = CommCntrl.CommPort
    sSettings = Split(CommCntrl.Settings, ",")
    Baud = sSettings(0)
    Parity = sSettings(1)
    DataBits = sSettings(2)
    StopBits = sSettings(3)
    Handshake = CommCntrl.Handshaking

    ' populate the form with the current settings....
    ' port number
    For iCntr = 0 To cboPort.ListCount - 1
        cboPort.ListIndex = iCntr
        If PORT = Trim$(cboPort) Then Exit For
        cboPort.ListIndex = 0
    Next

    ' baud rate
    For iCntr = 0 To cboBaud.ListCount - 1
        cboBaud.ListIndex = iCntr
        If cboBaud.Text = Baud Then Exit For
    Next

    ' parity
    Select Case UCase$(Parity)
        Case "E": optParity(0).Value = True
        Case "O": optParity(1).Value = True
        Case "N": optParity(2).Value = True
    End Select

    ' data bits
    Select Case DataBits
        Case 7: optDataBits(0).Value = True
        Case 8: optDataBits(1).Value = True
    End Select

    ' stop bits
    Select Case StopBits
        Case 1: optStopBits(0).Value = True
        Case 2: optStopBits(1).Value = True
    End Select

    ' handshaking
    If Handshake >= 0 And Handshake <= 3 Then
        optHandshake(Handshake).Value = True
    End If
    
    ' clean up
    Screen.MousePointer = vbNormal
    
    ' ready
    With Me
        .Caption = msg
        .cmdAction(0).Enabled = True
        .cmdAction(1).Enabled = True
    End With

End Sub


Private Sub cmdAction_Click(Index As Integer)

    Dim strCtrlName  As String

    On Local Error Resume Next

    strCtrlName = CommCntrl.Name & Trim$(Str$(CommCntrl.Index))

    Select Case Index

        ' OK pressed
        Case 0

            Do While CommCntrl.PortOpen = True
                CommCntrl.PortOpen = False
                DoEvents
            Loop

            ' did user select 'none' or a port that is already in use?
            If InStr(cboPort.Text, "none") Then
                SaveSetting App.EXEName, strCtrlName, "Port", "0"
                bNoComm = True
                Unload Me
                Exit Sub
            ElseIf InStr(cboPort.Text, "not") Then
                MsgBox "Port" & Mid$(cboPort.Text, 1, 2) & " is already open by another process. Please select a different Comm port.", vbOKOnly, Me.Caption
                Exit Sub
            End If

            ' get all of the settings
            If optDataBits(0).Value = True Then DataBits = 7 Else DataBits = 8
            If optStopBits(0).Value = True Then StopBits = 1 Else DataBits = 2
            If optParity(0).Value = True Then
                Parity = "E"
            ElseIf optParity(1).Value = True Then
                Parity = "O"
            Else
                Parity = "N"
            End If
            Baud = CVar(cboBaud.Text)
            PORT = CVar(Trim$(cboPort.Text))
            CommCntrl.CommPort = PORT
            CommCntrl.Settings = Baud & "," & _
                    Parity & "," & _
                    Trim$(CStr(DataBits)) & "," & _
                    Trim$(CStr(StopBits))
            CommCntrl.Handshaking = Handshake
            ' save settings for later
            SaveSetting App.EXEName, strCtrlName, "Settings", CommCntrl.Settings
            SaveSetting App.EXEName, strCtrlName, "Port", CommCntrl.CommPort
            SaveSetting App.EXEName, strCtrlName, "Handshaking", CommCntrl.Handshaking
            bNoComm = False
        
        ' Cancel pressed
        Case 1

    End Select

    If Not bNoComm Then If CommCntrl.PortOpen = False Then CommCntrl.PortOpen = True
    Unload Me

End Sub


Private Sub Form_Load()

    With Me
        .Caption = "Scanning available comm hardware..."
        .cmdAction(0).Enabled = False
        .cmdAction(1).Enabled = False
        .Left = (Screen.Width - Width) / 2
        .Top = (Screen.Height - Height) / 2
        .Show
        .Refresh
    End With
  
    ' load the baud rate combo box
    cboBaud.AddItem "600", 0
    cboBaud.AddItem "1200", 1
    cboBaud.AddItem "2400", 2
    cboBaud.AddItem "4800", 3
    cboBaud.AddItem "9600", 4
    cboBaud.AddItem "19200", 5
    cboBaud.AddItem "38400", 6
    cboBaud.AddItem "57600", 7
    cboBaud.AddItem "115200", 8

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Set CommCntrl = Nothing

End Sub

Private Sub optDataBits_Click(Index As Integer)

    If optDataBits(1).Value = True Then
        optStopBits(0).Value = True
        optStopBits(1).Enabled = False
    Else
        optStopBits(1).Enabled = True
    End If

End Sub

Private Sub optHandshake_Click(Index As Integer)

    If optHandshake(Index).Value = True Then Handshake = Index

End Sub

Private Sub OnTop(frm As Form, bAction As Boolean)

' ******************************************************************************
'
' Synopsis:     Force a form to float 'On Top' of other forms
'
' Parameters:   frm - name of the form to modify
'               bAction - set 'ontop' property to true/false
'
' Return:       nothing
'
' Description:
'
'   Using the SetWindowPos API, send a  message to a form,
'   setting the form's topmost property
'
' ******************************************************************************

    Const HWND_TOPMOST      As Long = -1
    Const HWND_NOTOPMOST    As Long = -2
    Const SWP_NOMOVE        As Long = 2
    Const SWP_NOSIZE        As Long = 1
    Const flags             As Long = SWP_NOMOVE Or SWP_NOSIZE

    If bAction Then
        SetWindowPos frm.hwnd, HWND_TOPMOST, 0, 0, 0, 0, flags
    Else
        SetWindowPos frm.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, flags
    End If

End Sub
