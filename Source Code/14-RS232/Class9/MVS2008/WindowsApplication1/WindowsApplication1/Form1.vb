Public Class Form1

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        SerialPort1.Open()
        SerialPort1.Write("WALID")

        Do

        Loop Until SerialPort1.BytesToRead > 0

        TextBox1.Text = SerialPort1.ReadChar()
        SerialPort1.Close()
    End Sub


End Class

