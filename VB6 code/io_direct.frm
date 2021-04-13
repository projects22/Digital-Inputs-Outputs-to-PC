VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "INPUTS OUTPUTS "
   ClientHeight    =   2640
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4095
   Icon            =   "io_direct.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2640
   ScaleWidth      =   4095
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox cb2 
      Caption         =   "RTS"
      Height          =   255
      Left            =   480
      TabIndex        =   7
      Top             =   1920
      Width           =   855
   End
   Begin VB.CheckBox cb1 
      Caption         =   "DTR"
      Height          =   255
      Left            =   480
      TabIndex        =   6
      Top             =   1440
      Width           =   855
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   3120
      TabIndex        =   4
      Text            =   "5"
      Top             =   240
      Width           =   615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "START"
      Height          =   375
      Left            =   2520
      TabIndex        =   3
      Top             =   720
      Width           =   1215
   End
   Begin MSCommLib.MSComm Comm1 
      Left            =   1560
      Top             =   1800
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.Frame Frame2 
      Caption         =   "Sampling"
      Height          =   1095
      Left            =   2400
      TabIndex        =   0
      Top             =   1320
      Width           =   1335
      Begin VB.OptionButton Option5 
         Caption         =   "0.1 Sec"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   720
         Value           =   -1  'True
         Width           =   975
      End
      Begin VB.OptionButton Option4 
         Caption         =   "1 Sec"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1680
      Top             =   1440
   End
   Begin VB.Label Label3 
      Caption         =   "CTS"
      Height          =   255
      Left            =   960
      TabIndex        =   9
      Top             =   360
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "DSR"
      Height          =   255
      Left            =   960
      TabIndex        =   8
      Top             =   840
      Width           =   495
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H0000C000&
      BorderWidth     =   3
      FillColor       =   &H0000C000&
      FillStyle       =   0  'Solid
      Height          =   300
      Left            =   480
      Top             =   720
      Width           =   300
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H80000008&
      BorderWidth     =   3
      FillColor       =   &H0000C000&
      FillStyle       =   0  'Solid
      Height          =   300
      Left            =   480
      Top             =   240
      Width           =   300
   End
   Begin VB.Label Label2 
      Caption         =   "COM"
      Height          =   255
      Left            =   2520
      TabIndex        =   5
      Top             =   240
      Width           =   495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Code by moty22.co.uk

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Dim bit, word, bitcount, dec  As Integer
Dim t, angl As Double

Private Sub Form_Load()
Timer1.Enabled = False
End Sub
Private Sub Command1_Click()
If Comm1.PortOpen = True Then Comm1.PortOpen = False
Comm1.CommPort = Text1.Text
Comm1.Settings = "9600,n,8,1"
Comm1.PortOpen = True
Comm1.RTSEnable = False
Comm1.DTREnable = True
Timer1.Enabled = True
End Sub
Private Sub Timer1_Timer()  'Timer 1 defines sampling rate.

If Option4 Then          'Selecting sampling rate
Timer1.Interval = 1000
ElseIf Option5 Then
Timer1.Interval = 100
End If

If cb1.Value = 1 Then Comm1.DTREnable = False
If cb1.Value = 0 Then Comm1.DTREnable = True
If cb2.Value = 1 Then Comm1.RTSEnable = False
If cb2.Value = 0 Then Comm1.RTSEnable = True
If Comm1.CTSHolding = True Then Shape1.FillColor = &HFF&
If Comm1.DSRHolding = True Then Shape2.FillColor = &HFF&
If Comm1.CTSHolding = False Then Shape1.FillColor = &HFF00&
If Comm1.DSRHolding = False Then Shape2.FillColor = &HFF00&

End Sub


Private Sub Form_Unload(Cancel As Integer)
If Comm1.PortOpen = True Then   'port must be closed
Comm1.PortOpen = False
End If
End Sub
