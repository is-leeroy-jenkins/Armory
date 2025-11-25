
Option Compare Database
Option Explicit



Public mReportArgs As BudgetArgs
Public m_Dialog As Form_ReportDialog
Public FundCodeArgs As String
Public RcCodeArgs As String
Public FiscalYearArgs As String
Public DivisionTitleArgs As String
Public AhCodeArgs As String
Public RpioCodeArgs As String
Public PublicLawArgs As String
Public FundTitleArgs As String
Public TreasurySymbolArgs As String
Private m_Error As String







'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Load()
    On Error GoTo ErrorHandler:
    Set mReportArgs = New BudgetArgs
    Set m_Dialog = New Form_ReportDialog
ErrorHandler:
    ProcessError
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
    DoCmd.OpenForm FormName:="ReportDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("ReportDialog")
    Set mReportArgs = m_Dialog.Args
    If Not mReportArgs.FundCode & "" = "" Then
        FundCodeArgs = mReportArgs.FundCode
    End If
    If Not FundCodeArgs & "" = "" Then
        FundTitleArgs = DLookup("Title", "Funds", "Funds.Code = '" & FundCodeArgs & "'")
        TreasurySymbolArgs = DLookup("TreasurySymbol", "Funds", "Funds.Code = '" & FundCodeArgs & "'")
    End If
    RcCodeArgs = mReportArgs.RcCode
    FiscalYearArgs = mReportArgs.BFY
    AhCodeArgs = mReportArgs.AhCode
    RpioCodeArgs = mReportArgs.RPIO
    PublicLawArgs = DLookup("PublicLaw", "Appropriations", "BFY = '" & FiscalYearArgs & "'")
    DivisionTitleArgs = DLookup("Title", "Divisions", "Divisions.Code = '" & RcCodeArgs & "'")
    If Not mReportArgs.FundCode & "" = "" Then
        SQL = "SELECT *" _
        & " FROM DivisionExecution" _
        & " WHERE DivisionExecution.BFY = '" & mReportArgs.BFY & "'" _
        & " AND DivisionExecution.RcCode = '" & mReportArgs.RcCode & "'" _
        & " AND DivisionExecution.FundCode = '" & mReportArgs.FundCode & "'" _
        & " AND DivisionExecution.Available > 0" _
        & " AND DivisionExecution.BocCode IN ('21','28');"
        Me.RecordSource = SQL
        DoCmd.Close ObjectType:=acForm, ObjectName:="ReportDialog"
    End If
    If mReportArgs.FundCode & "" = "" Then
        SQL = "SELECT *" _
        & " FROM DivisionExecution" _
        & " WHERE DivisionExecution.BFY = '" & mReportArgs.BFY & "'" _
        & " AND DivisionExecution.RcCode = '" & mReportArgs.RcCode & "'" _
        & " AND DivisionExecution.Available > 0" _
        & " AND DivisionExecution.BocCode IN ('21','28');"
        Me.RecordSource = SQL
        DoCmd.Close ObjectType:=acForm, ObjectName:="ReportDialog"
    End If
ErrorHandler:
    ProcessError
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

