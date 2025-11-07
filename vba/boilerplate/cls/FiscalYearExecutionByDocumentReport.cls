Option Compare Database
Option Explicit

Public Args As AccountArgs
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
    ProcessError Name:="FiscalYearExecutionByDocumentReport", _
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
    Set Args = New AccountArgs
    Dim SQL As String
    DoCmd.OpenForm FormName:="ReportDialog", WindowMode:=acDialog
    Set m_Dialog = New Form_ReportDialog
    Set m_Dialog = Forms("ReportDialog")
    Set Args = m_Dialog.Args
    If Not Args.FundName = "" Then
        SQL = "SELECT Obligations.*, Allocations.Amount" _
            & " FROM Allocations LEFT JOIN Obligations ON (Allocations.BFY = Obligations.BFY) AND " _
            & " (Allocations.FundCode = Obligations.FundCode) AND (Allocations.AccountCode = Obligations.AccountCode)" _
            & " AND (Allocations.BocCode = Obligations.BocCode) AND (Allocations.RcCode = Obligations.RcCode)" _
            & " WHERE Not IsNull(Obligations.DocumentControlNumbers)" _
            & " AND Obligations.Used > 0" _
            & " AND Obligations.FundName = '" & Args.FundName & "'" _
            & " AND Obligations.RcCode = '" & Args.RcCode & "'" _
            & " AND Obligations.BFY = '" & Args.BFY & "'" _
            & " ORDER BY Obligations.BocCode, Obligations.DocumentControlNumbers;"
    End If
    If Args.FundName & "" = "" Then
        SQL = "SELECT Obligations.*, Allocations.Amount" _
            & " FROM Allocations LEFT JOIN Obligations ON (Allocations.BFY = Obligations.BFY) AND " _
            & " (Allocations.FundCode = Obligations.FundCode) AND (Allocations.AccountCode = Obligations.AccountCode)" _
            & " AND (Allocations.BocCode = Obligations.BocCode) AND (Allocations.RcCode = Obligations.RcCode)" _
            & " WHERE Not IsNull(Obligations.DocumentControlNumbers)" _
            & " AND Obligations.Used > 0" _
            & " AND Obligations.RcCode = '" & Args.RcCode & "'" _
            & " AND Obligations.BFY = '" & Args.BFY & "'" _
            & " ORDER BY Obligations.BocCode, Obligations.DocumentControlNumbers;"
    End If
    Me.RecordSource = SQL
    DoCmd.Close ObjectType:=acForm, ObjectName:="ReportDialog"
ErrorHandler:
    ProcessError Name:="FiscalYearExecutionByDocumentReport", _
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




