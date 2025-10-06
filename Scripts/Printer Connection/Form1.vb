Public Class Form1
    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        txtPrinterName.Text = "PRINTER NAME:"
        txtPrinterName.ForeColor = Color.Gray

    End Sub

    Private Sub txtPrinterName_GotFocus(sender As Object, e As EventArgs) Handles txtPrinterName.GotFocus

        If txtPrinterName.Text = "PRINTER NAME:" Then
            txtPrinterName.Text = ""
            txtPrinterName.ForeColor = Color.Gray
        End If

    End Sub

    Private Sub txtPrinterName_LostFocus(sender As Object, e As EventArgs) Handles txtPrinterName.LostFocus

        If txtPrinterName.Text = "" Then
            txtPrinterName.Text = "PRINTER NAME:"
            txtPrinterName.ForeColor = Color.Gray
        End If

    End Sub
    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles txtPrinterName.TextChanged

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim printerName As String = txtPrinterName.Text.Trim()

        If printerName = "" Then
            MessageBox.Show("Please enter a printer name.")
            Return
        End If

        Dim StartInfo As New ProcessStartInfo()
        StartInfo.FileName = "rundll32.exe"
        StartInfo.Arguments = "printui.dll, PrintUIEntry /in /n ""\\lihprint04\" & printerName & """"
        StartInfo.UseShellExecute = False

        Try
            Process.Start(StartInfo)
            MessageBox.Show("Executing...")
        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try

    End Sub
End Class
