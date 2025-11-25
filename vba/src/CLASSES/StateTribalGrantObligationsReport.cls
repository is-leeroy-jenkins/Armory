Option Compare Database
Option Explicit



Public Args As AccountArgs
Private m_Dialog As Form_StatusOfFundsDialog
Private m_Error As String
Private m_Notification As String






'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Load()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="StateTribalGrantObligationsReport", _
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Dim SQL As String
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", WindowMode:=acDialog
    Set m_Dialog = New Form_StatusOfFundsDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    Set Args = New AccountArgs
    Set Args = m_Dialog.Args
    If Not Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
            SQL = "SELECT *" _
            & " FROM StatusOfFunds" _
            & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
            & " AND LEFT(StatusOfFunds.FundCode, 1) = 'E'" _
            & " AND StatusOfFunds.RpioName = '" & Args.RpioName & "'"
    End If
    If Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND LEFT(StatusOfFunds.FundCode, 1) = 'E'"
    End If
    If Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND LEFT(StatusOfFunds.FundCode, 1) = 'E'"
    End If
    If Not Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND LEFT(StatusOfFunds.FundCode, 1) = 'E'" _
        & " AND StatusOfFunds.RpioName = '" & Args.RpioName & "'"
    End If
    Me.RecordSource = SQL
    DoCmd.Close ObjectType:=acForm, ObjectName:="StatusOfFundsDialog"
ErrorHandler:
    ProcessError Name:="StateTribalGrantObligationsReport", _
        Member:="Report_Open()"
    Exit Sub
End Sub










'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Process
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcessError(Optional Name As String, Optional Member As String)
    If Err.Number <> 0 And _
        Not IsMissing(Name) And _
        Not IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description _
                & vbCrLf & "Class:      " & Name _
                & vbCrLf & "Member:     " & Member
    End If
    If Err.Number <> 0 And _
        IsMissing(Name) And _
        IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description
    End If
    MessageFactory.ShowError (m_Error)
    Err.Clear
End Sub

