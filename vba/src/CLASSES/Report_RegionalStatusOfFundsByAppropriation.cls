Option Compare Database
Option Explicit






Public Args As BudgetArgs
Public m_Dialog As Form_FundDialog
Public FundCodeArgs As String
Public RcCodeArgs As String
Public FiscalYearArgs As String
Public DivisionTitleArgs As String
Public AhCodeArgs As String
Public RpioCodeArgs As String
Public PublicLawArgs As String
Public FundTitleArgs As String
Public TreasurySymbolArgs As String
Private pAnd As String
Private m_Error As String





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    pAnd = " AND "
    PublicLawArgs = DLookup("PublicLaw", "Appropriations", "BFY = '2020'")
    Dim SQL As String
    SQL = "SELECT StatusOfFunds.BFY, StatusOfFunds.FundCode, StatusOfFunds.FundName, StatusOfFunds.BocCode," _
        & " StatusOfFunds.BocName, CCur(Sum(StatusOfFunds.Amount)) AS Amount, CCur(Sum(StatusOfFunds.OpenCommitments)) AS OpenCommitments," _
        & " CCur(Sum(StatusOfFunds.Obligations)) AS Obligations, CCur(Sum(StatusOfFunds.Used)) AS Used, CCur(Sum(StatusOfFunds.Available)) AS Available" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.Available > 0" _
        & " AND StatusOfFunds.Amount > 0" _
        & " AND StatusOfFunds.BudgetLevel = '7'" _
        & " GROUP BY StatusOfFunds.BFY, StatusOfFunds.FundCode, StatusOfFunds.FundName," _
        & " StatusOfFunds.BocCode, StatusOfFunds.BocName" _
        & " ORDER BY StatusOfFunds.BFY DESC, StatusOfFunds.FundCode, StatusOfFunds.BocCode;"
    Me.RecordSource = SQL
    Me.Requery
    DoCmd.Close ObjectType:=acForm, ObjectName:="FundDialog"
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


