VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmMain 
   Caption         =   "RS232 Communication"
   ClientHeight    =   3330
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6465
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3330
   ScaleWidth      =   6465
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame3 
      Caption         =   "Input Mode"
      Height          =   1215
      Left            =   4920
      TabIndex        =   13
      Top             =   2040
      Width           =   1455
      Begin VB.OptionButton optTXT 
         Caption         =   "TXT"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   120
         TabIndex        =   15
         Top             =   240
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton optBIN 
         Caption         =   "BIN"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   120
         TabIndex        =   14
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.CommandButton cmdClear 
      Caption         =   "CLEAR"
      Height          =   375
      Left            =   240
      TabIndex        =   12
      Top             =   720
      Width           =   1215
   End
   Begin VB.Frame Frame2 
      Caption         =   "PORT Status"
      Height          =   1215
      Left            =   3360
      TabIndex        =   9
      Top             =   2040
      Width           =   1455
      Begin VB.OptionButton optClose 
         Caption         =   "Close"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   120
         TabIndex        =   11
         Top             =   720
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton optOpen 
         Caption         =   "Open"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "COM Number"
      Height          =   1215
      Left            =   1800
      TabIndex        =   6
      Top             =   2040
      Width           =   1455
      Begin VB.OptionButton optCOM1 
         Caption         =   "COM1"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton optCOM2 
         Caption         =   "COM2"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.TextBox txtOutput 
      BackColor       =   &H00C0FFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   1800
      TabIndex        =   4
      Top             =   1320
      Width           =   4575
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   3600
      Top             =   360
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   0   'False
   End
   Begin VB.CommandButton cmdSendData 
      Caption         =   "Send Data"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      MaskColor       =   &H000000FF&
      TabIndex        =   2
      Top             =   2160
      Width           =   1575
   End
   Begin VB.CommandButton cmdExit 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   2880
      Width           =   1335
   End
   Begin VB.TextBox txtInput 
      BackColor       =   &H80000001&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000004&
      Height          =   1035
      Left            =   1800
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   120
      Width           =   4575
   End
   Begin VB.Label Label3 
      Caption         =   "OUTGOING"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   1320
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "INCOMING"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1575
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    MSComm1.CommPort = 1
    MSComm1.Settings = "9600,N,8,1"
    MSComm1.RThreshold = 1
    MSComm1.InputLen = 0
    MSComm1.DTREnable = False
    MSComm1.InBufferCount = 0
End Sub

Private Sub cmdClear_Click()
    txtOutput.Text = ""
    txtInput.Text = ""
End Sub

Private Sub optCOM1_Click()
    MSComm1.CommPort = 1
End Sub

Private Sub optCOM2_Click()
    MSComm1.CommPort = 2
End Sub

Private Sub optOpen_Click()
    MSComm1.PortOpen = True
End Sub

Private Sub optClose_Click()
    MSComm1.PortOpen = False
End Sub

Private Sub optTXT_Click()
    MSComm1.InputMode = comInputModeText
End Sub

Private Sub optBIN_Click()
    MSComm1.InputMode = comInputModeBinary
End Sub

Private Sub cmdSendData_Click()
    MSComm1.Output = txtOutput.Text + Chr(13)
    Debug.Print txtOutput.Text                'Debug purposes only
End Sub

Private Sub cmdExit_Click()
    If MSComm1.PortOpen = True Then MSComm1.PortOpen = False
    End
End Sub

Private Sub MSComm1_OnComm()                  'If comEvReceive Event then get data and display

Static sBuff As String
    If MSComm1.CommEvent = comEvReceive Then
        If optBIN.Value = True Then
            sBuff = sBuff & StrConv(MSComm1.Input, vbUnicode)
            txtInput.Text = sBuff
        Else
            txtInput.Text = txtInput.Text & MSComm1.Input
        End If
    End If
End Sub
'------------------------------------------------------------

