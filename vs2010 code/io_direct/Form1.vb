Public Class Form1
    Private Sub Form1_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        If sp1.IsOpen Then sp1.Close()
    End Sub

    Private Sub Form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GetPorts()
    End Sub
    Sub GetPorts()
        For Each sp As String In My.Computer.Ports.SerialPortNames ' Show all available COM ports.
            cmb1.Items.Add(sp)
        Next
    End Sub
    Private Sub cmb1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmb1.SelectedIndexChanged
        On Error Resume Next
        sp1.PortName = cmb1.SelectedItem
        sp1.BaudRate = 9600
        sp1.DataBits = 8
        sp1.Open()
        Label2.Text = "Port is Open"
        sp1.RtsEnable = False 'CS high
        sp1.DtrEnable = True      'ADC Clock high.
        Timer1.Enabled = True
    End Sub

    Private Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        If RadioButton4.Checked Then          'Selecting sampling rate
            Timer1.Interval = 1000  '1 second sampling
        ElseIf RadioButton5.Checked Then
            Timer1.Interval = 100
        End If

        If cb1.Checked = True Then sp1.DtrEnable = False
        If cb1.Checked = False Then sp1.DtrEnable = True
        If cb2.Checked = True Then sp1.RtsEnable = False
        If cb2.Checked = False Then sp1.RtsEnable = True
        If sp1.CtsHolding = True Then Panel3.BackColor = Color.Red
        If sp1.DsrHolding = True Then Panel2.BackColor = Color.Red
        If sp1.CtsHolding = False Then Panel3.BackColor = Color.Green
        If sp1.DsrHolding = False Then Panel2.BackColor = Color.Green
    End Sub
End Class
